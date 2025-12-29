% Unit test for end-to-end kPCA reconstruction (pre-image)
% Run this from the tests/ directory

% Add library to path
addpath('../code');

% 1. Generate Synthetic Data (Spiral)
t = linspace(0, 2*pi, 50)';
X = [t.*cos(t), t.*sin(t)];
X = (X - mean(X)) ./ std(X); % Normalize

% 2. kPCA Parameters
type = 'gaussian';
para = estimateSigma(X) * 2; % Use a smoother manifold
d = 10; % Use more components for reconstruction

% 3. Perform kPCA
[Y, eigVector, eigValue, explained, stats] = kPCA(X, d, type, para);

% 4. Reconstruct original points using pre-image
X_rec = zeros(size(X));
fprintf('Reconstructing %d points with %d components...\n', size(X, 1), d);
for i = 1:size(X, 1)
    % Use the training point itself as an initial guess for stability
    X_rec(i, :) = kPCA_PreImage(Y(i, :), eigVector, X, para, X(i, :)')';
end

% 5. Calculate MSE
mse = mean(sum((X - X_rec).^2, 2));
fprintf('Mean Squared Error: %f\n', mse);

% 6. Verification
% Pre-image reconstruction is an approximation. 
assert(mse < 0.05, sprintf('Reconstruction error too high: %f', mse));

fprintf('test_reconstruction passed\n');
