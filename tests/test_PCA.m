addpath('../code');

X = [1 2; 2 1; 3 4; 4 3];
d = 1;
[Y, eigVector, eigValue] = PCA(X, d);

assert(size(Y, 2) == d);
assert(size(eigVector, 2) == d);
assert(length(eigValue) == size(X, 2));
fprintf('test_PCA passed\n');
