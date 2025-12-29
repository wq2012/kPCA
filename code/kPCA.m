function [Y, eigVector, eigValue, explained, stats] = kPCA(X, d, type, para)
% KPCA performs Kernel Principal Component Analysis.
%
%   Usage:
%   [Y, eigVector, eigValue, explained, stats] = kPCA(X, d, type, para)
%
%   Input:
%   X: Data matrix - Each row is one observation, each column is one feature.
%   d: Reduced dimension - The number of principal components to retain.
%   type: Type of kernel, can be 'simple', 'poly', 'gaussian', 'laplacian', or 'sigmoid'.
%   para: Parameter for the kernel.
%       - For 'simple': Ignored.
%       - For 'poly': The power parameter.
%       - For 'gaussian', 'laplacian': The sigma parameter.
%       - For 'sigmoid': A two-element vector [alpha, beta] for alpha*X*Y' + beta.
%
%   Output:
%   Y: Dimensionality-reduced data matrix (N x d).
%   eigVector: The principal component vectors in the kernel space.
%   eigValue: The eigenvalues in descending order (column vector).
%   explained: Percentage of total variance explained by each component.
%   stats: Struct containing centering statistics for use in kPCA_NewData.
%
%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its
%   Applications in Face Recognition and Active Shape Models.
%   arXiv:1207.3538 [cs.CV], 2012.

%% Input validation
narginchk(4, 4);
if ~isnumeric(X) || isempty(X)
    error('Input X must be a non-empty numeric matrix.');
end
validTypes = {'simple', 'poly', 'gaussian', 'laplacian', 'sigmoid'};
if ~any(strcmp(type, validTypes))
    error('Kernel type %s is not supported. Supported types: %s', type, strjoin(validTypes, ', '));
end

N = size(X, 1);

%% Kernel PCA
K0 = kernel(X, type, para);

% Efficient centering (O(N^2) time and space)
% K = K0 - 1/N*ones(N,N)*K0 - 1/N*K0*ones(N,N) + 1/N^2*ones(N,N)*K0*ones(N,N)
% Centering stats for kPCA_NewData
stats.colMeans = mean(K0, 1);
rowMeans = mean(K0, 2);
stats.totalMean = mean(stats.colMeans);

K = bsxfun(@minus, K0, rowMeans);
K = bsxfun(@minus, K, stats.colMeans);
K = K + stats.totalMean;

%% Eigenvalue analysis
[V, D] = eig(K / N);
eigValue = diag(D);

% Sort eigenvalues descending
[eigValue, IX] = sort(eigValue, 'descend');
V = V(:, IX);

% Numerical stability: remove negative or very tiny eigenvalues
eigValue(eigValue < 0) = 0;

% Calculate explained variance
totalVar = sum(eigValue);
if totalVar > 0
    explained = eigValue / totalVar;
else
    explained = zeros(size(eigValue));
end

%% Normalization
% Eigenvectors alpha of K should be normalized such that alpha' * K * alpha = 1
% alpha = V / sqrt(N * D)
eigVector = bsxfun(@rdivide, V, sqrt(N * eigValue' + 1e-15));

%% Dimensionality reduction
eigVector = eigVector(:, 1:d);
explained = explained(1:d);

% Use centered kernel matrix for projection
Y = K * eigVector;
