function [ output, stationstruct,ODstruct ] = readStationFile( filename )
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

[Omat,Dmat] = meshgrid(1:height(output));
Olist = output.Station(Omat(:));
Dlist = output.Station(Dmat(:));

ODtable = table();
ODtable.OorigOrder = Omat(:);
ODtable.DorigOrder = Dmat(:);
ODstruct = table2struct(ODtable);

% ODstruct = struct();
% ODstruct.OName = output.Station(1);
% ODstruct.DName = output.Station(1);
% for ii = 2:height(output)
%     sub = struct();
%     sub.OName = output.Station(1);
%     sub.DName = output.Station(ii);
%     ODstruct = [ODstruct;sub];
% end
% for jj = 2:height(output)
%     for ii = 1:height(output)
%         sub = struct();
%         sub.OName = output.Station(jj);
%         sub.DName = output.Station(ii);
%         ODstruct = [ODstruct;sub];
%     end
% end


end

