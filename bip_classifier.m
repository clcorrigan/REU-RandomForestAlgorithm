function [RF_class, pctAlgae, algaeCover, waterCover] = bip_classifier(bip_filename,machineLearningModel, h, w)
% this function takes in the machine learning model, runs it on the .bip
% files, and returns an image that shows the Random Forest Classification,
% and the percent algae cover according to the Random Forest Classifer 
% Read and shape .bip file
datacube = multibandread(bip_filename , [h w 300], "single", 0, "bip", "ieee-le");
datacube = reshape(datacube, [h*w 300]);

% Pulls out the beginning of the file name to use to save the classified
% .png
expression = "[A-Z].+[Pika_L_][0-9]+";
variableName = regexp(bip_filename, expression, "match");

% MODEL 2 IMG -- originally a separate function, added into this function
% to you have to download less. 
    % this takes in length of the datalist and creates a variable imgHeight
    % that stores the height of the final image. 
        
        % IMG SORT INTO NaN and Pxls, takes in the height and width and the
        % data cube
        [idxNaN, idxPxl] = bip_sort(datacube, h, w);


    % compiles the pixel that are actual image data. 
    datacube_pxls = datacube(idxPxl, 1:300);

    % Predicts the data and turns the prediction into a double datatype. 
    predictedMask = predict(machineLearningModel, datacube_pxls);
    predictedMask = str2double(predictedMask); 
    

    % IMG 2 ALGAE COVER 
    % collects and returns the percent of Algae Cover, number of pixels
    % that are algae, and the number that are water. 
        algaeCover = numel(predictedMask(predictedMask == 1));
        waterCover = numel(predictedMask(predictedMask == 0));
        pctAlgae = algaeCover/(waterCover + algaeCover);
    

    % turns the prediction into a double datatype, and then turns that
    % into an image. If you reuse this code and have more than the 4
    % classes, you will need to edit the second line. 
    combinedMask(idxPxl) = predictedMask;
    combinedMask = mat2gray(combinedMask, [0, 4]);
   
    %Adds back in the pixels from the Geoclassified Image that are not
    %hyperspectral. 
    combinedMask(idxNaN) = -1;

    %Turns the data, right now a very long and skinny image into the
    %original dimensions of the image. 
    combinedMask = reshape(combinedMask, [h w 1]); 
    predictedImg = medfilt2(combinedMask, [3 3]);



   % GRAY 2 RBG -- this section of code takes in the image that was created
   % from the above section and turns it from the greyscale image into a
   % colored image that shows what the machine predicts is where. 

   %Gives the greyscale image three channels. 
   predictedImg(:, :, 2) = predictedImg(:, :, 1);
   predictedImg(:, :, 3) = predictedImg(:, :, 1);

   %Takes those three channels and alters the RBG values. 
   % Written for the original classifications with 4 values.  
   % Converts the grey img into a colored mask to increase the contrast. 
        im1R = predictedImg(:, :, 1);
        im1B = predictedImg(:, :, 2);
        im1G = predictedImg(:, :, 3);
    % separates the three channels of the colors. 
        im1R(im1R==0.25) = 0;
        im1G(im1G==0.25) = 153/255;
        im1B(im1B==0.25) = 0;
    % turns the darkest grey (algae) color into green. 
        im1R(im1R==0) = 0;
        im1G(im1G==0) = 0;
        im1B(im1B == 0) = 55/255;
    % turns the black (water) into a navy blue color. 
        im1R(im1R == 0.75) = 255/255;
        im1G(im1G == 0.75) = 128/255;
        im1B(im1B == 0.75) = 0/255; 
    % Turns the lightest grey (bank) into an orange color. 
        RF_class(:, :, 1) = im1R;
        RF_class(:, :, 2) = im1G;
        RF_class(:, :, 3) = im1B;
    %combines the channels back together into one image. 

    % Takes the image and saves it to your computer under the format
    % "Location_Pika_L_#ofImage-RF_class.png" 
    imwrite(RF_class, variableName+"-RF_Class.png", "png")
   

end
