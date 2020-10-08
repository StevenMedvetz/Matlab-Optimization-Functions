% Steven Medvetz
% MAE 530
% 2.23: Penalty Function

clc
clear all
close all

syms Ro Ri r 

% Constants
P = 14000;
L = 10;
rho = 7850;
sigma_max = 165*10^6; 
t_max = 50*10^6; 

% Cost Function
C = 7850.*10.*pi.*(Ro.^2-Ri.^2) 

% Inequality Constraints
g(1) = (14000*10./((pi/4).*(Ro.^4-Ri.^4))).*Ro-165*10^6;
g(2) = (14000./(3.*((pi/4).*(Ro.^4-Ri.^4)))).*(Ro.^2+(Ro.*Ri)+Ri.^2)-50*10^6;
g(3) =  -Ri;
g(4) =  -Ro;
g(5) = Ro - 0.4 ;
g(6) = Ri - Ro + 0.0025;

% Initial Guess In Infeasible Region
ro = 0.5
ri = 1

% Evaluating Constraints At Initial Guess
G(1) = subs(g(1), [Ro, Ri], [ro, ri])
G(2) = subs(g(2), [Ro, Ri], [ro, ri])
G(3) = subs(g(3), [Ro, Ri], [ro, ri])
G(4) = subs(g(4), [Ro, Ri], [ro, ri])
G(5) = subs(g(5), [Ro, Ri], [ro, ri])
G(6) = subs(g(6), [Ro, Ri], [ro, ri])


% Constraint 1
for i = 1:6
    if G(i) <= 0
        g(i) = 0;
        disp('Constraint Not Violated!')
        disp(g(i))
    else 
            g(i) = g(i);
        disp('Constraint Violated!')
        disp(g(i))
    end
end

% Defining PENALTY FUNCTION
phi = C + r.*(g(1).^2 + g(2).^2+ g(3).^2 + g(4).^2 + g(5).^2 + g(6).^2);
s = vpasolve([diff(phi, Ro) == 0, diff(phi, Ri) == 0], [Ro, Ri]);

Ros = limit(s.Ro, r, inf)
Ris = limit(s.Ri, r, inf)

x = double([Ros, Ris])

disp('Outer Radius:')
Ro = round(x(1),1)
disp('Inner Radius:')
Ri = round(x(2),4)

% THE END!!!
