function sigma = estimateSigma(X)
% ESTIMATESIGMA estimates the Gaussian kernel parameter using the median trick.
%
%   Usage:
%   sigma = estimateSigma(X)
%
%   Input:
%   X: Data matrix - Each row is one observation.
%
%   Output:
%   sigma: Estimated sigma parameter (median of pairwise distances).
%
%   Copyright by Quan Wang, 2012/12/28

narginchk(1, 1);

% Compute pairwise distances
D = distanceMatrix(X);

% Extract upper triangle (excluding diagonal) to find pairwise distances
N = size(X, 1);
mask = triu(true(N), 1);
pairwiseDistances = D(mask);

% Median trick: sigma = median of pairwise distances
sigma = median(pairwiseDistances);

% Handle case where all points are the same
if sigma == 0
    sigma = 1;
    warning('All data points are identical or distance is zero. Setting sigma = 1.');
end
