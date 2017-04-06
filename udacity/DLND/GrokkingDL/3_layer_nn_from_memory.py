# A neural network a day keeps stupid away
import numpy as np

np.random.seed(1)

inputs = np.array([[0, 0, 0],
                   [1, 0, 1],
                   [1, 1, 0],
                   [0, 0, 1]])

outputs = np.array([[1,1,0,0]]).T


input_size = 3
hidden_size = 4
output_size = 1

alpha = 0.2
epochs = 60

def relu(x):
    return (x > 0) * x

def relu2deriv(x):
    return x > 0


weights_0_1 = 2 * np.random.random((input_size, hidden_size)) - 1
weights_1_2 = 2 * np.random.random((hidden_size, output_size)) - 1


for e in range(epochs):
    layer_2_error = 0
    for i in range(len(inputs)):
        layer_0 = inputs[i:i+1]
        layer_1 = relu(np.dot(layer_0, weights_0_1))
        layer_2 = np.dot(layer_1, weights_1_2)

        layer_2_error = np.sum((layer_2 - outputs[i:i+1]) ** 2)
        layer_2_delta = layer_2 - outputs[i:i+1]

        layer_1_delta = np.dot(layer_2_delta, weights_1_2.T)
        layer_1_delta *= relu2deriv(layer_1)

        weights_1_2_delta = np.dot(layer_1.T, layer_2_delta) * alpha
        weights_0_1_delta = np.dot(layer_0.T, layer_1_delta) * alpha

        weights_1_2 -= weights_1_2_delta
        weights_0_1 -= weights_0_1_delta

    if e % 10 == 9:
        print("Error: {}".format(layer_2_error))



