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

%% Test kPCA with stats and kPCA_NewData efficiency
data = rand(20, 5);
[Y, eigVector, eigValue, explained, stats] = kPCA(data, 2, 'gaussian', 1);
assert(isstruct(stats), 'kPCA should return stats struct');
assert(isfield(stats, 'colMeans'), 'stats should contain colMeans');

newData = rand(5, 5);
Z1 = kPCA_NewData(newData, data, eigVector, 'gaussian', 1);
Z2 = kPCA_NewData(newData, data, eigVector, 'gaussian', 1, stats);
assert(max(abs(Z1(:) - Z2(:))) < 1e-10, 'kPCA_NewData with stats should match baseline');

%% Test kPCA_PreImage with initial guess
z0 = mean(data)';
z_rec = kPCA_PreImage(Y(1, :), eigVector, data, 1, z0);
assert(length(z_rec) == 5, 'Pre-image should have correct dimension');

fprintf('test_extensions passed\n');
