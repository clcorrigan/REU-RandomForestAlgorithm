%This function takes in the file names of the hyperspectral image and the 
% png file that has been created from the Image Labeler in matlab.

function [labeledData] = addLabel(bipFileName,pngFileName)
    datacube = multibandread(bipFileName, [2000 900 300], "single", 0, "bip", "ieee-le");
    % read the .bip file and store it in the variable "datacube" 
    mask = imread(pngFileName);
    % read the classification mask created by the Image Labeler, store it
    % in the variable "mask"
    maskD = double(mask); 
    % convert the .png file into a double file type. 
    datacube(:, :, 301) = maskD;
    % adds the mask in the datatype "double" as being the last layer of the
    % datacube. 
    labeledData = datacube;
    % returns the labeled datacube. 
end