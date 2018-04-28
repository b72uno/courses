#!/usr/bin/env python

# import PCL module
import pcl

from pcl_helper import *

filename = 'robo_3.pcd'
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
leaf_size = 0.0025
vox.set_leaf_size(leaf_size, leaf_size, leaf_size)
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

# lets get rid of those boxes
passthrough = cloud_filtered.make_passthrough_filter()
filter_axis = 'y'
passthrough.set_filter_field_name(filter_axis)
axis_min = -0.45
axis_max = 0.45
passthrough.set_filter_limits(axis_min, axis_max)
cloud_filtered = passthrough.filter()

#pcl.save(cloud_filtered, "pass_through_filtered.pcd")
# [END Plane fitting]

# [START Segmentation]
seg = cloud_filtered.make_segmenter()
seg.set_model_type(pcl.SACMODEL_PLANE)
seg.set_method_type(pcl.SAC_RANSAC)
max_distance = 0.01
seg.set_distance_threshold(max_distance)
inliers, coefficients = seg.segment()

extracted_inliers = cloud_filtered.extract(inliers, negative=False)
# pcl.save(extracted_inliers, 'extracted_inliers.pcd')
extracted_outliers = cloud_filtered.extract(inliers, negative=True)
# pcl.save(extracted_outliers, 'extracted_outliers.pcd')
# [END Segmentation]

# [START Clustering]
white_cloud = XYZRGB_to_XYZ(extracted_outliers)
tree = white_cloud.make_kdtree()
ec = white_cloud.make_EuclideanClusterExtraction()
ec.set_ClusterTolerance(0.025)
ec.set_MinClusterSize(100)
ec.set_MaxClusterSize(10000)
ec.set_SearchMethod(tree) # search the k-d tree for clusters
cluster_indices = ec.Extract()

get_color_list.color_list = []
cluster_color = get_color_list(len(cluster_indices))
color_cluster_point_list = []
for j, indices in enumerate(cluster_indices):
    for i, indice in enumerate(indices):
        color_cluster_point_list.append([
            white_cloud[indice][0],
            white_cloud[indice][1],
            white_cloud[indice][2],
            rgb_to_float(cluster_color[j])
        ])

cluster_cloud = pcl.PointCloud_PointXYZRGB()
cluster_cloud.from_list(color_cluster_point_list)
pcl.save(cluster_cloud, 'cluster_cloud.pcd')
# [END Clustering]


if __name__ == '__main__':

    get_color_list.color_list = []
