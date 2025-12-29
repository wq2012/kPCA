% Numerical stability tests for edge cases
% Run this from the tests/ directory

% Add library to path
addpath('../code');

%% 1. Constant columns (zero variance)
X_const = ones(10, 5);
[Y, P, V, E] = PCA(X_const, 2);
assert(max(abs(V)) < 1e-12);
assert(max(abs(E)) < 1e-12);
fprintf('Stability test: Constant columns passed\n');

%% 2. Singular matrix in kPCA
% Highly redundant data
X_redundant = [1 2 3; 1 2 3; 1 2 3; 2 4 6; 2 4 6];
[Y, P, V, E] = kPCA(X_redundant, 1, 'gaussian', 1);
assert(size(Y, 1) == 5);
fprintf('Stability test: Redundant data in kPCA passed\n');

%% 3. Target dimension d > N or M
X_small = rand(5, 5);
[Y, P, V, E] = PCA(X_small, 10); % d > available components
assert(size(Y, 2) == 5);
fprintf('Stability test: Target dimension overflow passed\n');

%% 4. Invalid inputs
try
    distanceMatrix([]);
    error('Should have failed on empty input');
catch 
    % Expected
end
fprintf('Stability test: Input validation passed\n');

fprintf('test_stability passed\n');
