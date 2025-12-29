addpath('../code');

X = rand(10, 5);
d = 2;
[Y, eigVector, eigValue] = kPCA(X, d, 'gaussian', 1);

assert(size(Y, 1) == 10);
assert(size(Y, 2) == d);
assert(size(eigVector, 2) == d);
fprintf('test_kPCA passed\n');
