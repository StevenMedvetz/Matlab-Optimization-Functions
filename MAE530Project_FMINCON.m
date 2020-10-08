% Steven Medvetz
% MAE 530
% Design Project
% Problem 2.23
% Method 1: FMINCON

clc
clear all
close all


% set up initial
x0 = [0.3; 0.1];

% lower and upper bound
lb = [0; 0];
ub = [0.4; 0.4];

% set up options for optimizer
options = optimset('TolCon', 1e-8,...
                   'TolX', 1e-8, ...
                   'Display', 'iter');

% call optimizer               
[x_opt, f_opt, ExitFlag, Output] = fmincon(@objfun, x0, [], [], [], [], lb, ub, @confun, options)

% objective function
function obj = objfun(x0)
r0 = x0(1);
ri = x0(2);
L = 10;
rho = 7850; 
obj = rho.*L.*pi.*(r0.^2-ri.^2);
end

% constrained function
function [g,h] = confun(x0)
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
g(6) = r0 - 0.4 ;
g(7) = ri - r0 
h = [];
end