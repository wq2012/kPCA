%% Face Active Shape Model Demo (kPCA)
%   This demo shows how to use kPCA for modeling face shapes.
%   Dataset: A subset of BioID database.
%
%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its
%   Applications in Face Recognition and Active Shape Models.
%   arXiv:1207.3538 [cs.CV], 2012.

clear; clc; close all;

%% Initialization
addpath('../code');
type = 'gaussian';
load points_20.mat;
d = 5; % Number of features used for reconstruction
meanX = mean(X);
k = 3; % Range of b (variation parameter)

%% Automatic parameter selection using the median trick
para = estimateSigma(X);

%% Kernel PCA
[Y, eigVector, eigValue] = kPCA(X, d, type, para);

%% kPCA ASM - Statistical modeling in the kernel space
meanY = mean(Y)';
stdY = std(Y)';

%% Reconstruction and Visualization
% Visualize variations captured by each kernel principal component
for FigureID = 1:d
    figure;
    temp = k * stdY(FigureID);
    bd = linspace(-temp, temp, 6);
    b = repmat(meanY, 1, 6);
    b(FigureID, :) = bd;
    
    % Plot shapes by reconstructing from pre-images
    for i = 1:6
        subplot(3, 2, i);
        shape = kPCA_PreImage(b(:, i), eigVector, X, para);
        drawFaceModel(shape');
    end
end



