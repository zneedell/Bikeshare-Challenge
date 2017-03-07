function [ output ] = readTripFile( filename )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

output=readtable(filename);
output.tripduration = str2double(output.tripduration);
output.starttime = datetime(output.starttime, 'InputFormat','yyyy-MM-dd HH:mm:ss');
output.stoptime = datetime(output.stoptime, 'InputFormat','yyyy-MM-dd HH:mm:ss');
output.startStationId = categorical(output.startStationId);
output.startStationName = categorical(output.startStationName);
output.startStationLatitude = str2double(output.startStationLatitude);
output.startStationLongitude = str2double(output.startStationLongitude);
% output(:,6:7) = [];
output.endStationId = categorical(output.endStationId);
output.endStationName = categorical(output.endStationName);
output.endStationLatitude = str2double(output.endStationLatitude);
output.endStationLongitude = str2double(output.endStationLongitude);
% output(:,8:9) = [];
output.bikeid = categorical(output.bikeid);
output.usertype = categorical(output.usertype);
output.birthYear = str2double(output.birthYear);
output.gender = categorical(output.gender);

end

