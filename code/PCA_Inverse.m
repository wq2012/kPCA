function X = PCA_Inverse(Y, eigVector, meanX)
% PCA_INVERSE reconstructs the original data from PCA components.
%
%   Usage:
%   X = PCA_Inverse(Y, eigVector, meanX)
%
%   Input:
%   Y: Dimensionally-reduced data (N x d).
%   eigVector: Eigenvectors (principal components) (M x d).
%   meanX: Mean of the original data (1 x M).
%
%   Output:
%   X: Reconstructed data in the original feature space (N x M).
%
%   Copyright by Quan Wang, 2012/12/28

narginchk(3, 3);

% X = Y * P' + mean
X = bsxfun(@plus, Y * eigVector', meanX);
