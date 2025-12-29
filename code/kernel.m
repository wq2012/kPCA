function K = kernel(X, type, para)
% KERNEL computes the kernel matrix for a given data matrix.
%
%   Usage:
%   K = kernel(X, type, para)
%
%   Input:
%   X: Data matrix - Each row is one observation, each column is one feature.
%   type: Type of kernel, can be 'simple', 'poly', or 'gaussian'.
%   para: Parameter for the kernel.
%       - For 'simple': Ignored.
%       - For 'poly': The power parameter.
%       - For 'gaussian': The sigma parameter.
%
%   Output:
%   K: The computed N x N kernel matrix.
%
%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its
%   Applications in Face Recognition and Active Shape Models.
%   arXiv:1207.3538 [cs.CV], 2012.

N = size(X, 1);

if strcmp(type, 'simple')
    % Linear kernel: K = X * X'
    K = X * X';
end

if strcmp(type, 'poly')
    % Polynomial kernel: K = (X * X' + 1)^para
    K = X * X' + 1;
    K = K.^para;
end

if strcmp(type, 'gaussian')
    % Gaussian (RBF) kernel: K = exp(-||x-y||^2 / (2 * para^2))
    K = distanceMatrix(X).^2;
    K = exp(-K ./ (2 * para^2));
end
