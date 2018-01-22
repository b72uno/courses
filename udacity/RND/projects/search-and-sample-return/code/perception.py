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

# Define a function to convert from image coords to rover coords
def rover_coords(binary_img):
    # Identify non-zero pixels
    ypos, xpos = binary_img.nonzero()
    # Calculate pixel positions with reference to rover
    # being at the center bottom of the image
    x_pixel = -(ypos - binary_img.shape[0]).astype(np.float)
    y_pixel = -(xpos - binary_img.shape[1]/2).astype(np.float)

    return x_pixel, y_pixel

# Define a function to convert to radial coords in rover space
def to_polar_coords(x_pixel, y_pixel):
    # Calculate distance to each pixel
    dist = np.sqrt(x_pixel**2 + y_pixel**2)
    # Calculate angle away from vertical for each pixel
    angles = np.arctan2(y_pixel, x_pixel)

    return dist, angles

# Define a function to map rover space pixels to world space
def rotate_pix(xpix, ypix, yaw):
    # Convert yaw to radians
    yaw_rad = yaw * np.pi / 180
    # Rotate
    xpix_rotated = (xpix * np.cos(yaw_rad)) - (ypix * np.sin(yaw_rad))
    ypix_rotated = (xpix * np.sin(yaw_rad)) + (ypix * np.cos(yaw_rad))

    return xpix_rotated, ypix_rotated

def translate_pix(xpix_rot, ypix_rot, xpos, ypos, scale):
    # Apply scaling and translation
    xpix_translated = (xpix_rot / scale) + xpos
    ypix_translated = (ypix_rot / scale) + ypos

    return xpix_translated, ypix_translated

# Define a function to apply rotation, translation and clipping
def pix_to_world(xpix, ypix, xpos, ypos, yaw, world_size, scale):
    # Apply rotation
    xpix_rot, ypix_rot = rotate_pix(xpix, ypix, yaw)
    # Apply translation
    xpix_tran, ypix_tran = translate_pix(xpix_rot, ypix_rot, xpos, ypos, scale)

    # Perform rotation, translation and clipping all at once
    x_pix_world = np.clip(np.int_(xpix_tran), 0, world_size - 1)
    y_pix_world = np.clip(np.int_(ypix_tran), 0, world_size - 1)

    return x_pix_world, y_pix_world

def perspect_transform(img, src, dst):
    M = cv2.getPerspectiveTransform(src, dst)
    warped = cv2.warpPerspective(img, M, (img.shape[1], img.shape[0])) # keep same size as input

    return warped

def is_near_zero(val, eps=0.5):
    return val < eps or abs(val-360.0) < eps

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
    px2world = lambda xy: pix_to_world(xy[0], xy[1], rover_x, rover_y, rover_yaw, \
                                       worldmap_size[0], scale)
    world_terrain = px2world(rover_centric_terrain)
    world_obstacles = px2world(rover_centric_obstacles)
    world_samples = px2world(rover_centric_samples)

    # 7) Update Rover worldmap (to be displayed on the right side of the screen)
    if is_near_zero(Rover.pitch) and is_near_zero(Rover.roll):
        Rover.worldmap[world_terrain[1], world_terrain[0], 2] += 10
        Rover.worldmap[world_obstacles[1], world_obstacles[0], 0] += 1

    if samples.any():
        sample_dist, sample_angles = to_polar_coords(rover_centric_samples[0],
                                                     rover_centric_samples[1])
        if sample_dist.any():
            sample_idx = np.argmin(sample_dist)
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





