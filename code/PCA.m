function [Y, eigVector, eigValue, explained] = PCA(X, d)
% PCA performs standard Principal Component Analysis.
%
%   Usage:
%   [Y, eigVector, eigValue, explained] = PCA(X, d)
%
%   Input:
%   X: Data matrix - Each row is one observation, each column is one feature.
%   d: Number of components to retain.
%
%   Output:
%   Y: Dimensionally-reduced data (N x d).
%   eigVector: Eigenvectors (principal components).
%   eigValue: Eigenvalues in descending order (column vector).
%   explained: Percentage of total variance explained by each component.
%
%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its
%   Applications in Face Recognition and Active Shape Models.
%   arXiv:1207.3538 [cs.CV], 2012.

%% Input validation
narginchk(2, 2);
if ~isnumeric(X) || isempty(X)
    error('Input X must be a non-empty numeric matrix.');
end
if d > size(X, 2)
    warning('Target dimension d is greater than original feature count. Setting d = %d.', size(X, 2));
    d = size(X, 2);
end

%% Eigenvalue analysis
Sx = cov(X);
[V, D] = eig(Sx);
eigValue = diag(D);

% Sort eigenvalues descending
[eigValue, IX] = sort(eigValue, 'descend');
eigVector = V(:, IX);

% Numerical stability: remove tiny negative eigenvalues
eigValue(eigValue < 0) = 0;

% Calculate explained variance
totalVar = sum(eigValue);
if totalVar > 0
    explained = eigValue / totalVar;
else
    explained = zeros(size(eigValue));
end

%% Normalization
norm_eigVector = sqrt(sum(eigVector.^2));
eigVector = bsxfun(@rdivide, eigVector, norm_eigVector);

%% Dimensionality reduction
eigVector = eigVector(:, 1:d);
explained = explained(1:d);

% Center the data before projection
meanX = mean(X);
centeredX = bsxfun(@minus, X, meanX);
Y = centeredX * eigVector;
