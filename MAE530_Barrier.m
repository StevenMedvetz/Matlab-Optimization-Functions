% Steven Medvetz
% MAE 530
% Design Project
% Problem 2.23
% Method 3: Barrier Function

clc
clear all

% Initial Point
x0 = [0.3; 0.1];

% Objective Function
r0 = x0(1);
ri = x0(2);
L = 10;
rho = 7850; 
obj = rho.*L.*pi.*(r0.^2-ri.^2);

% Constraints
r0 = x0(1);
ri = x0(2);
P = 14000;
L = 10;
sigma_max = 165*10^6; 
t_max = 50*10^6;  
g(1) = (P*L./((pi/4).*(r0.^4-ri.^4))).*r0-sigma_max;
g(2) = (P./(3.*((pi/4).*(r0.^4-ri.^4)))).*(r0.^2+(r0.*ri)+ri.^2)-t_max;
g(4) = -ri;
g(5) = -r0;
g(6) = r0 - 0.4;
g(7) = ri - r0; 

% Barrier Constrsaints
g(1') = -1./((P*L./((pi/4).*(r0.^4-ri.^4))).*r0-sigma_max);
g(2') = -1./((P./(3.*((pi/4).*(r0.^4-ri.^4)))).*(r0.^2+(r0.*ri)+ri.^2)-t_max);
g(4') = -1./(-ri);
g(5') = -1./(-r0);
g(6') = -1./(r0 - 0.4);
g(7') = -1./(ri - r0); 

% Barrier Function
syms r B P L r0 ri sigma_max t_max
g(1') = -1./((P*L./((pi/4).*(r0.^4-ri.^4))).*r0-sigma_max);
g(2') = -1./((P./(3.*((pi/4).*(r0.^4-ri.^4)))).*(r0.^2+(r0.*ri)+ri.^2)-t_max);
g(4') = -1./(-ri);
g(5') = -1./(-r0);
g(6') = -1./(r0 - 0.4);
g(7') = -1./(ri - r0); 
B = obj + (1./r).* (g(1')+g(2')+g(3')+g(4')+g(5')+g(6'))
