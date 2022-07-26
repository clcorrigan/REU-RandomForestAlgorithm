% Written for the original classifications with 4 values.  
% Converts the gray img into a colored mask to increase the contrast. 
function [colored_img] = gray2rgb(img)
    im1R = img(:, :, 1);
    im1B = img(:, :, 2);
    im1G = img(:, :, 3);
    % separates the three channels of the colors. 
    im1R(im1R==64) = 0;
    im1G(im1G==64) = 153;
    im1B(im1B==64) = 0;
    % turns the darkest grey (algae) color into green. 
    im1R(im1R==0) = 0;
    im1G(im1G==0) = 0;
    im1B(im1B == 0) = 55;
    % turns the black (water) into a navy blue color. 
    im1R(im1R == 191) = 255;
    im1G(im1G == 191) = 128;
    im1B(im1B == 191) = 0; 
    % Turns the lightest grey (bank) into an orange color. 
    colored_img(:, :, 1) = im1R;
    colored_img(:, :, 2) = im1G;
    colored_img(:, :, 3) = im1B;
    %combines the channels back together into one image. 

end