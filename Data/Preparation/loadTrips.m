dname='../Trips/';
files=dir([dname,'*.csv']);

clear tripdata

for i=20:22
    if ~exist('tripdata','var') == 1
        tripdata=readTripFile([dname,files(i).name]);
    else
        subdata = readTripFile([dname,files(i).name]);
        tripdata = [tripdata;subdata];
    end

end

[ stationdata ] = readStationFile( '../Hubway_Stations_2011_2016.csv' );

%%
nHourBins = 2;

[y,m,d] = ymd(tripdata.starttime);
today = tripdata(y == 2016 & m == 10 & ~isweekend(tripdata.starttime),:);

startInd = floor(nHourBins*hours(timeofday(today.starttime)))+1;
stopInd = floor(nHourBins*hours(timeofday(today.stoptime)))+1;

[ outtable, triparray ] = aggregateTrips( today, stationdata, startInd, stopInd, nHourBins );

%%
ymd = [y,m,d];
startHoursInd = floor(hours(tripdata.starttime-datetime(ymd(1,:))));
endHoursInd = floor(hours(tripdata.starttime-datetime(ymd(1,:))));
mask = (y == 2016 & m == 10 & ~isweekend(tripdata.starttime));

[ outtable, triparray ] = aggregateTrips( today, stationdata, startHoursInd(mask), endHoursInd(mask), nHourBins );


%%
% corrmatrix = corr(triparray');
corrmatrix = pdist(triparray,'correlation');
corrmatrix = squareform(corrmatrix);
tree = linkage(corrmatrix,'average','correlation');
dendrogram(tree)
leafOrder = optimalleaforder(tree,corrmatrix);
imagesc(corrmatrix(leafOrder,leafOrder))