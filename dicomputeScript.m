arguments_cell = {'nearest','linear',{'linear','G',2,[]},{'linear','M',[],2}};
spacing = base_spacing;
for i = 1:2
%     figure;
    [di,filtered_fixed,transformed_moving] = differenceImages(fixed,moving,spacing,A,b,arguments_cell{i});
    figure;
    myView(di , spacing , [56 100 64] , [-70 70], 'winter');
end
for i = 3:4
    %3D Delta filtered with Gaussian is called in differenceImages function 
%     figure;
    [di,filtered_fixed,transformed_moving] = differenceImages(fixed,moving,spacing,A,b,arguments_cell{i}{1},arguments_cell{i}{2},arguments_cell{i}{3},arguments_cell{i}{4});
    figure;
    myView(filtered_fixed , spacing , [56 100 64]);
    figure;
    myView(di , spacing , [56 100 64] , [-70 70], 'winter');
end