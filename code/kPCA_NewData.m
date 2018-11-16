%   Y: new data martix
%   X: training data matrix, each row is one observation, each column is one feature
%   d: reduced dimension
%   type: type of kernel, can be 'simple', 'poly', or 'gaussian'
%   para: parameter for computing the 'poly' and 'gaussian' kernel, 
%       for 'simple' it will be ignored
%   Z: dimensionanlity-reduced data
%   eigVector: eigen-vector, will later be used for pre-image
%       reconstruction

%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its
%   Applications in Face Recognition and Active Shape Models.
%   arXiv:1207.3538 [cs.CV], 2012.

function Z=kPCA_NewData(Y,X,eigVector,type,para)

K=kernel_NewData(Y,X,type,para);
Z=K*eigVector;
