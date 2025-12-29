% Unit test for PCA.m
% Run this from the tests/ directory

% Add library to path
addpath('../code');

% Test data
X = [1 2; 2 1; 3 4; 4 3];
d = 1;

% Perform PCA
[Y, eigVector, eigValue] = PCA(X, d);

% Verify dimensions
assert(size(Y, 2) == d);
assert(size(eigVector, 2) == d);
assert(length(eigValue) == size(X, 2));

fprintf('test_PCA passed\n');
