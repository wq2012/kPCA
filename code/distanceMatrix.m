function D = distanceMatrix(X, Y)
% DISTANCEMATRIX computes the pairwise Euclidean distance matrix.
%
%   Usage:
%   D = distanceMatrix(X)       % Self-distances (N x N)
%   D = distanceMatrix(X, Y)    % Cross-distances (N x M)
%
%   Input:
%   X: Data matrix - Each row is one observation, each column is one feature.
%   Y: (Optional) Second data matrix.
%
%   Output:
%   D: Pair-wise distance matrix.
%
%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its
%   Applications in Face Recognition and Active Shape Models.
%   arXiv:1207.3538 [cs.CV], 2012.

%% Input validation
narginchk(1, 2);
if ~isnumeric(X) || isempty(X)
    error('Input X must be a non-empty numeric matrix.');
end

if nargin == 1 || isempty(Y)
    Y = X;
end

if ~isnumeric(Y)
    error('Input Y must be a numeric matrix.');
end

if size(X, 2) ~= size(Y, 2)
    error('X and Y must have the same number of features (columns).');
end

%% Optimized computation using expansion
% D^2 = sum(X^2) + sum(Y^2) - 2 * X * Y'
XX = sum(X.*X, 2);
YY = sum(Y.*Y, 2);

D = bsxfun(@plus, XX, YY') - 2 * (X * Y');

% Numerical stability: distance cannot be negative
D(D < 0) = 0;
D = sqrt(D);
