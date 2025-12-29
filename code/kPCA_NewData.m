function Z = kPCA_NewData(Y, X, eigVector, type, para, stats)
% KPCA_NEWDATA projects new data points into the kPCA space.
%
%   Usage:
%   Z = kPCA_NewData(Y, X, eigVector, type, para, [stats])
%
%   Input:
%   Y: New data matrix (K x M) - Each row is a new observation.
%   X: Training data matrix (N x M) - Each row is a training observation.
%   eigVector: Eigenvectors (N x d) obtained from the kPCA of training data.
%   type: Type of kernel, can be 'simple', 'poly', 'gaussian', 'laplacian', or 'sigmoid'.
%   para: Parameter for the kernel.
%   stats: (Optional) Struct containing centering statistics from kPCA.
%
%   Output:
%   Z: Dimensionality-reduced new data (K x d).
%
%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its
%   Applications in Face Recognition and Active Shape Models.
%   arXiv:1207.3538 [cs.CV], 2012.

%% Input validation
narginchk(5, 6);

K = kernel_NewData(Y, X, type, para);

%% Center the new kernel matrix
% K_new_centered = K_new - 1_k/N * K_train_cols - K_new/N * 1_n + 1_k/N^2 * sum(K_train)
if nargin < 6 || isempty(stats)
    % Fallback: compute centering stats manually if not provided
    K_train = kernel(X, type, para);
    colMeans = mean(K_train, 1);
    totalMean = mean(colMeans);
else
    colMeans = stats.colMeans;
    totalMean = stats.totalMean;
end

rowMeansNew = mean(K, 2);

Z = bsxfun(@minus, K, colMeans);
Z = bsxfun(@minus, Z, rowMeansNew);
Z = Z + totalMean;

%% Final projection
Z = Z * eigVector;
