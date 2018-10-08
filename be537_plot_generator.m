%%
%load baseline, followup images and affine transformation matrix
[fixed,spacing] = myReadNifti('../Downloads/assignment_data/baseline.nii');
[moving,~] = myReadNifti('../Downloads/assignment_data/followup.nii');
data = load('-ascii','../Downloads/assignment_data/f2b.txt');
[seg,~] = myReadNifti('../Downloads/assignment_data/followup.nii');
A = data(1:3,1:3);
b = data(1:3,4);
%%
%3.4
figure;
myView3D(fixed,spacing,[56 100 64],[],'winter');
%%
%3.5
resampled_image = myTransformImage(fixed,moving,A,b,'linear');
figure;
myView(fixed,spacing,[56 100 64],[],'winter');
figure;
myView(resampled_image,spacing,[56 100 64],[],'winter');
%%
%3.6.3 
arguments_cell = {'nearest','linear',{'linear','G',2,[]},{'linear','M',[],2}};
for i = 1:2
%     figure;
    [di,filtered_fixed,transformed_moving] = differenceImages(fixed,moving,spacing,A,b,arguments_cell{i});
    figure;
    myView(di , spacing , [56 100 64] , [-500 500], 'winter');
end
for i = 3:4
    %3D Delta filtered with Gaussian is called in differenceImages function 
%     figure;
    [di,filtered_fixed,transformed_moving] = differenceImages(fixed,moving,spacing,A,b,arguments_cell{i}{1},arguments_cell{i}{2},arguments_cell{i}{3},arguments_cell{i}{4});
    figure;
    myView(filtered_fixed , spacing , [56 100 64]);
    figure;
    myView(di , spacing , [56 100 64] , [-500 500], 'winter');
end
%%
%3.6.4 final
%set up vactors of various filter values
sigmas = 0:.5:5;
radia = 0:10;
RMS_gaussians = zeros(3,11);
RMS_means = zeros(3,11);
for i = 1:11
    sigma = sigmas(i);
    radius = radia(i);
    %compute differenceimages
    if i == 1
        [di_gaussian,~,~] = differenceImages(fixed,moving,spacing,A,b,'linear');
        di_mean = di_gaussian;
    else
        [di_gaussian,~,~] = differenceImages(fixed,moving,spacing,A,b,'linear','G',sigma);
        [di_mean,~,~] = differenceImages(fixed,moving,spacing,A,b,'linear','M',[],radius);
    end
    for label = 1:3
        RMS_gaussians(label,i) = myRMSOverROI(di_gaussian,seg,label);
        RMS_means(label,i) = myRMSOverROI(di_mean,seg,label);
    end
end
%Gaussian plot
figure
plot(sigmas,RMS_gaussians(1,:),sigmas,RMS_gaussians(2,:),sigmas,RMS_gaussians(3,:));
title('RMS over ROI of different sizes of Gaussian filter')
xlabel('sigma')
ylabel('RMS over ROI')
legend('Left Hippocampus','Right Hippocampus','Lateral Ventricles');
figure
plot(radia,RMS_means(1,:),radia,RMS_means(2,:),radia,RMS_means(3,:));
title('RMS over ROI of different sizes of mean filter')
xlabel('radius')
ylabel('RMS over ROI')
legend('Left Hippocampus','Right Hippocampus','Lateral Ventricles');