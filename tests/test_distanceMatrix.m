addpath('../code');

X = [0 0; 1 1; 2 2];
D = distanceMatrix(X);

expected_D = [0, sqrt(2), sqrt(8); 
              sqrt(2), 0, sqrt(2);
              sqrt(8), sqrt(2), 0];

assert(norm(D - expected_D) < 1e-10);
fprintf('test_distanceMatrix passed\n');
