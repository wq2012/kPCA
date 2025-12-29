function z = kPCA_PreImage(y, eigVector, X, para, z0)
% KPCA_PREIMAGE reconstructs the pre-image of a point in the kPCA space.
%   This implementation is specifically for the Gaussian (RBF) kernel.
%
%   Usage:
%   z = kPCA_PreImage(y, eigVector, X, para, [z0])
%
%   Input:
%   y: Dimensionality-reduced data point (1 x d).
%   eigVector: Eigenvectors (N x d) obtained from kPCA.
%   X: Original training data matrix (N x M).
%   para: Sigma parameter of the Gaussian kernel.
%   z0: (Optional) Initial guess for the pre-image (M x 1).
%
%   Output:
%   z: The reconstructed pre-image (M x 1) in the original input space.
%
%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its
%   Applications in Face Recognition and Active Shape Models.
%   arXiv:1207.3538 [cs.CV], 2012.

%% Input validation
narginchk(4, 5);

max_iter = 1000;
N = size(X, 1);
d = length(y);

gamma = zeros(1, N);
for i = 1:N
    gamma(i) = eigVector(i, 1:d) * y(:);
end

% Adjust gamma for centered kPCA (accounting for feature space mean)
gamma = gamma + (1 - sum(gamma)) / N;

%% Fixed-point iteration with multiple restarts
initializations = [mean(X); X(1, :); X(end, :); X(round(N/2), :)];
if nargin >= 5 && ~isempty(z0)
    initializations = [z0'; initializations];
end

best_z = mean(X)';
min_error = inf;

for r = 1:size(initializations, 1)
    z = initializations(r, :)';
    for count = 1:max_iter
        pre_z = z;
        
        % Compute distances and Gaussian weights
        xx = bsxfun(@minus, X', z);
        xx = sum(xx.^2, 1);
        xx = exp(-xx / (2 * para^2));
        xx = xx .* gamma;
        
        % Update estimate
        sum_weights = sum(xx);
        if abs(sum_weights) < 1e-15
            break; % Avoid division by zero
        end
        z = (xx * X / sum_weights)';
        
        % Check for convergence
        if norm(pre_z - z) / (norm(z) + 1e-10) < 1e-6
            break;
        end
    end
    
    % Evaluate reconstruction error in feature space: ||Phi(z) - P_d Phi(z)||^2
    % (For Gaussian kernel, ||Phi(z)||^2 = 1)
    % Error = 1 - 2*gamma*k(z, X) + gamma*K*gamma'
    kz = exp(-sum(bsxfun(@minus, X', z).^2, 1) / (2 * para^2));
    error = 1 - 2 * (gamma * kz'); % Constant term 1 + gamma*K*gamma' is omitted
    
    if error < min_error
        min_error = error;
        best_z = z;
    end
end

z = best_z;
