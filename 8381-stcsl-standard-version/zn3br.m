function [qp]=zn3br(input)
% [qp] = zn3br(input)
% Ziegler-Nichols PID controller for processes of 3rd order.
% This function computes parameters of the controller (q0, q1, q2, p1, p2).
% Controller is based on backward rectangular method of discretization.
% Transfer function of the controller is as follows:
%
%            q0 + q1*z^-1 + q2*z^-2     q0 + q1*z^-1 + q2*z^-2
% G(z^-1) = ------------------------ = ------------------------
%                  1 - z^-1              1 + p1*z^-1 + p2*z^-2
%
% where p1=-1 and p2=0.
%
% Transfer function of the controlled system is:
%
%               b1*z^-1 + b2*z^-2 + b3*z^-3
% Gs(z^-1) = ---------------------------------
%             1 + a1*z^-1 + a2*z^-2 + a3*z^-3
%
% Input: input ... input parameters
%                  input(1) ... a1
%                  input(2) ... b1
%                  input(3) ... a2
%                  input(4) ... b2
%                  input(5) ... a3
%                  input(6) ... b3
%                  input(7) ... sample time T0
% Output: qp ... controller parameters   
%                qp(1) ... q0
%                qp(2) ... q1
%                qp(3) ... q2
%                qp(4) ... -1   (p1 of the controller)
%                qp(5) ... 0    (p2 of the controller)

a1 = input(1);
b1 = input(2);
a2 = input(3);
b2 = input(4);
a3 = input(5);
b3 = input(6);
T0 = input(7);

% compute ultimate gain and frequency
[Kpu, Tu] =  ultim([b1 b2 b3],[a1 a2 a3],T0);

Kp = 0.6*Kpu;
Ti = Tu/2;
Td = Tu/8;

q0 = Kp*(1+T0/Ti+Td/T0);
q1 = -Kp*(1+2*Td/T0);
q2 = Kp*(Td/T0);
p1 = -1;
p2 = 0;

qp=[q0; q1; q2; p1; p2];