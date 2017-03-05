from numpy import *


def compute_error_for_line_given_points(b, m, points):
    # error(m,b) = 1/n sigma i=1 to n (y_i - (mx_i + b))^2

    #initialize the error at 0
    totalError = 0

    # for every point
    for i in range(0, len(points)):
        # get the x value
        x = points[i, 0]
        # get the y value
        y = points[i, 1]
        #get the difference, square and add to the total
        totalError += (y - (m * x + b)) ** 2

    # get the average
    return totalError / float(len(points))

# magic, the great greatest what about garbage
def step_gradient(b_current, m_current, points, learning_rate):
    # local minima = smallest error

    # starting points for our gradient (gradient = slope)
    b_gradient = 0
    m_gradient = 0

    n = float(len(points))

    for i in range(0, len(points)):
        x = points[i, 0]
        y = points[i, 1]

        # direction with respect to b and m

        # computing partial derivatives of our error function
        # for every single point we have
        # with respect to b and m

        # look up partial derivative formula
        # for b = 2 / n sigma i=1 to n -(y_i - (mx_i + b))
        # for m = 2 / n sigma i=1 to n -x_i (y_i - (mx_i + b))
        b_gradient += -(2/n) * (y - ((m_current * x) + b_current))
        m_gradient += -(2/n) * x * (y - ((m_current * x) + b_current))

    # update b and m values using partial derivatives
    new_b = b_current - (learning_rate * b_gradient)
    new_m = m_current - (learning_rate * m_gradient)

    return [new_b, new_m]


def gradient_descent_runner(points, starting_b, starting_m, learning_rate, num_iterations):
    # starting b and m
    b = starting_b
    m = starting_m

    # gradient descent
    for i in range(num_iterations):
        # update b and m with the new, more accurate b and m by performing gradient step

        # gradient step
        b, m = step_gradient(b, m, array(points), learning_rate)

    return [b, m]

def run():
    # Step 1 - collect our data
    points = genfromtxt('data.csv', delimiter=',')

    # Step 2 - define our hyperparameters

    # how fast should our model converge?
    learning_rate = 0.0001

    # y = mx + b
    initial_b = 0
    initial_m = 0

    # how much do we train the model?
    num_iterations = 1000

    # Step 3 - train our model

    #print our starting point
    print('starting gradient descent at b = {0}, m = {1}, error = {2}'.format(initial_b, initial_m, compute_error_for_line_given_points(initial_b, initial_m, points)))

    # perform gradient descent, will give us optimal slope and y intercept
    [b, m] = gradient_descent_runner(points, initial_b, initial_m, learning_rate, num_iterations)

    #print our ending point
    print('ending gradient descent at b = {0}, m = {1}, error = {2}'.format(b, m, compute_error_for_line_given_points(b, m, points)))


if __name__ == '__main__':
    run()
