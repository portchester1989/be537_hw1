function myViewInSNAP(image,spacing)
temp_file = strcat(tempname,'.nii');
myWriteNifti(temp_file,image,spacing);
command = ['/Applications/ITK-SNAP.app/Contents/MacOS/ITK-SNAP -g ',temp_file];
system(command);
delete(temp_file);
end