# Import PCL module
import pcl

# Load Point Cloud file
cloud = pcl.load_XYZRGB('tabletop.pcd')


## Voxel Grid filter

# Create a VoxelGrid filter object for our input point cloud
vox = cloud.make_voxel_grid_filter()

# Choose a voxel (also known as leaf) size
# Note: this (1) is a poor choice of leaf size
# it implies that voxel is 1 cubic meter in volume
# so it may remove important features.
# Experiment and find the appropriate size!
# A good estimate size can be obtained by having some prior
# information about the scene, like the size of the smallest
# object or total volume of the scene in Field of View.
LEAF_SIZE = 0.01
# LEAF_SIZE = 0.01 # seems to work reasonably well for this dataset

# Set the voxel (or leaf) size
vox.set_leaf_size(LEAF_SIZE, LEAF_SIZE, LEAF_SIZE)

# Call the filter function to obtain the resultant downsampled point cloud
cloud_filtered = vox.filter()
filename = 'voxel_downsampled.pcd'
pcl.save(cloud_filtered, filename)


## PassThrough filter

# Create a PassThrough filter object
passthrough = cloud_filtered.make_passthrough_filter()

# Assign axis and range to the passthrough filter object
filter_axis = 'z'
passthrough.set_filter_field_name(filter_axis)
# Again, values depend on dataset, experiment.
# These work well for this dataset
axis_min = 0.6
axis_max = 1.1
passthrough.set_filter_limits(axis_min, axis_max)

# Finally use the filter function to obtain the point cloud
cloud_filtered = passthrough.filter()
filename = 'pass_through_filtered.pcd'
pcl.save(cloud_filtered, filename)

# While filtering gets rid of some noise, to make further progress
# we need to divide the point cloud in smaller objects
# based on some common property - shape, color, size or neighborhood.
# Enter segmentation

##  RANSAC plane segmentation

# We will use a popular technique known as Random Sample Consensus
# or "RANSAC". RANSAC is an algorithm that can be used to identify
# points in dataset that belong to a particular model.
# It assumes that all of the data in a dataset is composed of both
# inliers and outliers - where inliers can be defined by a particular
# model with specific set of parameters, outliers do not fit that model
# and hence can be discarded.

# If you have a prior knowledge of a certain shape being present in a
# a given dataset, you can use RANSAC to estimate what pieces of the point
# cloud set belong to that shape by assuming a particular model.

# e.g. robot autonomous navigation - for collision avoidance with objects
# and to determine traversable terrain, ground plane segmentation is an
# important part of a mobile robot's perception toolkit.

# Create the segmentation object
seg = cloud_filtered.make_segmenter()

# Set the model you wish to fit
seg.set_model_type(pcl.SACMODEL_PLANE)
seg.set_method_type(pcl.SAC_RANSAC)

# Max distance for a point to be considered fitting the model
# Again, depends on dataset, experiment
max_distance = 0.01
seg.set_distance_threshold(max_distance)

# Call the segment function to obtain set of inlier indices and model coefficients
inliers, coefficients = seg.segment()

## Extract inliers

# the filter above is frequently used along other techniques to
# obtain a subset of points from an input point cloud. Most object
# recognition algorithms return a set of indices associated with the
# points that form the identified target object.

# As a result, it is convenient to use the ExtractIndices filter to
# extract the pointcloud associated with the identified object.

extracted_inliers = cloud_filtered.extract(inliers, negative=False)
filename = 'extracted_inliers.pcd'
pcl.save(extracted_inliers, filename)

# Save pcd for table
# pcl.save(cloud, filename)

# Extract outliers
extracted_outliers = cloud_filtered.extract(inliers, negative=True)
filename = 'extracted_outliers.pcd'
pcl.save(extracted_outliers, filename)


# Save pcd for tabletop objects

## Filtering noise (not needed here, but will become useful)
# Create a filter object
outlier_filter = cloud_filtered.make_statistical_outlier_filter()

# Set the number of neighbouring points to analyze for any given points
outlier_filter.set_mean_k(50)

# Set threshold scale factor
x = 1.0

# Any point with a mean distance larger than global (mean distance + x * std_dev) will be considered outlier
outlier_filter.set_std_dev_mul_thresh(x)

# Finally call the filter function for magic
cloud_filtered = outlier_filter.filter()


