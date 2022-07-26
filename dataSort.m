function [trainData, testData, trainReal, testReal] = dataSort(combinedData, dataR, dataC)
% this function takes in a dataCube, the number of rows, and the number of
% columns and then sorts it into the training data set and the testing
% dataset. 
listSize = dataR * dataC; 
% forms the listsize from the numbers of rows and columns in the datacube. 
dataTable = reshape(combinedData, listSize, 301);
% turns the datacube into a list of values where each row is 301 columns,
% with the 301st value being the correct classification of the pixel. 
k = randperm(listSize);
% this makes a random permutation, stored as "k", that is the number of
% values in the list of pixels. 
trainData = dataTable(k(1:(0.7*listSize)), :);
% this collects 80% of the data as random and puts it in the training data
% set. 
testData = dataTable(k((0.7*listSize)+1:listSize),:);
% this collects the other 20% of the data and stores it in the variable
% testData 
trainReal = trainData(:, 301);
% this takes the last layer of the table and stores it as the training real
% mask. 
testReal = testData(:, 301);
% this takes the last layer of the table and stores it as the testing mask.
% 
trainData = trainData(:, 1:300);
% This takes the first 300 columns of the data and stores it as the real
% training data. 
testData = testData(:, 1:300);
% This takes the first 300 columns of the data and stores it as the real
% testing data.
end