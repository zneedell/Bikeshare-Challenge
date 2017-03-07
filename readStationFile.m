function [ output ] = readStationFile( filename )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

output = readtable(filename);
output.Station = categorical(output.Station);
output.StationID = categorical(output.StationID);
output.Municipality = categorical(output.Municipality);

end

