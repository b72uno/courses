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
                # Set steering angle to average angle
                Rover.steer = np.clip(np.mean(Rover.nav_angles*180/np.pi), -15, 15)

            # If terrain not navigable, go to stop mode
            elif len(Rover.nav_angles) < Rover.stop_forward:
                Rover.throttle = 0

                Rover.brake = Rover.brake_set
                Rover.steer = 0
                Rover.mode = 'stop'

            # If already in "stop" mode then make different decisions
        elif Rover.mode == 'stop':
            # If in stop mode but still moving, keep braking
            if Rover.vel > 0.2:
                Rover.throttle = 0
                Rover.brake = Rover.brake_set
                Rover.steer = 0
                # If not moving (vel < 0.2), then do something else
            elif Rover.vel <= 0.2:
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
