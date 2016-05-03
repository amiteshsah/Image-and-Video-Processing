function [ outputMat ] = my_mat2gray( inputMat )
%MY_MAT2GRAY Summary of this function goes here
%   Detailed explanation goes here

outputMat = (inputMat-min(inputMat(:)))/(max(inputMat(:))-min(inputMat(:)));

end

