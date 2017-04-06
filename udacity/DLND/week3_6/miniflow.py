class Node(object):
    def __init__(self, inbound_nodes=[]):
        print("Im a Node calling Init, setting my inbound node to {}".format(inbound_nodes))
        # Receive inbound values
        self.inbound_nodes = inbound_nodes
        self.outbound_nodes = []

        # for each inbound node add this node as
        # an outbound node to _that_ node
        for n in self.inbound_nodes:
            print("Appending inbound node to outbound nodes")
            n.outbound_nodes.append(self)

        # Calcuated value
        print("Setting my Value to None")
        self.value = None


    def forward(self):
        """
        Forward propagation

        Compute the output value based on 'inbound_nodes' and
        store the result in self.value
        """
        print("Nodes forward is called")
        raise NotImplemented


class Input(Node):
    def __init__(self):
        # An input node has no inbound n
        print("Init from Input")
        Node.__init__(self)

    # NOTE: Input node is the only node where the value
    # may be passed as an argument to forward()
    #
    # All other node implementations should get the value
    # of the previous node from self.inbound_nodes
    #
    # Example:
    # val10 = self.inbound_nodes[0].value
    def forward(self, value=None):
        print("Inits forward being called")
        if value is not None:
            print("setting value to {}".format(value))
            self.value = value


class Add(Node):
    def __init__(self, x, y):
        Node.__init__(self, [x, y])

    def forward(self):
        """
        Forward pass

        """
        self.value = sum([x.value for x in self.inbound_nodes])
        print("Adds forward being called, setting my value to {}".format(self.value))


def topological_sort(feed_dict):
    """
    Sort generic nodes in topological order using
    Khan's Algorithm. 'feed_dict': A dictionary where
    key is a `Input` node and the value is the
    respective value feed to that node.
    Returns a list of sorted nodes.
    """
    input_nodes = [n for n in feed_dict.keys()]
    G = {}
    nodes = [n for n in input_nodes]
    while len(nodes) > 0:
        n = nodes.pop(0)
        if n not in G:
            G[n] = {'in':set(), 'out':set()}
        for m in n.outbound_nodes:
            if m not in G:
                G[m] = {'in':set(), 'out':set()}
            G[n]['out'].add(m)
            G[m]['in'].add(n)
            nodes.append(m)
        print("{} IN: {}, {} OUT: {}".format(n, G[n]['in'],n, G[n]['out']))

    L = []
    S = set(input_nodes)
    while len(S) > 0:
        n = S.pop()

        if isinstance(n, Input):
            n.value = feed_dict[n]
            print("Setting the value to {}".format(n.value))

        L.append(n)
        for m in n.outbound_nodes:
            G[n]['out'].remove(m)
            G[m]['in'].remove(n)
            # if no other incoming edges add to S
            if len(G[m]['in']) == 0:
                S.add(m)
    return L


def forward_pass(output_node, sorted_nodes):
    """
    Performs a forward pass through a list of sorted nodes.

    Arguments:
        `output_node`: A node in the graph, should be the output node (have no outgoing edges)
        `sorted_nodes`: A topologically sorted list of nodes
    Returns the output Node`s value
    """

    for n in sorted_nodes:
        n.forward()

    return output_node.value


x, y = Input(), Input()

f = Add(x, y)

feed_dict = {x: 10, y: 5}

sorted_nodes = topological_sort(feed_dict)
output = forward_pass(f, sorted_nodes)

# NOTE: because topological_sort set the values for the `Input` nodes we could also access
# the value for x with x.value (same goes for y).
print("{} + {} = {} (according to miniflow)".format(feed_dict[x], feed_dict[y], output))
