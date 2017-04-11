function [ L ] = GetAdjLaplacian( OD )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

v = nansum(OD,2);
A = OD > 0;
D = diag(v);
L = D - A;

end

