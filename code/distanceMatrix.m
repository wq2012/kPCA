function D = distanceMatrix(X)
% DISTANCEMATRIX computes the pairwise Euclidean distance matrix.
%
%   Usage:
%   D = distanceMatrix(X)
%
%   Input:
%   X: Data matrix - Each row is one observation, each column is one feature.
%
%   Output:
%   D: Pair-wise distance matrix (N x N), where D(i,j) is the distance between X(i,:) and X(j,:).
%
%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its
%   Applications in Face Recognition and Active Shape Models.
%   arXiv:1207.3538 [cs.CV], 2012.

%% Input validation
narginchk(1, 1);
if ~isnumeric(X) || isempty(X)
    error('Input X must be a non-empty numeric matrix.');
end

N = size(X, 1);

%% Optimized computation using expansion
XX = sum(X.*X, 2);
% D = sqrt(XX_i + XX_j - 2*X_i*X_j')
D = bsxfun(@plus, XX, XX') - 2 * (X * X');

% Numerical stability: distance cannot be negative
D(D < 0) = 0;
D = sqrt(D);
