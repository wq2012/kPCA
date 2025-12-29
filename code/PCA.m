function [Y, eigVector, eigValue] = PCA(X, d)
% PCA performs standard Principal Component Analysis.
%
%   Usage:
%   [Y, eigVector, eigValue] = PCA(X, d)
%
%   Input:
%   X: Data matrix - Each row is one observation, each column is one feature.
%   d: Reduced dimension - The number of principal components to retain.
%
%   Output:
%   Y: Dimensionality-reduced data matrix.
%   eigVector: The principal component vectors (eigenvectors).
%   eigValue: The eigenvalues in descending order.
%
%   Warning: This function is not optimized for very high dimensional data!
%
%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its
%   Applications in Face Recognition and Active Shape Models.
%   arXiv:1207.3538 [cs.CV], 2012.

%% Eigenvalue analysis
Sx = cov(X);
[V, D] = eig(Sx);
eigValue = diag(D);
[eigValue, IX] = sort(eigValue, 'descend');
eigVector = V(:, IX);

%% Normalization
norm_eigVector = sqrt(sum(eigVector.^2));
eigVector = eigVector ./ repmat(norm_eigVector, size(eigVector, 1), 1);

%% Dimensionality reduction
eigVector = eigVector(:, 1:d);
Y = X * eigVector;

