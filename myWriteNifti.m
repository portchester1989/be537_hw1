function myWriteNifti(filename,image,spacing)
nii = make_nii(image,spacing);
nii.hdr.dime.datatype = 64;
% nii.hdr.dime.bitpix = 64;
save_nii(nii,filename);
end