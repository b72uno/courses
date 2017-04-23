import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import cv2  #bringing in OpenCV libraries

image = mpimg.imread('exit-ramp.jpg')
# plt.imshow(image)

gray = cv2.cvtColor(image, cv2.COLOR_RGB2GRAY)
# plt.imshow(gray, cmap='gray')

# We also include Gaussian smoothing, which is essentially a way of
# suppressing noise and spurious gradients by averaging.
kernel_size = 3
blur_gray = cv2.GaussianBlur(gray, (kernel_size, kernel_size), 0)

# The algorith will first detect strong edge (gradient)
# above the high threshold and reject pixels below the
# low threshold. Next, pixels with values between the low
# threshold and high threshold will be included
# as long as they are connected to strong edges. The output
# edges is a binary image with white pixels tracing out
# the detected edges and black everywhere else
low_threshold = 60
high_threshold = 180
edges = cv2.Canny(blur_gray, low_threshold, high_threshold)

# As for ratio of low_threshold to high_threshold, John Canny
# himself recommended a low to high ratio of 1:2 or 1:3

# Display the image
plt.imshow(edges, cmap='Greys_r')
plt.show()



