#!/usr/bin/env python

# import PCL module
import pcl

filename = 'robo_2.pcd'
cloud = pcl.load_XYZRGB(filename)

# [START Statistical Outlier Filter]
fil = cloud.make_statistical_outlier_filter()
fil.set_mean_k(5)
fil.set_std_dev_mul_thresh(1.0)

#pcl.save(fil.filter(), "scene_inliers.pcd")
#fil.set_negative(True)
#pcl.save(fil.filter(), "scene_outliers.pcd")

cloud_filtered = fil.filter()
# [END Statistical Outlier Filter]



