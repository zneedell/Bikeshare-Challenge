function [ ODstruct , stationstruct] = createTripStruct( trips, ODstruct, stationstruct, tripArray )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

nRows = length(stationstruct);
nTrips = height(trips);

stationName = [stationstruct.Name];
[startFound,startStationId] = ismember(trips.startStationName,stationName);
[endFound,endStationId] = ismember(trips.endStationName,stationName);


Lat = [stationstruct.Lat];
Lon = [stationstruct.Lon];

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
    ODstruct(ii).CORR = corrmatrix(ii);
end

end

