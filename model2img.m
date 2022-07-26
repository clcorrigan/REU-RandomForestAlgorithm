% this function takes in model and the data in the form of a list that you
% want to turn into an image. It then uses the model to predict the
% classifications of the dat,a and then returns an image which shows the
% predicted values. This image is grayscaled. 

function [predictedImg] = model2img(model, data)
    data = reshape(data, [1800000 300]);
    imgHeight = length(data)/900;
    % this takes in length of the datalist and creates a variable imgHeight
    % that stores the height of the final image. 
    predictedMask = predict(model, data); 
    % Predicts the data
    predictedMask = str2double(predictedMask); 
    % turns the prediction into a double datatype. 
    predictedMask = reshape(predictedMask, [imgHeight 900 1]); 
    % turns the predictedMask in a list form back into the original image
    % shape. 
    predictedImg = mat2gray(predictedMask, [0, 4]);
    % This turns the double datatype into an image. This verion is for the
    % updated mask types that have 5 different calssification types. 
    predictedImg = medfilt2(predictedImg, [3 3]);
    % Reduces noise in the image and returns the smoother image. 
end