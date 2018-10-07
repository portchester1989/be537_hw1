function myWriteNifti(filename,image,spacing)
nii = make_nii(filename,image,spacing);
nii.hdr.dime.datatype = "float32";
nii.hdr.dime.bitpix = 64;
save_nii(nii);
end