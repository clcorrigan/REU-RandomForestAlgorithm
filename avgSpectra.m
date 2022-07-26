function [avgSpectraAlgae] = avgSpectra(algaeList)
    avgSpectraAlgae = [];
    for x = 1:290
        avgSpectraAlgae(x) = sum(algaeList(:, x))/length(algaeList);
    end 
end