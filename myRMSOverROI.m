function value = myRMSOverROI(image,seg,label)
%compute squared sum of difference images
flatten_image = image(:);
ROI_voxels = flatten_image(seg(:) == label);
value = sqrt ((ROI_voxels' * ROI_voxels) / size(ROI_voxels,1));
%compute ROI area
end