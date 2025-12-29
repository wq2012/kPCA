function K = kernel_NewData(Y, X, type, para)
% KERNEL_NEWDATA computes the kernel matrix between new data and training data.
%
%   Usage:
%   K = kernel_NewData(Y, X, type, para)
%
%   Input:
%   Y: New data matrix (K x M) - Each row is one observation.
%   X: Training data matrix (N x M) - Each row is one observation.
%   type: Type of kernel, can be 'simple', 'poly', 'gaussian', 'laplacian', or 'sigmoid'.
%   para: Parameter for the kernel.
%       - For 'simple': Ignored.
%       - For 'poly': The power parameter.
%       - For 'gaussian', 'laplacian': The sigma parameter.
%       - For 'sigmoid': A two-element vector [alpha, beta] for alpha*X*Y' + beta.
%
%   Output:
%   K: The computed kernel matrix (size of Y vs size of X).
%
%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its
%   Applications in Face Recognition and Active Shape Models.
%   arXiv:1207.3538 [cs.CV], 2012.

%% Input validation
narginchk(4, 4);
validTypes = {'simple', 'poly', 'gaussian', 'laplacian', 'sigmoid'};
if ~any(strcmp(type, validTypes))
    error('Kernel type %s is not supported.', type);
end

N = size(X, 1);

if strcmp(type, 'simple')
    % Linear kernel: K = Y * X'
    K = Y * X';
end

if strcmp(type, 'poly')
    % Polynomial kernel: K = (Y * X' + 1)^para
    K = Y * X' + 1;
    K = K.^para;
end

if strcmp(type, 'gaussian')
    % Gaussian (RBF) kernel: K = exp(-||y-x||^2 / (2 * para^2))
    K = distanceMatrix([X; Y]);
    K = K(N+1:end, 1:N);
    K = K.^2;
    K = exp(-K ./ (2 * para^2));
end

if strcmp(type, 'laplacian')
    % Laplacian kernel: K = exp(-||y-x|| / para)
    K = distanceMatrix([X; Y]);
    K = K(N+1:end, 1:N);
    K = exp(-K ./ para);
end

if strcmp(type, 'sigmoid')
    % Sigmoid kernel: K = tanh(alpha * Y * X' + beta)
    % para = [alpha, beta]
    K = tanh(para(1) * (Y * X') + para(2));
end
