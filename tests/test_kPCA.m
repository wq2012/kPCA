% Unit test for kPCA.m
% Run this from the tests/ directory

% Add library to path
addpath('../code');

% Test data
X = rand(10, 5);
d = 2;

% Perform kPCA
[Y, eigVector, eigValue] = kPCA(X, d, 'gaussian', 1);

% Verify dimensions
assert(size(Y, 1) == 10);
assert(size(Y, 2) == d);
assert(size(eigVector, 2) == d);

fprintf('test_kPCA passed\n');
