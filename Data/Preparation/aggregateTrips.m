function [ outTable, tripArray ] = aggregateTrips( trips, stations, startInd, stopInd, nHourBins )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

nRows = length(unique([startInd;stopInd]));

startMat = zeros(height(stations),nRows);
endMat = zeros(height(stations),nRows);

nTrips = height(trips);

combinedStations = [trips.startStationName;trips.endStationName];
combinedLat = [trips.startStationLatitude;trips.endStationLatitude];
combinedLong = [trips.startStationLongitude;trips.endStationLongitude];

[~,stationNameID,allStationIds] = unique([trips.startStationId;trips.endStationId]);
startStationId = allStationIds(1:nTrips);
endStationId = allStationIds((nTrips+1):end);
% [~,~,endStationId] = unique(trips.endStationId);

[~,timeID,allTimeIds] = unique([startInd;stopInd]);
startTimeId = allTimeIds(1:nTrips);
endTimeId = allTimeIds((nTrips+1):end);

stationName = combinedStations(stationNameID);
Lat = combinedLat(stationNameID);
Long = combinedLong(stationNameID);

min(startStationId)
min(startInd)

% [startStationCrossID, startTimeCrossID] = meshgrid(startStationId,startTimeId);
% startStationCrossID = startStationCrossID(:);
% startTimeCrossID = startTimeCrossID(:);
% tallTableID = startStationCrossID + max(startStationCrossID)*(startTimeCrossID-1);

starts = accumarray([startStationId,startTimeId],trips.birthYear,[height(stations),nRows],@nnz);
ends = accumarray([endStationId,endTimeId],trips.birthYear,[height(stations),nRows],@nnz);

tripArray = [starts, ends];

totalTrips = starts + ends;
tripRatio = (starts - ends)./totalTrips;
tripRatio(isnan(tripRatio)) = 0;

a = array2table(tripRatio);
b = array2table(totalTrips);

outTable = [table(stationName),table(Lat),table(Long),a,b];

end

