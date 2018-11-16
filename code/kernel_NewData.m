%   Y: new data matrix
%   X: training data matrix, each row is one observation, each column is one feature
%   type: type of kernel, can be 'simple', 'poly', or 'gaussian'
%   para: parameter for computing the 'poly' kernel, for 'simple'
%       and 'gaussian' it will be ignored
%   K: kernel matrix

%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its
%   Applications in Face Recognition and Active Shape Models.
%   arXiv:1207.3538 [cs.CV], 2012.

function K=kernel_NewData(Y,X,type,para)

N=size(X,1);

if strcmp(type,'simple')
    K=Y*X';
end

if strcmp(type,'poly')
    K=Y*X'+1;
    K=K.^para;
end

if strcmp(type,'gaussian')
    K=distanceMatrix([X;Y]);
    K=K(N+1:end,1:N);
    K=K.^2;
    K=exp(-K./(2*para.^2));
end
