function [ ODstruct , stationstruct, OD2,odLeafOrder] = createTripStruct( trips, ODstruct, stationstruct, tripArray )
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
% OD = OD./OD_mean;
OD = (full(OD(:)));
OD(isnan(OD)) = 0;

OD2 = reshape(OD,nRows,nRows);
OD2_mean = mean(OD2,1);
OD2 = OD2./OD2_mean;
[ L ] = GetAdjLaplacian( OD2 );
showThisOD = ~(nansum(OD2,1) == 0 | nansum(OD2,2)' == 0);
nonZero = find(showThisOD);
ignore = find(~showThisOD);
[V,D] = eigs(L(nonZero,nonZero), 2, 'sm');
w = V(:,2);
[~,F_Sort] = sort(w);
otherOrder = nonZero(F_Sort);
odLeafOrder = 1:nRows;
odLeafOrder(showThisOD) = otherOrder;
odLeafOrder(~showThisOD) = (length(otherOrder)+1):nRows;
[~,odLeafOrder] = sort(odLeafOrder);

% odLeafOrder = 1:nRows;
% odLeafOrder(nonZero) = F_Sort;
% odLeafOrder(ignore) = (length(nonZero)+1):nRows;
OD3 = OD2(:);
OD3(isnan(OD3)) = 0;

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
    CORR = struct();
    FLOW = struct();
    CORR.Dst_Ord = newLeafOrder(ii);
    CORR.Dst_Show = showThis(ii);
    FLOW.Dst_Ord = odLeafOrder(ii);
    FLOW.Dst_Show = showThisOD(ii);
    stationstruct(ii).StartStop.CORR = CORR;
    stationstruct(ii).StartStop.FLOW = FLOW;
end

corrmatrix = corrmatrix(:);
corrmatrix(isnan(corrmatrix)) = -1;
for ii = 1:length(ODstruct)
    data = struct();
    data.CORR = single(corrmatrix(ii));
    data.FLOW = single(OD3(ii));
    ODstruct(ii).CORR = data;
end

end

