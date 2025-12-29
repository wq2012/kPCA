%% Face Active Shape Model Demo (PCA)
%   This demo shows how to use PCA for modeling face shapes.
%   Dataset: A subset of BioID database.
%
%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its
%   Applications in Face Recognition and Active Shape Models.
%   arXiv:1207.3538 [cs.CV], 2012.

clear; clc; close all;

%% Initialization
addpath('../code');
load points_20.mat;
d = 5; % Number of features used for reconstruction
meanX = mean(X);
k = 3; % Range of b (variation parameter)

%% PCA Active Shape Model
[Y, eigVector, eigValue] = PCA(X, d);
P = eigVector(:, 1:d);

% Visualize variations captured by each principal component
for FigureID = 1:d
    figure;
    temp = k * sqrt(abs(eigValue(FigureID)));
    bd = linspace(-temp, temp, 6);
    b = zeros(d, 6);
    b(FigureID, :) = bd;
    
    % Plot shapes
    for i = 1:6
        subplot(3, 2, i);
        shape = meanX' + P * b(:, i);
        drawFaceModel(shape');
    end
end

