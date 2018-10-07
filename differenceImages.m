function [di,filtered_fixed,transformed_moving] = differenceImages(fixed,moving,spacing,A,b,method,filter,sigma,radius,crosshair,crange)
% crosshair = vargin{1};
% crange = vargin{2};
if nargin < 10
            crosshair = round(size(fixed) / 2);
end
% if nargin < 11
%             crange = [-1000 1000];
% end

    if nargin <= 6
        filtered_fixed = fixed;
        filtered_moving = moving;
    elseif filter == 'G'
        filtered_fixed = myGaussianLPF(fixed,sigma);
        filtered_moving = myGaussianLPF(moving,sigma);
        method = 'linear';
        delta_image = zeros(2 * ceil(3 * sigma) + 1,2 * ceil(3 * sigma) + 1,2 * ceil(3 * sigma) + 1);
        delta_image(ceil(3 * sigma) + 1 , ceil(3 * sigma) + 1 , ceil(3 * sigma) + 1) = 1;
        gaussian_convolved_delta_image = myGaussianLPF(delta_image , sigma);
        figure;
        myView(gaussian_convolved_delta_image , spacing,[],[],'winter');
%         figure;
%         myView(filtered_fixed , spacing , crosshair);
    else
        filtered_fixed = myMeanLPF(fixed , radius);
        filtered_moving = myMeanLPF(moving , radius);
        method = 'linear';
%         figure;
%         myView(filtered_fixed , spacing , crosshair);
    end
transformed_moving = myTransformImage(filtered_fixed,filtered_moving,A,b,method);
di = filtered_fixed - transformed_moving;
% figure;
% myView(di , spacing , crosshair , crange, 'winter');
end