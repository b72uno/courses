## Project: Search and Sample Return
---


###**The goals / steps performed:**

**Training / Calibration**
- [X] Download the simulator and take data in "Training mode"
- [X] Test out the functions in the Jupyter Notebook provided
- [X] Add functions to detect obstacles and samples of interest
- [X] Fill in the `process_image()` function with the appropriate image processing steps (perspective transfor, color threshold etc.) to get from raw images to a map. The `output_image` you create in this step should demonstrate that your mapping pipeline works.
- [X] Use `moviepy` to process the images in your saved dataset with the `process_image()` function. Include the video you produce as a part of your submission


**Autonomous Navigation / Mapping**

- [X] Fill in the `perception_step()` function within the `perception.py` script with the appropriate image processing functions to create a map and update `Rover()` data (similar to what you did with `process_image()` in the notebook). 
- [X] Fill in the `decision_step()` function within the `decision.py` script with conditional statements that take into consideration the outputs of the `perception_step()` in deciding how to issue throttle, brake and steering commands. 
- [X] Iterate on your perception and decision function until your rover does a reasonable (need to define metric) job of navigating and mapping.  

## [Rubric](https://review.udacity.com/#!/rubrics/916/view) Points
### Here I will consider the rubric points individually and describe how I addressed each point in my implementation.  

---
### Writeup / README

#### 1. Provide a Writeup / README that includes all the rubric points and how you addressed each one.  You can submit your writeup as markdown or pdf.  

You're reading it!

### Notebook Analysis
#### 1. Run the functions provided in the notebook on test images (first with the test data provided, next on data you have recorded). Add/modify functions to allow for color selection of obstacles and rock samples.

The first thing I modified was Color Thresholding function - it now accepts an additional argument, which specifies an operator for the threshold input. 

```python
 def color_thresh(img, rgb_thresh=(160, 160, 160), cmp_op=False):
    # Single channel of img shaped zeros
    color_select = np.zeros_like(img[:,:,0])
    
    # separate channels
    img_r = img[:,:,0]
    img_g = img[:,:,1]
    img_b = img[:,:,2]
    
    r, g, b = rgb_thresh
    
    # Default to above thresh
    if not cmp_op:
        cmp_op = operator.gt
    
    # Compare each pix to thresh
    thresh = (cmp_op(img_r, r) \
              & cmp_op(img_g, g) \
              & cmp_op(img_b, b))
        
    color_select[thresh] = 1
    
    return color_select
```

Following the hints/suggestions, I opted for OpenCV usage for sample detection (adapted from the [link provided](http://opencv-python-tutroals.readthedocs.io/en/latest/py_tutorials/py_imgproc/py_colorspaces/py_colorspaces.html)) and obstacles are just inverted terrain using bitwise XOR. 

```python
def color_thresh_terrain(img):
    return color_thresh(img, (160,160,160))

def color_thresh_obstacles(img):
    return color_thresh_terrain(img) ^ 1

def color_thresh_samples(img):
    hsv = cv2.cvtColor(img, cv2.COLOR_RGB2HSV)
    
    lower_yellow = np.array([20, 100, 100])
    upper_yellow = np.array([30, 255, 255])
    
    mask = cv2.inRange(hsv, lower_yellow, upper_yellow)
    
    return mask
```

Applying the color thresholding functions to a sample image, seems to output an acceptable result:
![color_thresholding](./misc/color_thresholding.png)


#### 1. Populate the `process_image()` function with the appropriate analysis steps to map pixels identifying navigable terrain, obstacles and rock samples into a worldmap.  Run `process_image()` on your test data using the `moviepy` functions provided to create video output of your result. 

The `process_image()` function I modified accordingly:
- [X] 1) Define source and destination points for perspective transform. These were known from the lessons earlier.
 ```python
 # Define a calibration box in source (actual) and destination (desired) coordinates
    # The source and destination points are defined to warp the image to a grid
    # where each 10x10 pixel square represents 1 square meter
    # The destination box will be 2 * dst_size on each side
    dst_size = 5

    # Set a bottom offset - bottom offset is in front of the rover a bit
    bottom_offset = 5
    
    image = img
    source = np.float32([[14, 140], [301 ,140], [200, 96], [118, 96]])
    destination = np.float32([[image.shape[1]/2 - dst_size, image.shape[0] - bottom_offset],
                  [image.shape[1]/2 + dst_size, image.shape[0] - bottom_offset],
                  [image.shape[1]/2 + dst_size, image.shape[0] - 2*dst_size - bottom_offset], 
                  [image.shape[1]/2 - dst_size, image.shape[0] - 2*dst_size - bottom_offset],
                  ])
 ```
 - [X] 2) Apply color threshold - I chose to do thresholding first, perspective transform afterwards.
```python
    terrain = color_thresh_terrain(img)
    obstacles = color_thresh_obstacles(img)
    samples = color_thresh_samples(img)
```
- [X] 3) Apply perspective transform using the functions defined earlier.

```python
    warped_terrain = perspect_transform(terrain, source, destination)
    warped_obstacles = perspect_transform(obstacles, source, destination)
    warped_samples = perspect_transform(samples, source, destination)
```

- [X] 4) Converting thresholded image pixel values to rover-centric coords.
```python
    rover_centric_terrain = rover_coords(warped_terrain)
    rover_centric_obstacles = rover_coords(warped_obstacles)
    rover_centric_samples = rover_coords(warped_samples)
    
```
- [X] 5) Converting rover-centric pixel values to world coordinates. Defined a helper function, dry and all.

```python
    scale = 10
    # pix_to_world(xpix, ypix, xpos, ypos, yaw, world_size, scale)
    def px2world(rov_coords): 
        return pix_to_world(rov_coords[0], rov_coords[1], data.xpos[data.count], 
                                data.ypos[data.count], data.yaw[data.count], 
                                data.worldmap.shape[0], scale)
    world_terrain = px2world(rover_centric_terrain)
    world_obstacles = px2world(rover_centric_obstacles)
    world_samples = px2world(rover_centric_samples)
```
- [X] 6) Updating worldmap to be displayed on right side of screen. Updating terrain and obstacles, and samples, if we happen to have any. Code is mostly from the Walkthrough video, as I was struggling to get the samples right.

```python
    data.worldmap[world_obstacles[1], world_obstacles[0], 0] += 1
    data.worldmap[world_terrain[1], world_terrain[0], 2] += 10

    if samples.any():
        
        sample_dist, sample_angles = to_polar_coords(rover_centric_samples[0],
                                                     rover_centric_samples[1])
        sample_idx = np.argmin(sample_dist)
        sample_cX = world_samples[0][sample_idx]
        sample_cY = world_samples[1][sample_idx]
        
        data.worldmap[np.int_(sample_cY), np.int_(sample_cX), 1] = 255
```
- [X] 7) Make a mosaic image. The only code I changed for this step was adding rover "vision" image to the lower right side of the screen:

```python
    img_x = img.shape[0]
    img_y = img.shape[1]
    output_image[-img_x:, img_y:, 2] = warped_terrain * 255
    output_image[-img_x:, img_y:, 0] = warped_obstacles * 255
    output_image[-img_x:, img_y:, 1] = warped_samples * 255
```

Output file from recorded data:

![notebook-rover](./output/test_mapping.mp4)

### Autonomous Navigation and Mapping

#### 1. Fill in the `perception_step()` (at the bottom of the `perception.py` script) and `decision_step()` (in `decision.py`) functions in the autonomous mapping scripts and an explanation is provided in the writeup of how and why these functions were modified as they were.

##### `perception.py`

The code in `perception_step()` follows the same sequence and code as in jupyter notebook (above), with the only difference of  getting the rover camera image, position and yaw angle, and updating Rover vision_image between steps:

```python
# Apply the above functions in succession and update the Rover state accordingly
def perception_step(Rover):

    # Get the current camera image
    img = Rover.img
    rover_x = Rover.pos[0]
    rover_y = Rover.pos[1]
    rover_yaw = Rover.yaw

    # 1) Define source and destination points for perspective transform
    # Source and destination points for perceptive transform
    # The destination box will be 2*dst_size on each side
    dst_size = 5

    # Bottom offset in front of the rover
    bottom_offset = 5

    source = np.float32([[14, 140], [301, 140], [200, 96], [118, 96]])
    destination = np.float32([[img.shape[1]/2 - dst_size, img.shape[0] - bottom_offset],
                              [img.shape[1]/2 + dst_size, img.shape[0] - bottom_offset],
                              [img.shape[1]/2 + dst_size, img.shape[0] - 2*dst_size - bottom_offset],
                              [img.shape[1]/2 - dst_size, img.shape[0] - 2*dst_size - bottom_offset],
                              ])

    # 2) Applying threshold before transform
    terrain = color_thresh_terrain(img)
    obstacles = color_thresh_terrain(img) ^ 1
    samples = color_thresh_samples(img)

    # 3) Apply perspective transform
    warped_terrain = perspect_transform(terrain, source, destination)
    warped_obstacles = perspect_transform(obstacles, source, destination)
    warped_samples = perspect_transform(samples, source, destination)

    warped_terrain = mask_image(warped_terrain)
    warped_obstacles = mask_image(warped_obstacles)

    # 4) Update Rover.vision_image (left side of the screen)
    # e.g. Rover.vision_image[:,:,0]
    Rover.vision_image[:,:,0] = warped_obstacles * 255
    Rover.vision_image[:,:,2] = warped_terrain * 255
    Rover.vision_image[:,:,1] = warped_samples * 255

    # 5) Convert map image pixel values to rover-centric coords
    rover_centric_terrain = rover_coords(warped_terrain)
    rover_centric_obstacles = rover_coords(warped_obstacles)
    rover_centric_samples = rover_coords(warped_samples)

    # 6) Convert rover-centric pixel values to world coordinates
    scale = 2 * dst_size
    worldmap_size = Rover.worldmap.shape

    def px2world(xy):
        return pix_to_world(xy[0], xy[1], rover_x, rover_y, rover_yaw, worldmap_size[0], scale)

    world_terrain = px2world(rover_centric_terrain)
    world_obstacles = px2world(rover_centric_obstacles)
    world_samples = px2world(rover_centric_samples)
```

Following the hints, for increased fidelity, I defined an additional helper function `is_near_zero()` to determine whether the pitch and roll angles are near zero. Before updating the worldmap, we check whether both the roll and pitch angles are near zero, and rover is not picking up any samples. Otherwise we do not update the worldmap.

```python
    # 7) Update Rover worldmap (to be displayed on the right side of the screen)
    def is_near_zero(val, eps=0.5):
        return val < eps or abs(val-360.0) < eps

    if is_near_zero(Rover.pitch) and is_near_zero(Rover.roll) and not Rover.picking_up:
        Rover.worldmap[world_terrain[1], world_terrain[0], 2] += 10
        Rover.worldmap[world_obstacles[1], world_obstacles[0], 0] += 1
```

Additionally, I modified `RoverState()` class to record `sample_dists` and `sample_angles` for later use in `decision_step()`.

```python
    if samples.any():
        Rover.sample_dists, Rover.sample_angles = to_polar_coords(rover_centric_samples[0],
                                                     rover_centric_samples[1])
        if Rover.sample_dists.any():
            sample_idx = np.argmin(Rover.sample_dists)
            sample_cX = world_samples[0][sample_idx].astype(np.int)
            sample_cY = world_samples[1][sample_idx].astype(np.int)

            Rover.worldmap[sample_cY, sample_cX, 1] = 255
            Rover.vision_image[:, :, 1] = warped_samples * 255
    else:
        Rover.vision_image[:, :, 1] = 0

    # 8) Convert rover-centric pixel positions to polar coordinates
    # Update Rover pixel distances and angles
    # Rover.nav_dists = rover_centric_pixel_distances
    # Rover.nav_angles = rover_centric_angles
    Rover.nav_dists, Rover.nav_angles = to_polar_coords(rover_centric_terrain[0],
                                                        rover_centric_terrain[1])


    return Rover
```

*Note, that the color thresholding function was changed the same way as in the notebook. The operator argument  (and consequently import statement) could be removed, as is not actually being used in the final result, but as I initially played around with thresholding the obstacles, not simply inverting the terrain, the function definition stuck. Arguably this could be cleaned up. The top part of perception.py up to `rover_coords()` function is as follows:*

```python
import numpy as np
import cv2
import operator

# Identify pixels above the threhold
# > 160 ok for ground pixels only
def color_thresh(img, rgb_thresh=(160,160,160), cmp_op=False):
    # Zeros size of img, but single channel
    color_select = np.zeros_like(img[:,:,0])

    img_r = img[:,:,0]
    img_g = img[:,:,1]
    img_b = img[:,:,2]

    r,g,b = rgb_thresh

    # Fallback to > if none specified
    if not cmp_op:
        cmp_op = operator.gt

    # Require each px to be above thresh val
    above_thresh = (cmp_op(img_r, r) \
                    & cmp_op(img_g, g) \
                    & cmp_op(img_b, b))

    color_select[above_thresh] = 1

    # Return the binary image
    return color_select

def color_thresh_terrain(img):
    return color_thresh(img, (160, 160, 160))

def color_thresh_samples(img):
    hsv = cv2.cvtColor(img, cv2.COLOR_RGB2HSV)

    lower_yellow = np.array([20, 100, 100])
    upper_yellow = np.array([30, 255, 255])

    mask = cv2.inRange(hsv, lower_yellow, upper_yellow)

    return mask
```


The rest of perception.py remains unchanged.


##### `decision.py`

With the functionality already given in the file, the Rover has two modes - 'stop' and 'forward'. 

```python
def decision_step(Rover):

    # Check for vision
    if Rover.nav_angles is not None:

        # Check for Rover.mode status
        if Rover.mode == 'forward':

        ...

        # If already in "stop" mode then make different decisions
        elif Rover.mode == 'stop':

        ...

    # Just to make the rover do something
    # even if no modifications have been made
    else:
        Rover.throttle = Rover.throttle_set
        Rover.steer = 0
        Rover.brake = 0
```

As the Rover was getting stuck frequently, felt like it needed to be remedied.
To check whether Rover is stuck, I decided to check its recent positions. First step - adding additional attributes to `RoverState` class:

```python
class RoverState():
    def __init__(self):
        ...
        self.log_len = 30
        self.pos_log = [0] * self.log_len   # Keep record of last positions
        ...
```                     




```python
        elif Rover.mode == 'stuck':
                Rover.throttle = 0
                # Release brake to allow turning
                Rover.brake = 0
                # Turn range is +- 15 degrees, when stopped the next line will induce
                # 4-wheel turning
                Rover.steer = -15 # Could be more clever way about which way to turn
                # resume trying to go forward
                Rover.mode = 'forward'

```                     



```python
```

#### 2. Launching in autonomous mode your rover can navigate and map autonomously.  Explain your results and how you might improve them in your writeup.  

**Note: running the simulator with different choices of resolution and graphics quality may produce different results, particularly on different machines!  Make a note of your simulator settings (resolution and graphics quality set on launch) and frames per second (FPS output to terminal by `drive_rover.py`) in your writeup when you submit the project so your reviewer can reproduce your results.**

---

###### Graphic settings used throughout the project

Screen resolution: 1680x1050

Graphics Quality: Good

Windowed: True

FPS output to terminal by `drive_rover.py`: 19

---

Here I'll talk about the approach I took, what techniques I used, what worked and why, where the pipeline might fail and how I might improve it if I were going to pursue this project further.  



![alt text][image3]


