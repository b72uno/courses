#!/usr/bin/env python

# import PCL module
import pcl

filename = 'robo_2.pcd'
cloud = pcl.load_XYZRGB(filename)

# [START Statistical outlier filter]
fil = cloud.make_statistical_outlier_filter()
fil.set_mean_k(5)
fil.set_std_dev_mul_thresh(1.0)

# pcl.save(fil.filter(), "scene_inliers.pcd")
# fil.set_negative(True)
# pcl.save(fil.filter(), "scene_outliers.pcd")

cloud_filtered = fil.filter()
# [END Statistical outlier filter]

# [START Plane fitting]
vox = cloud_filtered.make_voxel_grid_filter()

# downsample point cloud
LEAF_SIZE = 0.01
vox.set_leaf_size(LEAF_SIZE, LEAF_SIZE, LEAF_SIZE)
cloud_filtered = vox.filter()
# pcl.save(cloud_filtered, "voxel_downsampled.pcd")

# passthrough filter
passthrough = cloud_filtered.make_passthrough_filter()
filter_axis = 'z'
passthrough.set_filter_field_name(filter_axis)
axis_min = 0.6
axis_max = 1.1
passthrough.set_filter_limits(axis_min, axis_max)

cloud_filtered = passthrough.filter()
# pcl.save(cloud_filtered, "pass_through_filtered.pcd")
# [END Plane fitting]

# [START Segmentation]
seg = cloud_filtered.make_segmenter()
seg.set_model_type(pcl.SACMODEL_PLANE)
seg.set_method_type(pcl.SAC_RANSAC)
max_distance = 0.01
seg.set_distance_threshold(max_distance)
inliers, coefficients = seg.segment()

extracted_inliers = cloud_filtered.extract(inliers, negative=False)
pcl.save(extracted_inliers, 'extracted_inliers.pcd')

extracted_outliers = cloud_filtered.extract(inliers, negative=True)
pcl.save(extracted_outliers, 'extracted_outliers.pcd')
# [END Segmentation]



