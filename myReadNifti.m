function [image,spacing] = myReadNifti(filename)
%load image and header
nii = load_nii(filename);
image = nii.img;
spacing = nii.hdr.dime.pixdim(2:4);
image = double(image);
end