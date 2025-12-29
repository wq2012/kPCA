%% Synthetic Data Embedding Demo
%   This demo demonstrates kPCA on two concentric spheres.
%
%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its
%   Applications in Face Recognition and Active Shape Models.
%   arXiv:1207.3538 [cs.CV], 2012.

clear; clc; close all;

% Add library to path
addpath('../code');

% Load dataset
load SyntheticData.mat;
d = 2; % Target dimension

%% Visualize original data
figure; hold on;
plot3(data(1:2:end, 1), data(1:2:end, 2), data(1:2:end, 3), 'b*');
plot3(data(2:2:end, 1), data(2:2:end, 2), data(2:2:end, 3), 'ro');
legend('Class 1', 'Class 2');
axis equal;
xlabel('x'); ylabel('y'); zlabel('z');
axis([-110 110 -110 110 -110 110]);
title('Original 3D Data');
drawnow;

%% Standard PCA
disp('Performing standard PCA...');
Y1 = PCA(data, d);
figure; hold on;
plot(Y1(1:2:end, 1), Y1(1:2:end, 2), 'b*');
plot(Y1(2:2:end, 1), Y1(2:2:end, 2), 'ro');
legend('Class 1', 'Class 2');
title('Result of Standard PCA');
drawnow;

%% Polynomial Kernel PCA
poly_para = 5;
disp('Performing polynomial kernel PCA...');
[Y2] = kPCA(data, d, 'poly', poly_para);
figure; hold on;
plot(Y2(1:2:end, 1), Y2(1:2:end, 2), 'b*');
plot(Y2(2:2:end, 1), Y2(2:2:end, 2), 'ro');
legend('Class 1', 'Class 2');
title(sprintf('Polynomial Kernel PCA (para=%d)', poly_para));
drawnow;

%% Gaussian Kernel PCA
% Automatic parameter selection based on mean distance
DIST = distanceMatrix(data);
DIST(DIST == 0) = inf;
DIST = min(DIST);
gauss_para = 5 * mean(DIST);

disp('Performing Gaussian kernel PCA...');
[Y3, eigVector] = kPCA(data, d, 'gaussian', gauss_para);
figure; hold on;
plot(Y3(1:2:end, 1), Y3(1:2:end, 2), 'b*');
plot(Y3(2:2:end, 1), Y3(2:2:end, 2), 'ro');
legend('Class 1', 'Class 2');
title(sprintf('Gaussian Kernel PCA (para=%.2f)', gauss_para));
drawnow;

%% Pre-image reconstruction for Gaussian kernel PCA
% This section is computationally intensive and is provided for reference.
% disp('Performing kPCA pre-image reconstruction...');
% PI = zeros(size(data)); % pre-image
% for i = 1:size(data, 1)
%     PI(i, :) = kPCA_PreImage(Y3(i, :)', eigVector, data, gauss_para)';
% end
% 
% figure; hold on;
% plot3(PI(1:2:end, 1), PI(1:2:end, 2), PI(1:2:end, 3), 'b*');
% plot3(PI(2:2:end, 1), PI(2:2:end, 2), PI(2:2:end, 3), 'ro');
% title('Reconstructed Pre-images (Gaussian kPCA)');

