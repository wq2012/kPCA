function K = kernel(X, type, para)
% KERNEL computes the kernel matrix for a given data matrix.
%
%   Usage:
%   K = kernel(X, type, para)
%
%   Input:
%   X: Data matrix - Each row is one observation, each column is one feature.
%   type: Type of kernel, can be 'simple', 'poly', 'gaussian', 'laplacian', or 'sigmoid'.
%   para: Parameter for the kernel.
%       - For 'simple': Ignored.
%       - For 'poly': The power parameter.
%       - For 'gaussian', 'laplacian': The sigma parameter.
%       - For 'sigmoid': A two-element vector [alpha, beta] for alpha*X*Y' + beta.
%
%   Output:
%   K: The computed N x N kernel matrix.
%
%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its
%   Applications in Face Recognition and Active Shape Models.
%   arXiv:1207.3538 [cs.CV], 2012.

%% Input validation
narginchk(3, 3);
validTypes = {'simple', 'poly', 'gaussian', 'laplacian', 'sigmoid'};
if ~any(strcmp(type, validTypes))
    error('Kernel type %s is not supported.', type);
end

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

if strcmp(type, 'laplacian')
    % Laplacian kernel: K = exp(-||x-y|| / para)
    K = distanceMatrix(X);
    K = exp(-K ./ para);
end

if strcmp(type, 'sigmoid')
    % Sigmoid kernel: K = tanh(alpha * X * X' + beta)
    % para = [alpha, beta]
    K = tanh(para(1) * (X * X') + para(2));
end
