function [idxNaN, idxPxl] = bip_sort(bipFile, h, w)

%takes in the datacube, and the height and width, and returns the indexes
%of the pixels that are blank, and the indexes of the pixels that hold
%hyperspectral data. 
length = h*w;
bipFile = reshape(bipFile, [length, 300]);
idxNaN = [];
idxPxl = [];
array(1:300) = 0;

% goes through the bipFole, and pulls all the indexes of rows for which there is no
% hyperspectral data into "idxNaN" and all the indexes for which there
% is hyper spectral data "idxPxl" 
for x = 1:length
row = bipFile(x, 1:300);
if row == array 
    idxNaN = [idxNaN, x];
else 
    idxPxl = [idxPxl, x];
end
end
end