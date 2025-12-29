% Unit test for kernel.m
% Run this from the tests/ directory

% Add library to path
addpath('../code');

% Test data
X = [1 2; 3 4];

%% Test Simple (Linear) Kernel
K_simple = kernel(X, 'simple', []);
expected_simple = X * X';
assert(norm(K_simple - expected_simple) < 1e-10);

%% Test Polynomial Kernel
para_poly = 2;
K_poly = kernel(X, 'poly', para_poly);
expected_poly = (X * X' + 1).^para_poly;
assert(norm(K_poly - expected_poly) < 1e-10);

%% Test Gaussian (RBF) Kernel
para_gaussian = 1;
K_gaussian = kernel(X, 'gaussian', para_gaussian);
D = distanceMatrix(X);
expected_gaussian = exp(-(D.^2) / (2 * para_gaussian^2));
assert(norm(K_gaussian - expected_gaussian) < 1e-10);

fprintf('test_kernel passed\n');
