% Unit test for kPCA.m
% Run this from the tests/ directory

% Add library to path
addpath('../code');

% Test data
X = rand(10, 5);
d = 2;

% Perform kPCA
[Y, eigVector, eigValue, explained] = kPCA(X, d, 'gaussian', 1);

% Verify dimensions
assert(size(Y, 1) == 10);
assert(size(Y, 2) == d);
assert(size(eigVector, 2) == d);

% Verify explained variance
assert(length(explained) == d);
assert(all(explained >= 0));
assert(sum(explained) <= 1.00001); % Sum of top d components <= total

fprintf('test_kPCA passed\n');
