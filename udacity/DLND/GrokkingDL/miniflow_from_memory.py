import numpy as np

class Node:
    # Base class for nodes in the network
    def __init__(self, inbound_nodes=[]):
        # A list of nodes with edges in to this node
        self.inbound_nodes = inbound_nodes
        # The eventual value of the node, set by forward pass
        self.value = None
        # A list of nodes that this node outputs to
        self.outbound_nodes = []
        # Dict with inputs as keys and their values
        # are partials of this node with respect to that input
        self.gradients = {}
        # Set this node as outbound node for all of
        # this nodes inputs
        for node in inbounds_nodes:
            node.outbound_nodes.append(self)

    def forward(self):
        " Forward pass"
        raise NotImplementedError

    def backward(self):
        raise NotImplementedError


class Input(Node):
    " A generic input into the network"
    def __init__(self):
        Node.__init__(self)

    def forward(self):
        pass

    def backward(self):
        # No inputs so the gradient is 0
        self.gradients = {self: 0}

        # Weights and bias may be inputs
        # So you need to sum the gradinet from the output
        # gradients
        for node in self.outbound_nodes:
            self.gradients[self] += node.gradients[self]


class Linear(Node):
    " Calculate linear transform"
    def __init__(self, X, W, b):
        # Weights and biases treated like input nodes
        Node.__init__(self, [X, W, b])

    def forward(self):
        inputs = self.inbound_nodes[0].value
        weights = self.inbound_nodes[1].value
        bias = self.inbound_nodes[2].value
        self.value = np.dot(inputs, weights) + bias

    def backward(self):
        # Initialize partial for each inbound nodes
        self.gradients = {n: np.zeros_like(n.value) for n in self.inbound_nodes}

        # Cycle through the outputs. The gradient will change
        # Depending on each output, so the gradinents are summed over all inputs
        for n in self.outbound_nodes:
            # Get the partial of the cost with respect to this node
            grad_cost = n.gradients[self]
            # Set the partial of the loss with respect to this nodes inputs
            self.gradients[self.inbound_nodes[0]] += np.dot(grad_cost, self.inbound_nodes[1].value.T)
            # Set the partial of the loss with respect to this nodes weights
            self.gradients[self.inbound_nodes[1]] += np.dot(grad_cost, self.inbound_nodes[0].value.T, grad_cost)
            # Set the partial of the loss with respect to this nodes bias
            self.gradients[self.inbound_nodes[2]] += np.sum(grad_cost, axis=0, keepdims=False)


class Sigmoid(Node):
    """
    A node that performs the sigmoid activation function
    """
    def __init__(self, node):
        # The base class constructor
        Node.__init__(self, [node])

    def _sigmoid(self, x):
        "Separate from forward, because used in backward as well"
        return 1. / (1. + np.exp(x))

    def forward(self):
        "Perform sigmoid and set value"
        input_value = self.inbound_nodes[0].value
        self.value = self._sigmoid(input_value)

    def backward(self):
        " Calculate the gradient using the derivative of sigmoid"
        # Initialize gradients to 0
        self.gradients = {n: np.zeros_like(n.value) for n in self.inbound_nodes}
        # Sum the partial with respect to the input over all the inputs
        for n in self.outbound_nodes:
            grad_cost = n.gradients[self]
            sigmoid = self.value
            self.gradients[self.inbound_nodes[0]] += sigmoid * (1 - sigmoid) * grad_cost


class MSE(Node):
    """
    Calculates Mean square Error cost function
    """
    def __init__(self, y, a):
        Node.__init__(self, [y, a])

    def forward(self):
        # reshape to avoid broadcast errors
        y = self.inbound_nodes[0].value.reshape(-1, 1)
        a = self.inbound_nodes[1].value.reshape(-1, 1)

        self.m = self.inbound_nodes[0].value.shape[0]

        # Save the computed output for a backward
        self.diff = y - a
        self.value = np.mean(self.diff**2)

    def backward(self):
        self.gradients[self.inbound_nodes[0]] = (2 / self.m) * self.diff
        self.gradients[self.inbound_nodes[1]] = (-2 / self.m) * self.diff


def topological_sort(feed_dict):
    " Sort the nodes by Kahns Algorithm"
    input_nodes = [n for n in feed_dict.keys()]

    G = {}
    nodes = [n for n in input_nodes]
    while len(nodes) > 0:
        n = nodes.pop(0)
        if n not in G:
            G[n] = {'in': set(), 'out': set()}
        for m in n.outbound_nodes:
            if m not in G:
                G[m] = {'in': set(), 'out': set()}
            G[n]['out'].add(m)
            G[n]['in'].add(n)
            nodes.append(m)

        L = []
        S = set(input_nodes)
        while len(S) > 0:
            n = S.pop()

            if isinstance(n, Input):
                n.value = feed_dict[n]

            L.append(n)
            for m in n.outbound_nodes:
                G[n]['out'].remove(m)
                G[m]['in'].remove(n)
                # If no other incoming edges, add to S
                if len(G[m]['in']) == 0:
                    S.add(m)
        return L


def forward_and_backward(graph):
    for n in graph:
        n.forward()

    for n in graph[::-1]:
        n.backward()

def sgd_update(trainables, learning_rate=1e-2):
    for t in trainables:
        partial = t.gradients[t]
        t.value -= learning_rate * partial

