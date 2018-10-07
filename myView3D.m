function myView3D(image,spacing,crosshair,crange,cmap)
dimentions = size (image);
image = double(image);
if  nargin < 3 | ~exist('crosshair','var')
    crosshair = floor(dimentions * .5);
end
if nargin < 4 | xor(~exist('crange','var'),isempty(crange))
    imin = min(image(:));
    imax = max(image(:));
    crange = [imin imax];
end
if  nargin < 5 | ~exist('cmap','var')
    cmap = 'gray';
end
caxis(crange);
colormap(cmap);
h = slice(image,crosshair(2),crosshair(1),crosshair(3));
set(h,'EdgeColor','none');
daspect(spacing);
end