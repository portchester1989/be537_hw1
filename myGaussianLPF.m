function filtered = myGaussianLPF(image,sigma) 
filter_size =  ceil(3 * sigma) ;
[X,Y,Z] = ndgrid( - filter_size:filter_size, - filter_size:filter_size, - filter_size:filter_size);
kernel = exp( - (X .^ 2 / (2 * sigma ^ 2)) )/ (sigma * sqrt(2 * pi)) .* exp(-(Y .^ 2/(2 * sigma ^ 2))) / (sigma * sqrt(2 * pi)) .* exp(-(Z .^ 2/(2 * sigma ^ 2))) / (sigma * sqrt(2 * pi));
filtered = imfilter3d(image,kernel);

end