% Unit test for new features: Laplacian, Sigmoid, Sigma estimation, and PCA Inverse
% Run this from the tests/ directory

% Add library to path
addpath('../code');

% Test data
X = rand(20, 10);

%% Test Laplacian Kernel
para_lap = 1.5;
K_lap = kernel(X, 'laplacian', para_lap);
assert(size(K_lap, 1) == 20 && size(K_lap, 2) == 20);
assert(max(abs(diag(K_lap) - 1)) < 1e-7); 

%% Test Sigmoid Kernel
para_sig = [0.01, 1];
K_sig = kernel(X, 'sigmoid', para_sig);
assert(size(K_sig, 1) == 20 && size(K_sig, 2) == 20);

%% Test Sigma Estimation (Median Trick)
sigma = estimateSigma(X);
assert(sigma > 0);
fprintf('Estimated sigma: %f\n', sigma);

%% Test PCA Inverse
d = 3;
[Y, P, eigValue, expV] = PCA(X, d);
meanX = mean(X);
X_rec = PCA_Inverse(Y, P, meanX);

% Reconstructed data should match original data in the top-d space
% (Here we just check if it's the correct dimension)
assert(size(X_rec, 1) == 20 && size(X_rec, 2) == 10);

fprintf('test_new_features passed\n');
