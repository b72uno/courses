# Copyright (C) 2017 Udacity Inc.
# All Rights Reserved.

# Author: Brandon Kinman


class PIDController:
    def __init__(self, kp = 0.0, ki = 0.0, kd = 0.0, max_windup = 10):
        self.kp_ = float(kp)
        self.ki_ = float(ki)
        self.kd_ = float(kd)
        self.max_windup_ = float(max_windup)

        self.last_timestamp_ = 0.0
        self.set_point_ = 0.0
        self.start_time_ = 0.0
        self.error_sum_ = 0.0
        self.last_error_ = 0.0

        # Control effor history
        # self.u_p = [0]
        # self.u_i = [0]
        # self.u_d = [0]

    def reset(self):
        self.kp_ = 0.0
        self.ki_ = 0.0
        self.kd_ = 0.0

        self.last_timestamp_ = 0.0
        self.set_point_ = 0.0
        self.start_time_ = 0.0
        self.error_sum_ = 0.0
        self.last_error_ = 0.0

    def setTarget(self, target):
        self.set_point_ = float(target)

    def setKP(self, kp):
        self.kp_ = float(kp)

    def setKI(self, ki):
        self.ki_ = float(ki)

    def setKD(self, kd):
        self.kd_ = float(kd)

    def setMaxWindup(self, max_windup):
        self.max_windup_ = int(max_windup)

    def update(self, measured_value, timestamp):
        delta_time = timestamp - self.last_timestamp_
        if delta_time == 0:
            return 0

        error = self.set_point_ - measured_value
        self.last_timestamp_ = timestamp
        self.error_sum_ += error * delta_time
        delta_error = error - self.last_error_
        self.last_error_ = error

        # Limit max windup
        if self.error_sum_ > self.max_windup_:
            self.error_sum_ = self.max_windup_
        elif self.error_sum_ < -self.max_windup_:
            self.error_sum = -self.max_windup_

        # Proportional error
        p = self.kp_ * error

        # Integral error
        i = self.ki_ * self.error_sum_

        # Derivative error
        # No noise, no smoothing
        d = self.kd_ * (delta_error / delta_time)

        # Control effort
        # No saturation limit
        u = p + i + d

        # # History
        # self.u_p.append(p)
        # self.u_i.append(i)
        # self.u_d.append(d)

        return u

