function [ outTable, tripArray,stationstruct ] = createODstruct( trips, stationstruct, startInd, stopInd )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

nRows = length(unique([startInd;stopInd]));
nTrips = height(trips);

stationName = [stationstruct.Name];
[startFound,startStationId] = ismember(trips.startStationName,stationName);
[endFound,endStationId] = ismember(trips.endStationName,stationName);


[~,~,allTimeIds] = unique([startInd;stopInd]);
startTimeId = allTimeIds(1:nTrips);
endTimeId = allTimeIds((nTrips+1):end);

Lat = [stationstruct.Lat];
Lon = [stationstruct.Lon];

min(startStationId)
min(startInd)


starts = accumarray([startStationId(startFound),startTimeId(startFound)],trips.birthYear(startFound),[length(stationstruct),nRows],@nnz);
ends = accumarray([endStationId(endFound),endTimeId(endFound)],trips.birthYear(endFound),[length(stationstruct),nRows],@nnz);

for ii = 1:length(stationName)
    stationstruct(ii).Starts = starts(ii,:);
    stationstruct(ii).Ends = ends(ii,:);
    %stationstruct(ii).totalStarts = sum(starts(ii,:));
    %stationstruct(ii).totalEnds = sum(ends(ii,:));
end

tripArray = [starts, ends];

totalTrips = starts + ends;
tripRatio = (starts - ends)./totalTrips;
tripRatio(isnan(tripRatio)) = 0;

a = array2table(tripRatio);
b = array2table(totalTrips);
outTable = [];
%outTable = [table(stationName),table(Lat),table(Lon),a,b];

end

