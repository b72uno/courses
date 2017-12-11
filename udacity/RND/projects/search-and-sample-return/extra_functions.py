import numpy as np
import cv2


def perspect_transform(image, src=None, dst=None):
    dst_size = 5

    # bottom offset to account for bottom of the image not b eing in the position of the rover
    # but a bit in front of it
    bottom_offset = 6

    if not src:
        src = np.float32([[14,140], [301,140], [200,96], [118,96]])
    if not dst:
        dst = np.float32([[image.shape[1]/2 - dst_size, image.shape[0]  - bottom_offset],
                          [image.shape[1]/2 + dst_size, image.shape[0] - bottom_offset],
                          [image.shape[1]/2 + dst_size, image.shape[0] - 2*dst_size - bottom_offset],
                          [image.shape[1]/2 - dst_size, image.shape[0] - 2*dst_size - bottom_offset],
                          ])
    M = cv2.getPerspectiveTransform(src, dst)
    warped = cv2.warpPerspective(image, M, (image.shape[1], image.shape[0]))
    return warped

def color_thresh(img, rgb_thresh=(170, 170, 170)):
    color_select = np.zeros_like(img[:,:,0])
    above_thresh = (img[:,:,0] > rgb_thresh[0]) \
        & (img[:,:,1] > rgb_thresh[1]) \
        & (img[:,:,2] > rgb_thresh[2])
    color_select[above_thresh] = 1
    return color_select

def rover_coords(binary_img):
    ypos, xpos = binary_img.nonzero()
    x_pixel = np.absolute(ypos - binary_img.shape[0]).astype(np.float)
    y_pixel = -(xpos - binary_img.shape[0]).astype(np.float)
    return x_pixel, y_pixel
