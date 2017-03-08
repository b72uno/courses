# -*- coding: utf-8 -*-
"""
Implementing gradient descent
Follows Lesson#13 in 'Intro to Neural Networks'
Udacity Deep Learning Nanodegree
"""

import numpy as np
import pandas as pd

def run():
    admissions = pd.read_csv('binary.csv')

    # Make dummy variables for rank
    data = pd.concat([admissions, pd.get_dummies(admissions['rank'], prefix='rank')], axis=1)
    data = data.drop('rank', axis=1)

    # Standardize features
    for field in ['gre', 'gpa']:
        mean, std = data[field].mean(), data[field].std()
        data.loc[:, field] = (data[field]-mean)/std

    # Split off random 10% of the data for testing
    np.random.seed(42)
    sample = np.random.choice(data.index, size=int(len(data)*0.9), replace=False)
    data, test_data = data.ix[sample], data.drop(sample)

    # Split into targets and features
    features, targets = data.drop('admit', axis=1), data['admit']
    features_test, targets_test = test_data.drop('admit', axis=1), test_data['admit']

    def sigmoid(x):
        """
        Calculate sigmoid
        """
        return 1 / (1 + np.exp(-x))

    # Use to same seed to make debugging easier
    np.random.seed(42)

    n_records, n_features = features.shape
    last_loss = None

    #Initialize weights
    weights = np.random.normal(scale=1 / n_features**0.5, size=n_features)

    # Neural Network hyperparameters
    epochs = 1000
    learn_rate = 0.5

    for e in range(epochs):
        del_w = np.zeros(weights.shape)
        for x,y in zip(features.values, targets):
            # Loop through all records x is the input, y is the target

            # Calculate the output
            output = sigmoid(np.dot(x,weights))

            # Calculate the error
            error = y - output

            # Calculate change in weights
            del_w += error * output * (1 - output) * x

        # Update weights
        weights += learn_rate * del_w / n_records

        # printing out the mean square error on the training set
        if e % (epochs / 10) == 0:
            out = sigmoid(np.dot(features, weights))
            loss = np.mean((out - targets) ** 2)
            if last_loss and last_loss < loss:
                print("Train loss: ", loss, " Warning - Loss increasing")
            else:
                print("Train loss: ", loss)
            last_loss = loss

    # Calculate accuracy on test data
    tes_out = sigmoid(np.dot(features_test, weights))
    predictions = tes_out > 0.5
    accuracy = np.mean(predictions == targets_test)
    print("Prediction accuracy: {:.3f}".format(accuracy))





if __name__ == '__main__':
    run()
