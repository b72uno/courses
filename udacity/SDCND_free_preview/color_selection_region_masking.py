import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import numpy as np

# Read in the image
image = mpimg.imread('test.jpg')

# Grab the x and y sizes and make two copies of the image
# With one copy we will extract only the pixels that meet the selection
# the we will paint those pixels red in the original image to see
# our selection overlaid on the original
y_size       = image.shape[0]
x_size       = image.shape[1]
color_select = np.copy(image)
line_image   = np.copy(image)

# Define our color criteria
red_threshold   = 200
green_threshold = 200
blue_threshold  = 200
rgb_threshold   = [red_threshold, green_threshold, blue_threshold]

# Define a triangle region of interest
# Keep in mind that x=0 and y=0 in upper left corner
left_bottom  = [x_size * 0.1, y_size]
right_bottom = [x_size * 0.9, y_size]
apex         = [x_size / 2, y_size / 2]

fit_left = np.polyfit((left_bottom[0], apex[0]), (left_bottom[1], apex[1]), 1)
fit_right = np.polyfit((right_bottom[0], apex[0]), (right_bottom[1], apex[1]), 1)
fit_bottom = np.polyfit((left_bottom[0], right_bottom[0]), (left_bottom[1], right_bottom[1]), 1)


# Mask pixels below the threshold
color_thresholds = (image[:,:,0] < rgb_threshold[0]) \
                    | (image[:,:,1] < rgb_threshold[1]) \
                    | (image[:,:,2] < rgb_threshold[2])

# Find the region inside the lines
XX, YY = np.meshgrid(np.arange(0, x_size), np.arange(0, y_size))
region_thresholds = (YY > (XX*fit_left[0] + fit_left[1])) & \
                    (YY > (XX*fit_right[0] + fit_right[1])) & \
                    (YY < (XX*fit_bottom[0] + fit_bottom[1]))

# Mask color selection
# color_select[color_thresholds] = [0, 0, 0]
color_select[color_thresholds | ~region_thresholds] = [0, 0, 0]


# Find where image is both colored and in the regions
line_image[~color_thresholds & region_thresholds] = [255, 0, 0]

# Display the image
plt.imshow(color_select)
plt.show()
