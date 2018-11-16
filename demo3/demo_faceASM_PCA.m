%%  This is a demo showing how to use this toolbox
%   This experiment is performed on a subset of BioID database

%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its 
%   Applications in Face Recognition and Active Shape Models. 
%   arXiv:1207.3538 [cs.CV], 2012. 

clear;clc;close all;

%% initialization
addpath('../code');
load points_20.mat;
d=5; % how many features are used reconstruction
meanX=mean(X);
k=3; % the range of b

%% PCA ASM
[Y, eigVector, eigValue]=PCA(X,d);

P=eigVector(:,1:d);

for FigureID=1:d
    figure;
    temp=k*sqrt(abs(eigValue(FigureID)));
    bd=linspace(-temp,temp,6);
    b=zeros(d,6);
    b(FigureID,:)=bd;
    
    % plot
    for i=1:6
        subplot(3,2,i);
        shape=meanX'+P*b(:,i);
        drawFaceModel(shape');
    end
end

