function Z = kPCA_NewData(Y, X, eigVector, type, para)
% KPCA_NEWDATA projects new data points into the kPCA space.
%
%   Usage:
%   Z = kPCA_NewData(Y, X, eigVector, type, para)
%
%   Input:
%   Y: New data matrix (K x M) - Each row is a new observation.
%   X: Training data matrix (N x M) - Each row is a training observation.
%   eigVector: Eigenvectors (N x d) obtained from the kPCA of training data.
%   type: Type of kernel, can be 'simple', 'poly', or 'gaussian'.
%   para: Parameter for the kernel.
%
%   Output:
%   Z: Dimensionality-reduced new data (K x d).
%
%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its
%   Applications in Face Recognition and Active Shape Models.
%   arXiv:1207.3538 [cs.CV], 2012.

K = kernel_NewData(Y, X, type, para);
Z = K * eigVector;
