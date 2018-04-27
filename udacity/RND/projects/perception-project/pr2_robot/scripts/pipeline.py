#!/usr/bin/env python

# import PCL module
import pcl

filename = 'robo_1.pcd'
cloud = pcl.load_XYZRGB(filename)

# Filter noise
fil = cloud.make_statistical_outlier_filter()
fil.set_mean_k(50)
fil.set_std_dev_mul_thresh(1.0)
pcl.save(fil.filter(), "scene_inliers.pcd")

fil.set_negative(True)
pcl.save(fil.filter(), "scene_outliers.pcd")

