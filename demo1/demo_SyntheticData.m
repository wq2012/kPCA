%%  This is a demo showing how to use this toolbox
%   This experiment is performed on synthetic data

%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its 
%   Applications in Face Recognition and Active Shape Models. 
%   arXiv:1207.3538 [cs.CV], 2012. 

clear;clc;close all;

addpath('../code');
load SyntheticData.mat;
d=2;

%% original data
figure;hold on;
plot3(data(1:2:end,1),data(1:2:end,2),data(1:2:end,3),'b*');
plot3(data(2:2:end,1),data(2:2:end,2),data(2:2:end,3),'ro');
legend('class 1','class 2');
axis equal;
xlabel('x');
ylabel('y');
zlabel('z');
axis([-110 110 -110 110 -110 110]);
title('original data');
drawnow;

%% standard PCA
disp('Performing standard PCA...');
Y1=PCA(data,d);
figure;hold on;
plot(Y1(1:2:end,1),Y1(1:2:end,2),'b*');
plot(Y1(2:2:end,1),Y1(2:2:end,2),'ro');
legend('class 1','class 2');
title('standard PCA');
drawnow;

%% polynomial kernel PCA
para=5;
disp('Performing polynomial kernel PCA...');
[Y2]=kPCA(data,d,'poly',para);
figure;hold on;
plot(Y2(1:2:end,1),Y2(1:2:end,2),'b*');
plot(Y2(2:2:end,1),Y2(2:2:end,2),'ro');
legend('class 1','class 2');
title('polynomial kernel PCA');
drawnow;

%% Gaussian kernel PCA
DIST=distanceMatrix(data);
DIST(DIST==0)=inf;
DIST=min(DIST);
para=5*mean(DIST);
disp('Performing Gaussian kernel PCA...');
[Y3, eigVector]=kPCA(data,d,'gaussian',para);
figure;hold on;
plot(Y3(1:2:end,1),Y3(1:2:end,2),'b*');
plot(Y3(2:2:end,1),Y3(2:2:end,2),'ro');
legend('class 1','class 2');
title('Gaussian kernel PCA');
drawnow;

%% pre-image reconstruction for Gaussian kernel PCA
% disp('Performing kPCA pre-image reconstruction...');
% PI=zeros(size(data)); % pre-image
% for i=1:size(data,1)
%     PI(i,:)=kPCA_PreImage(Y3(i,:)',eigVector,data,para)';
% end
% 
% figure;hold on;
% plot3(PI(1:2:end,1),PI(1:2:end,2),PI(1:2:end,3),'b*');
% plot3(PI(2:2:end,1),PI(2:2:end,2),PI(2:2:end,3),'ro');
% title('Reconstructed pre-images of Gaussian kPCA');

