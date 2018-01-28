import numpy as np

def decision_step(Rover):

    # Check for vision
    if Rover.nav_angles is not None:

        if Rover.mode == 'forward':

            # Check the extent of navigable terrain
            if len(Rover.nav_angles) >= Rover.stop_forward:
                # If mode is forward, and terrain looks good
                if Rover.vel < Rover.max_vel:
                    # set throttle to throttle setting
                    Rover.throttle = Rover.throttle_set
                else:
                    # else coast
                    Rover.throttle = 0
                Rover.brake = 0

                Rover.ddata = Rover.sample_angles.any()
                # Check if we see any samples
                if Rover.sample_angles.any():
                    # If so, bias the steering angle towards the sample
                    sample_angle = np.clip(np.mean(Rover.sample_angles*180/np.pi), -15, 15) * 0.7
                    nav_angle = np.clip(np.mean(Rover.nav_angles*180/np.pi), -15, 15) * 0.3
                    Rover.steer = sample_angle + nav_angle

                else:
                    # Otherwise set steering angle to average angle
                    Rover.steer = np.clip(np.mean(Rover.nav_angles*180/np.pi), -15, 15)
                    bias = Rover.steering_bias
                    Rover.steer = np.clip(Rover.steer + bias, -15, 15)

                if Rover.near_sample:
                    Rover.brake = Rover.brake_set
                    Rover.steer = 0
                    Rover.mode = 'stop'

            # If terrain not navigable, go to stop mode
            elif len(Rover.nav_angles) < Rover.stop_forward:
                Rover.throttle = 0

                Rover.brake = Rover.brake_set
                Rover.steer = 0
                Rover.mode = 'stop'

            # Keep a log to check if stuck
            total_time = np.int32(Rover.total_time)
            idx = ((total_time + 1) % Rover.log_len)
            prev_idx = idx - 1
            Rover.pos_log[idx] = np.asarray(Rover.pos)

            # Check every n seconds if we are moving
            if total_time % 2 == 0:
                get_delta = lambda x,y: np.linalg.norm(Rover.pos_log[x] -  Rover.pos_log[y])
                if get_delta(idx, prev_idx) < 0.01 and Rover.mode == 'forward':
                    Rover.mode = 'stuck'
                else:
                    Rover.mode = 'forward'

        elif Rover.mode == 'stuck':
            Rover.throttle = 0
            # Release brake to allow turning
            Rover.brake = 0
            # Turn range is +- 15 degrees, when stopped the next line will induce
            # 4-wheel turning
            Rover.steer = -15 # Could be more clever way about which way to turn
            # resume trying to go forward
            Rover.mode = 'forward'

            # If already in "stop" mode then make different decisions
        elif Rover.mode == 'stop':

            # If in stop mode but still moving, keep braking
            if Rover.vel > 0.2:
                Rover.throttle = 0
                Rover.brake = Rover.brake_set
                Rover.steer = 0

            # If not moving (vel < 0.2), then do something else
            elif Rover.vel <= 0.2 and not Rover.near_sample:
                # Check to see if there is a path forward
                if len(Rover.nav_angles) < Rover.go_forward:
                    Rover.throttle = 0
                    # Release brake to allow turning
                    Rover.brake = 0
                    # Turn range is +- 15 degrees, when stopped the next line will induce
                    # 4-wheel turning
                    Rover.steer = -15 # Could be more clever way about which way to turn

                # If stopped, but sufficient terrain, then go!
                if len(Rover.nav_angles) >= Rover.go_forward:
                    # Set throttle back to stored value
                    Rover.throttle = Rover.throttle_set
                    # Release the brake
                    Rover.brake = 0
                    # Set steer to mean angle
                    Rover.steer = np.clip(np.mean(Rover.nav_angles*180/np.pi), -15, 15)
                    Rover.mode = 'forward'


    # Just to make the rover do something
    # even if no modifications have been made
    else:
        Rover.throttle = Rover.throttle_set
        Rover.steer = 0
        Rover.brake = 0

    # If in a state where want to pick up a rock and send pickup command
    if Rover.near_sample and Rover.vel == 0 and not Rover.picking_up:
        Rover.send_pickup = True

    return Rover
