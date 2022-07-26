function [percentAccuracy, num_correct] = img_Compare(imgPredicted,imgReal)
%Takes in the real image and the one that the machine predicted and
%compares them to give percent error 
predictData = reshape(imgPredicted, [1800000 1]);
realData = reshape(imgReal, [1800000 1]);
num_correct = predictData==realData;
percentAccuracy = sum(num_correct)/numel(num_correct);
end