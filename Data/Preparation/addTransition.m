function [ stationstruct ] = addTransition( trips,stationstruct )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

nRows = length(stationstruct);

stationName = [stationstruct.Name];
[startFound,startStationId] = ismember(trips.startStationName,stationName);
[endFound,endStationId] = ismember(trips.endStationName,stationName);

valid = startStationId > 0 & endStationId > 0;

OD = full(sparse(startStationId(valid),endStationId(valid),1,nRows,nRows));

for ii = 1:nRows
    Destinations = OD(ii,:);
    Destinations = Destinations/sum(Destinations);
    Destinations(isnan(Destinations)) = 0;
    Trans = struct();
    Trans.Dest = Destinations;
    stationstruct(ii).Trans = Trans;
end

end

