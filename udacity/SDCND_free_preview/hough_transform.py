import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import numpy as np
import cv2  #bringing in OpenCV libraries

image = mpimg.imread('exit-ramp.jpg')
# plt.imshow(image)

gray = cv2.cvtColor(image, cv2.COLOR_RGB2GRAY)
# plt.imshow(gray, cmap='gray')

# We also include Gaussian smoothing, which is essentially a way of
# suppressing noise and spurious gradients by averaging.
kernel_size = 5
blur_gray = cv2.GaussianBlur(gray, (kernel_size, kernel_size), 0)

# The algorith will first detect strong edge (gradient)
# above the high threshold and reject pixels below the
# low threshold. Next, pixels with values between the low
# threshold and high threshold will be included
# as long as they are connected to strong edges. The output
# edges is a binary image with white pixels tracing out
# the detected edges and black everywhere else
low_threshold = 50
high_threshold = 150
edges = cv2.Canny(blur_gray, low_threshold, high_threshold)

# As for ratio of low_threshold to high_threshold, John Canny
# himself recommended a low to high ratio of 1:2 or 1:3

# Define the Hough transform parameters
# Make a blank the same size as our image to draw on
rho = 1
theta = np.pi/180
threshold = 1
min_line_length = 10
max_line_gap = 1
line_image = np.copy(image) * 0  # creating a blank to draw lines on

# Run Hough on edge detected lines
lines = cv2.HoughLinesP(edges, rho, theta, threshold, np.array([]),
                        min_line_length, max_line_gap)

# Iterate over the output "lines" and draw lines on the blank
for line in lines:
    for x1,y1,x2,y2 in line:
        cv2.line(line_image, (x1, y1), (x2,y2), (255,0,0), 10)

# Create a "color" binary image to combine with line image
color_edges = np.dstack((edges, edges, edges))

# Draw the lines on the image
combo = cv2.addWeighted(color_edges, 0.8, line_image, 1, 0)
plt.imshow(combo)

plt.show()

