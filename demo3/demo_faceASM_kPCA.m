%%  This is a demo showing how to use this toolbox
%   This experiment is performed on a subset of BioID database

%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its 
%   Applications in Face Recognition and Active Shape Models. 
%   arXiv:1207.3538 [cs.CV], 2012. 

clear;clc;close all;

%% initialization
addpath('../code');
type='gaussian';
load points_20.mat;
d=5; % how many features are used reconstruction
meanX=mean(X);
k=3;  % the range of b

%% auto parameter
DIST=distanceMatrix(X);
DIST(DIST==0)=inf;
DIST=min(DIST);
para=5*mean(DIST);

%% kernel PCA
[Y, eigVector, eigValue]=kPCA(X,d,type,para);

%% kPCA ASM
meanY=mean(Y)';
stdY=std(Y)';

%% reconstruction
for FigureID=1:d
    figure;
    temp=k*stdY(FigureID);
    bd=linspace(-temp,temp,6);
    b=repmat(meanY,1,6);
    b(FigureID,:)=bd;
    
    % plot
    for i=1:6
        subplot(3,2,i);
        shape=kPCA_PreImage(b(:,i),eigVector,X,para);
        drawFaceModel(shape');
    end
end



