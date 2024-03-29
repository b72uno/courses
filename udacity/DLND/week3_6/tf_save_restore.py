import tensorflow as tf

# The file path to save the data
save_file = './model.ckpt'

# Two Tensor Variables: weights and bias
weights = tf.Variable(tf.truncated_normal([2, 3]))
bias = tf.Variable(tf.truncated_normal([3]))

# Class used to save and/or restore Tensor Variables
saver = tf.train.Saver()

with tf.Session() as sess:
    # Initialzie all the variables
    sess.run(tf.global_variables_initializer())

    # Show the values of weights and bias
    print("Weights: ")
    print(sess.run(weights))
    print("Bias: ")
    print(sess.run(bias))

    # Save the model
    saver.save(sess, save_file)
    print("Weights and biases saved")
    print("----------------------")

# Loading Variables
# Remove the previous weights and bias
tf.reset_default_graph()

# Two Variables: weights and bias
weights = tf.Variable(tf.truncated_normal([2,3]))
bias = tf.Variable(tf.truncated_normal([3]))

# Class used to save and/or restore Tensor Variables
saver = tf.train.Saver()

with tf.Session() as sess:
    # Load the weights and bias
    # Also sets all the TensorFlow Variables, so no need
    # to call tf.global_variables_initializer
    saver.restore(sess, save_file)

    # Show the values of weights and bias
    print("Weights and biases restored: ")
    print("Weights: ")
    print(sess.run(weights))
    print("Bias: ")
    print(sess.run(bias))
