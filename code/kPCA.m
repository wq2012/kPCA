function [Y, eigVector, eigValue] = kPCA(X, d, type, para)
% KPCA performs Kernel Principal Component Analysis.
%
%   Usage:
%   [Y, eigVector, eigValue] = kPCA(X, d, type, para)
%
%   Input:
%   X: Data matrix - Each row is one observation, each column is one feature.
%   d: Reduced dimension - The number of principal components to retain.
%   type: Type of kernel, can be 'simple', 'poly', or 'gaussian'.
%   para: Parameter for the kernel.
%       - For 'simple': Ignored.
%       - For 'poly': The power parameter.
%       - For 'gaussian': The sigma parameter.
%
%   Output:
%   Y: Dimensionality-reduced data matrix.
%   eigVector: The principal component vectors in the kernel space.
%   eigValue: The eigenvalues in descending order.
%
%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its
%   Applications in Face Recognition and Active Shape Models.
%   arXiv:1207.3538 [cs.CV], 2012.

%% Check input validity
if ~(strcmp(type, 'simple') || strcmp(type, 'poly') || strcmp(type, 'gaussian'))
    Y = [];
    eigVector = [];
    eigValue = [];
    fprintf('\nError: Kernel type %s is not supported.\n', type);
    return;
end

N = size(X, 1);

%% Kernel PCA
K0 = kernel(X, type, para);
oneN = ones(N, N) / N;
% Center the kernel matrix
K = K0 - oneN * K0 - K0 * oneN + oneN * K0 * oneN;

%% Eigenvalue analysis
[V, D] = eig(K / N);
eigValue = diag(D);
[eigValue, IX] = sort(eigValue, 'descend');
eigVector = V(:, IX);

%% Normalization
norm_eigVector = sqrt(sum(eigVector.^2));
eigVector = eigVector ./ repmat(norm_eigVector, size(eigVector, 1), 1);

%% Dimensionality reduction
eigVector = eigVector(:, 1:d);
Y = K0 * eigVector;
