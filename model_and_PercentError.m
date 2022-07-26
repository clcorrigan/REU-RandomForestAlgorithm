% this function takes in the number of trees, the training data, the
% testing data, the real training values, and the real test values. All of
% these are used to make a model and run it on the testing data. 
function [percentError, Forest_Mdl] = model_and_PercentError(numTrees, trainData, testData, trainReal, testReal)
    Forest_Mdl = TreeBagger(numTrees, trainData, trainReal);
    % creates the random forest model 
    testPredict = predict(Forest_Mdl, testData);
    % creates the list of predicted data
    testPredict = str2double(testPredict);
    % converts predicted data into a double type. 
    testCorrect = (testPredict == testReal);
    % finds the number of correct predictions. 
    percentError = (1- ((sum(testCorrect))/(numel(testCorrect))));
    % calculated the error 
end