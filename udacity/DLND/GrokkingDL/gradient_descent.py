input = 1
weight = 0.8
goal_pred = 2.5
alpha = 0.5

for i in range(25):
    pred = input * weight
    error = (pred - goal_pred) ** 2
    delta = pred - goal_pred
    weight_delta = input * delta * alpha
    weight = weight - weight_delta

    print("--------------------")
    print("Prediction:" + str(pred))
    print("Error:" + str(error))
    print("Delta:" + str(delta))
    print("Weight Delta:" + str(weight_delta))
    print("Updated weight:" + str(weight))
