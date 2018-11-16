%%  This is a demo showing how to use this toolbox
%   This experiment is performed on a subset of Yale Face Database B

%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its 
%   Applications in Face Recognition and Active Shape Models. 
%   arXiv:1207.3538 [cs.CV], 2012. 

clear;clc;close all;

addpath('../code');
load YaleFaceData.mat;

d=9;

%% standard PCA
disp('Performing standard PCA...');
[eigVector,~]=pca(train_x);
eigVector=eigVector(:,1:d);
train_PCA=train_x*eigVector;
test_PCA=test_x*eigVector;

%% Gaussian kernel PCA
disp('Performing Gaussian kernel PCA...');
type='gaussian';

DIST=distanceMatrix(train_x);
DIST(DIST==0)=inf;
DIST=min(DIST);
para=5*mean(DIST);

[train_kPCA, eigVector]=kPCA(train_x,d,type,para);
test_kPCA=kPCA_NewData(test_x,train_x,eigVector,type,para);

%% classification
% PCA train
class = classify(train_PCA,train_PCA,train_t);
error_PCA_train=sum(class'~=train_t)/length(train_t);

% PCA test
class = classify(test_PCA,train_PCA,train_t);
error_PCA_test=sum(class'~=test_t)/length(test_t);

% kPCA train
class = classify(train_kPCA,train_kPCA,train_t);
error_kPCA_train=sum(class'~=train_t)/length(train_t);

% kPCA test
class = classify(test_kPCA,train_kPCA,train_t);
error_kPCA_test=sum(class'~=test_t)/length(test_t);

fprintf('error rate of PCA on training data: %f \n',error_PCA_train);
fprintf('error rate of PCA on testing data: %f \n',error_PCA_test);
fprintf('error rate of kPCA on training data: %f \n',error_kPCA_train);
fprintf('error rate of kPCA on testing data: %f \n',error_kPCA_test);
