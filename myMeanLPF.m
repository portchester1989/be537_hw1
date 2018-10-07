function filtered = myMeanLPF(image,radius)
filter_size = 2 * radius + 1;
kernel = ones(filter_size,filter_size,filter_size) / (filter_size ^ 3);
filtered = imfilter3d(image,kernel);

end
