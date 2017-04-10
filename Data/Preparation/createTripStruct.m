function [ ODstruct , stationstruct, OD] = createTripStruct( trips, ODstruct, stationstruct, tripArray )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

nRows = length(stationstruct);
nTrips = height(trips);

stationName = [stationstruct.Name];
[startFound,startStationId] = ismember(trips.startStationName,stationName);
[endFound,endStationId] = ismember(trips.endStationName,stationName);

valid = startStationId > 0 & endStationId > 0;

OD = sparse(startStationId(valid),endStationId(valid),1,nRows,nRows);
OD_mean = mean(OD,1);
OD = OD./OD_mean;
OD = OD(:);

Lat = [stationstruct.Lat];
Lon = [stationstruct.Lon];

hourlymean = sqrt(mean(tripArray,1));
corrmatrix = pdist(tripArray,'correlation');
corrmatrix = squareform(corrmatrix);
showThis = ~isnan(corrmatrix(1,:));
nonNAN = find(showThis);
ignore = find(~showThis);
corrmatrix2 = corrmatrix(nonNAN,nonNAN);
tree = linkage(corrmatrix2,'average','correlation');
% dendrogram(tree)
leafOrder = optimalleaforder(tree,corrmatrix2)
newLeafOrder = 1:nRows;
[~,SID] = sort(leafOrder);
newLeafOrder(nonNAN) = SID;
newLeafOrder(ignore) = (length(nonNAN)+1):nRows;
% imagesc(corrmatrix(leafOrder,leafOrder))


for ii = 1:length(stationName)
    stationstruct(ii).StartStop.Dst_Ord = newLeafOrder(ii);
    stationstruct(ii).StartStop.Dst_Show = showThis(ii);
end

corrmatrix = corrmatrix(:);
corrmatrix(isnan(corrmatrix)) = -1;
for ii = 1:length(ODstruct)
    data = struct();
    data.CORR = single(corrmatrix(ii));
    data.FLOW = single(full(OD(ii)));
    ODstruct(ii).CORR = data;
end

end

