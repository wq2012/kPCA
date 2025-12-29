addpath('../code');

X = [1 2; 3 4];

% Simple kernel
K_simple = kernel(X, 'simple', []);
expected_simple = X * X';
assert(norm(K_simple - expected_simple) < 1e-10);

% Poly kernel
para_poly = 2;
K_poly = kernel(X, 'poly', para_poly);
expected_poly = (X * X' + 1).^para_poly;
assert(norm(K_poly - expected_poly) < 1e-10);

% Gaussian kernel
para_gaussian = 1;
K_gaussian = kernel(X, 'gaussian', para_gaussian);
D = distanceMatrix(X);
expected_gaussian = exp(-(D.^2) / (2 * para_gaussian^2));
assert(norm(K_gaussian - expected_gaussian) < 1e-10);

fprintf('test_kernel passed\n');
