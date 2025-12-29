% Unit test for distanceMatrix.m
% Run this from the tests/ directory

% Add library to path
addpath('../code');

% Test data
X = [0 0; 1 1; 2 2];

% Compute distance matrix
D = distanceMatrix(X);

% Expected results
expected_D = [0, sqrt(2), sqrt(8); 
              sqrt(2), 0, sqrt(2);
              sqrt(8), sqrt(2), 0];

% Verify results
assert(norm(D - expected_D) < 1e-10);
fprintf('test_distanceMatrix passed\n');
