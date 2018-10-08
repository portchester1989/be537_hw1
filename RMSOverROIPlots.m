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