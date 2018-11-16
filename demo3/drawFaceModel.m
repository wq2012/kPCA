%   This functions roughly draws the human face model of BioID database

%   Copyright by Quan Wang, 2011/05/10
%   Please cite: Quan Wang. Kernel Principal Component Analysis and its 
%   Applications in Face Recognition and Active Shape Models. 
%   arXiv:1207.3538 [cs.CV], 2012. 

function drawFaceModel(x)

hold on;

i1=[4 5];
i2=[6 7];
i3=[9 0 10];
i4=[11 1 12];
i5=[15 14 16];
i6=[2 17 3 18 2];
i7=[8 19 13];
i8=[0 1]; %eyes

% face contour
yy=x(2*i7+2)';
xx=x(2*i7+1)';
xx=[xx.^2 xx xx.^0];
abc=xx\yy;
x0=linspace(x(2*8+1),x(2*13+1),100);
y0=abc(1)*x0.^2+abc(2)*x0+abc(3)*x0.^0;

% draw
plot(x(2*i1+1),x(2*i1+2));
plot(x(2*i2+1),x(2*i2+2));
plot(x(2*i3+1),x(2*i3+2));
plot(x(2*i4+1),x(2*i4+2));
plot(x(2*i5+1),x(2*i5+2));
plot(x(2*i6+1),x(2*i6+2));
plot(x0,y0);
plot(x(2*i8+1),x(2*i8+2),'o');

axis([-0.1 1.1 -0.1 1.1]);
axis ij;
