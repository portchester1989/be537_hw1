function transform = myTransformImage(fixed,moving,A,b,method)
if nargin < 5
    method = 'linear';
end
% data = load('-ascii','../Downloads/assignment_data/f2b.txt');
[X,Y,Z] = ndgrid(1:size(fixed,1),1:size(fixed,2),1:size(fixed,3));
%get the grid coordinates as row vectors and stack them
grids = [X(:)';Y(:)';Z(:)'];
% affine transformation
T = A * grids + b;
image_size = size(moving);
% interpolation; X,Y,Z are sample grids and T(1,:)',T(2,:)',T(3,:)' are the
% actual coordinates. Maybe we should disable the transpose
transform = reshape(interpn(X,Y,Z,moving,T(1,:)',T(2,:)',T(3,:)',method,0),image_size(1),image_size(2),image_size(3));
% T = interpn(T,method)
end