% Unit test for PCA.m
% Run this from the tests/ directory

% Add library to path
addpath('../code');

% Test data
X = [1 2; 2 1; 3 4; 4 3];
d = 1;

% Perform PCA
[Y, eigVector, eigValue, explained] = PCA(X, d);

% Verify dimensions
assert(size(Y, 1) == size(X, 1));
assert(size(Y, 2) == d);
assert(size(eigVector, 2) == d);
assert(length(eigValue) == size(X, 2));

% Verify explained variance
assert(length(explained) == d);
assert(abs(sum(explained) - sum(eigValue(1:d))/sum(eigValue)) < 1e-10);

fprintf('test_PCA passed\n');
