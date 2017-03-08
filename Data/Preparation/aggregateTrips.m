function [ outTable, tripArray ] = aggregateTrips( trips, stations, startInd, stopInd, nHourBins )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

startMat = zeros(height(stations),nHourBins*24);
endMat = zeros(height(stations),nHourBins*24);

nTrips = height(trips);

combinedStations = [trips.startStationName;trips.endStationName];
combinedLat = [trips.startStationLatitude;trips.endStationLatitude];
combinedLong = [trips.startStationLongitude;trips.endStationLongitude];

[~,stationNameID,allStationIds] = unique([trips.startStationId;trips.endStationId]);
startStationId = allStationIds(1:nTrips);
endStationId = allStationIds((nTrips+1):end);
% [~,~,endStationId] = unique(trips.endStationId);

stationName = combinedStations(stationNameID);
Lat = combinedLat(stationNameID);
Long = combinedLong(stationNameID);

starts = accumarray([startStationId,startInd],trips.birthYear,[height(stations),nHourBins*24],@nnz);
ends = accumarray([endStationId,stopInd],trips.birthYear,[height(stations),nHourBins*24],@nnz);

tripArray = [starts, ends];

totalTrips = starts + ends;
tripRatio = (starts - ends)./totalTrips;
tripRatio(isnan(tripRatio)) = 0;

a = array2table(tripRatio);
b = array2table(totalTrips);

outTable = [table(stationName),table(Lat),table(Long),a,b];

end

