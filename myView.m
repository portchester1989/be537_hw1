function myView (image, spacing, crosshair, crange, cmap)
%get dimention of the image
image = permute(image,[2 1 3]);
dimentions = size(image);
spacing = fliplr([spacing(2) spacing(1) spacing(3)]);
if  nargin < 3 | xor(~exist('crosshair','var'),isempty(crosshair))
    crosshair = floor(dimentions * .5);
else
    crosshair = ([crosshair(2) crosshair(1) crosshair(3)]);
end
if  nargin < 4 | xor(~exist('crange','var'),isempty(crange))
    %minimum and maximum intensity within the image
    imin = min(image(:));
    imax = max(image(:));
    crange = [imin imax];
end
if  nargin < 5 | xor(~exist('cmap','var'),isempty(cmap))
    cmap = 'gray';
end
%global setting for plots
dimentions = fliplr(dimentions);
crosshair = fliplr(crosshair);
caxis(crange);
colormap(cmap);

%plots
    for i = 1:3
        subplot(2,2,i);
        %getting the spacing, crosshair and dimention of this plane
        this_spacing = spacing;
        this_spacing(i) = [];
        this_slice = crosshair(i);
        this_cross_hair = crosshair;
        this_cross_hair(i) = [];
        this_dimention = dimentions;
        this_dimention(i) = [];
        if i == 1
            img_this_slice = squeeze(image(:,:,this_slice));
%             this_cross_hair = fliplr(this_cross_hair);
%             this_dimention = fliplr(this_dimention);
%             this_spacing = fliplr(this_spacing);
             this_title = ['z = ',int2str(this_slice)];
              
                  
        elseif i == 2
            img_this_slice = squeeze(image(:,this_slice,:))';
            this_dimention = fliplr(this_dimention);
            this_spacing = fliplr(this_spacing);
            this_cross_hair = fliplr(this_cross_hair);
            this_title = ['x = ',int2str(this_slice)];
        else
            img_this_slice = squeeze(image(this_slice,:,:));
            img_this_slice = img_this_slice';
            this_cross_hair = fliplr(this_cross_hair);
            this_spacing = fliplr(this_spacing);
            this_dimention = fliplr(this_dimention);
            this_title = ['y = ',int2str(this_slice)];
        end
        imagesc(img_this_slice);
        title(this_title);
        %draw crosshairs
        line(this_cross_hair(1) * ones(1,100),linspace(0,this_dimention(2)));
        line(linspace(0,this_dimention(1)),this_cross_hair(2) * ones(1,100));
        set(gca,'XDir','reverse')
        set(gca,'YDir', 'normal')
        daspect([fliplr(this_spacing) 1]);
    
    end
    %legend
    subplot(2,2,4)
    axis off;
    text(0,.7,['xhair = ',mat2str([crosshair(2) crosshair(3) crosshair(1)])]);
    text(0,.5,['dimen = ',mat2str([dimentions(2) dimentions(3) dimentions(1)])]);
    colorbar('southoutside');
end