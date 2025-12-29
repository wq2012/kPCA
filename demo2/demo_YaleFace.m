%% Yale Face Database Classification Demo
%   This demo compares PCA and kPCA for face recognition tasks.
%   Dataset: A subset of Yale Face Database B.
%
%   Note: This demo requires the 'statistics' package for 'pca' and 'classify'.
%
%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its
%   Applications in Face Recognition and Active Shape Models.
%   arXiv:1207.3538 [cs.CV], 2012.

clear; clc; close all;

% Add library to path
addpath('../code');

% Load statistics package for pca and classify
if is_octave()
    pkg load statistics;
end

% Load dataset
load YaleFaceData.mat;

d = 9; % Target dimension

%% Standard PCA
disp('Performing standard PCA...');
% Using built-in 'pca' function from statistics package as per repository convention
[eigVector, ~] = pca(train_x);
eigVector = eigVector(:, 1:d);
train_PCA = train_x * eigVector;
test_PCA = test_x * eigVector;

%% Gaussian Kernel PCA
disp('Performing Gaussian kernel PCA...');
type = 'gaussian';

% Automatic parameter selection using the median trick
para = estimateSigma(train_x);

[train_kPCA, eigVector] = kPCA(train_x, d, type, para);
test_kPCA = kPCA_NewData(test_x, train_x, eigVector, type, para);

%% Classification and Error Calculation
% Using 1-Nearest Neighbor classifier for compatibility with Octave
disp('Calculating error rates...');

% PCA - Training Data
class = classify_1nn(train_PCA, train_PCA, train_t);
error_PCA_train = sum(class(:) ~= train_t(:)) / length(train_t);

% PCA - Testing Data
class = classify_1nn(test_PCA, train_PCA, train_t);
error_PCA_test = sum(class(:) ~= test_t(:)) / length(test_t);

% kPCA - Training Data
class = classify_1nn(train_kPCA, train_kPCA, train_t);
error_kPCA_train = sum(class(:) ~= train_t(:)) / length(train_t);

% kPCA - Testing Data
class = classify_1nn(test_kPCA, train_kPCA, train_t);
error_kPCA_test = sum(class(:) ~= test_t(:)) / length(test_t);

%% Display results
fprintf('Error rate of PCA  on training data: %f\n', error_PCA_train);
fprintf('Error rate of PCA  on testing data:  %f\n', error_PCA_test);
fprintf('Error rate of kPCA on training data: %f\n', error_kPCA_train);
fprintf('Error rate of kPCA on testing data:  %f\n', error_kPCA_test);
