% Benchmark script for kPCA library optimizations
% Run this from the tests/ directory

addpath('../code');

% Generate large dataset
N = 1000;
M = 100;
X = rand(N, M);
d = 50;

fprintf('--- Benchmarking kPCA Library (N=%d, M=%d) ---\n', N, M);

%% Benchmark distanceMatrix
tic;
for i=1:10
    D = distanceMatrix(X);
end
t_dist = toc / 10;
fprintf('distanceMatrix (10 runs avg): %.4f seconds\n', t_dist);

%% Benchmark PCA
tic;
for i=1:10
    [Y, P, V] = PCA(X, d);
end
t_pca = toc / 10;
fprintf('PCA (10 runs avg):            %.4f seconds\n', t_pca);

%% Benchmark kPCA (Gaussian)
tic;
for i=1:5
    [Y, P, V, E, stats] = kPCA(X, d, 'gaussian', 1);
end
t_kpca = toc / 5;
fprintf('kPCA Gaussian (5 runs avg):   %.4f seconds\n', t_kpca);

%% Benchmark kPCA_NewData
X_new = rand(100, M);

% Without stats
tic;
for i=1:5
    Z1 = kPCA_NewData(X_new, X, P, 'gaussian', 1);
end
t_newdata_no_stats = toc / 5;
fprintf('kPCA_NewData (no stats):      %.4f seconds\n', t_newdata_no_stats);

% With stats
tic;
for i=1:5
    Z2 = kPCA_NewData(X_new, X, P, 'gaussian', 1, stats);
end
t_newdata_stats = toc / 5;
fprintf('kPCA_NewData (with stats):    %.4f seconds\n', t_newdata_stats);
fprintf('  -> Speedup: %.1fx\n', t_newdata_no_stats / t_newdata_stats);

fprintf('--- Benchmark Complete ---\n');
