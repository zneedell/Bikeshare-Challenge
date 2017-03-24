function [ output, stationstruct ] = readStationFile( filename )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

output = readtable(filename);
output.Station = categorical(output.Station);
output.StationID = categorical(output.StationID);
output.Municipality = categorical(output.Municipality);

stationstruct = struct();
stationstruct.Name = output.Station(1);
stationstruct.Lat = output.Latitude(1);
stationstruct.Lon = output.Longitude(1);

for ii = 2:height(output)
    sub = struct();
    sub.Name = output.Station(ii);
    sub.Lat = output.Latitude(ii);
    sub.Lon = output.Longitude(ii);
    stationstruct = [stationstruct;sub];
end
end

