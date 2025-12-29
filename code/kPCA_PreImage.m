function z = kPCA_PreImage(y, eigVector, X, para)
% KPCA_PREIMAGE reconstructs the pre-image of a point in the kPCA space.
%   This implementation is specifically for the Gaussian (RBF) kernel.
%
%   Usage:
%   z = kPCA_PreImage(y, eigVector, X, para)
%
%   Input:
%   y: Dimensionality-reduced data point (1 x d).
%   eigVector: Eigenvectors (N x d) obtained from kPCA.
%   X: Original training data matrix (N x M).
%   para: Sigma parameter of the Gaussian kernel.
%
%   Output:
%   z: The reconstructed pre-image (M x 1) in the original input space.
%
%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its
%   Applications in Face Recognition and Active Shape Models.
%   arXiv:1207.3538 [cs.CV], 2012.

%% Input validation
narginchk(4, 4);

max_iter = 1000;
N = size(X, 1);
d = max(size(y));

gamma = zeros(1, N);
for i = 1:N
    gamma(i) = eigVector(i, 1:d) * y;
end

z = mean(X)'; % Initialization with the data mean
for count = 1:max_iter
    pre_z = z;
    
    % Compute distances and Gaussian weights
    xx = bsxfun(@minus, X', z);
    xx = xx.^2;
    xx = -sum(xx) / (2 * para^2);
    xx = exp(xx);
    xx = xx .* gamma;
    
    % Update estimate
    z = xx * X / sum(xx);
    z = z';
    
    % Check for convergence
    if norm(pre_z - z) / norm(z) < 1e-5
        break;
    end
end
