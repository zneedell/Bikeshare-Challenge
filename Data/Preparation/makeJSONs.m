dname='../Trips/';
files=dir([dname,'*.csv']);
nHourBins = 2;

%% Load All Trips

clear tripdata
for i=12:23
    if ~exist('tripdata','var') == 1
        tripdata=readTripFile([dname,files(i).name]);
    else
        subdata = readTripFile([dname,files(i).name]);
        tripdata = [tripdata;subdata];
    end

end


[y,m,d] = ymd(tripdata.starttime);

%% Load and generate station struct

[ stationdata, stationstruct, ODstruct ] = readStationFile( '../Hubway_Stations_2011_2016.csv' );


%% Load Winter
today = tripdata(~isweekend(tripdata.starttime) & tripdata.starttime > datetime(2015,12,1) & tripdata.starttime < datetime(2016,3,1),:);

startInd = floor(nHourBins*hours(timeofday(today.starttime)))+1;
stopInd = floor(nHourBins*hours(timeofday(today.stoptime)))+1;

[ outTable, tripArray, stationstruct ] = addArrivalDeparture( today, stationstruct, startInd, stopInd );
[stationstruct.W_WD] = stationstruct.StartStop; stationstruct = orderfields(stationstruct,[1:3,5,4:4]); stationstruct = rmfield(stationstruct,'StartStop');

today = tripdata(isweekend(tripdata.starttime) & tripdata.starttime > datetime(2015,12,1) & tripdata.starttime < datetime(2016,3,1),:);

startInd = floor(nHourBins*hours(timeofday(today.starttime)))+1;
stopInd = floor(nHourBins*hours(timeofday(today.stoptime)))+1;

[ outTable, tripArray, stationstruct ] = addArrivalDeparture( today, stationstruct, startInd, stopInd );

[stationstruct.W_WE] = stationstruct.StartStop; stationstruct = orderfields(stationstruct,[1:4,6,5:5]); stationstruct = rmfield(stationstruct,'StartStop');
%% Load Spring
today = tripdata(~isweekend(tripdata.starttime)& tripdata.starttime > datetime(2016,3,1) & tripdata.starttime < datetime(2016,6,1),:);

startInd = floor(nHourBins*hours(timeofday(today.starttime)))+1;
stopInd = floor(nHourBins*hours(timeofday(today.stoptime)))+1;

[ outTable, tripArray, stationstruct ] = addArrivalDeparture( today, stationstruct, startInd, stopInd );
[stationstruct.Sp_WD] = stationstruct.StartStop; stationstruct = orderfields(stationstruct,[1:5,7,6:6]); stationstruct = rmfield(stationstruct,'StartStop');

today = tripdata(isweekend(tripdata.starttime)& tripdata.starttime > datetime(2016,3,1) & tripdata.starttime < datetime(2016,6,1),:);

startInd = floor(nHourBins*hours(timeofday(today.starttime)))+1;
stopInd = floor(nHourBins*hours(timeofday(today.stoptime)))+1;

[ outTable, tripArray, stationstruct ] = addArrivalDeparture( today, stationstruct, startInd, stopInd );
[stationstruct.Sp_WE] = stationstruct.StartStop; stationstruct = orderfields(stationstruct,[1:6,8,7:7]); stationstruct = rmfield(stationstruct,'StartStop');
%% Load Summer
today = tripdata(~isweekend(tripdata.starttime) & tripdata.starttime > datetime(2016,6,1) & tripdata.starttime < datetime(2016,9,1),:);

startInd = floor(nHourBins*hours(timeofday(today.starttime)))+1;
stopInd = floor(nHourBins*hours(timeofday(today.stoptime)))+1;

[ outTable, tripArray, stationstruct ] = addArrivalDeparture( today, stationstruct, startInd, stopInd );
[stationstruct.Su_WD] = stationstruct.StartStop; stationstruct = orderfields(stationstruct,[1:7,9,8:8]); stationstruct = rmfield(stationstruct,'StartStop');

today = tripdata(isweekend(tripdata.starttime) & tripdata.starttime > datetime(2016,6,1) & tripdata.starttime < datetime(2016,9,1),:);

startInd = floor(nHourBins*hours(timeofday(today.starttime)))+1;
stopInd = floor(nHourBins*hours(timeofday(today.stoptime)))+1;

[ outTable, tripArray, stationstruct ] = addArrivalDeparture( today, stationstruct, startInd, stopInd );
[stationstruct.Su_WE] = stationstruct.StartStop; stationstruct = orderfields(stationstruct,[1:8,10,9:9]); stationstruct = rmfield(stationstruct,'StartStop');
%% Load Fall

today = tripdata(~isweekend(tripdata.starttime) & tripdata.starttime > datetime(2016,9,1) & tripdata.starttime < datetime(2016,12,1),:);

startInd = floor(nHourBins*hours(timeofday(today.starttime)))+1;
stopInd = floor(nHourBins*hours(timeofday(today.stoptime)))+1;

[ outTable, tripArray, stationstruct ] = addArrivalDeparture( today, stationstruct, startInd, stopInd );
[stationstruct.F_WD] = stationstruct.StartStop; stationstruct = orderfields(stationstruct,[1:9,11,10:10]); stationstruct = rmfield(stationstruct,'StartStop');

today = tripdata(isweekend(tripdata.starttime) & tripdata.starttime > datetime(2016,9,1) & tripdata.starttime < datetime(2016,12,1),:);

startInd = floor(nHourBins*hours(timeofday(today.starttime)))+1;
stopInd = floor(nHourBins*hours(timeofday(today.stoptime)))+1;

[ outTable, tripArray, stationstruct ] = addArrivalDeparture( today, stationstruct, startInd, stopInd );
[stationstruct.F_WE] = stationstruct.StartStop; stationstruct = orderfields(stationstruct,[1:10,12,11:11]); stationstruct = rmfield(stationstruct,'StartStop');
%%

jsontext = jsonencode(stationstruct);
fileID = fopen('../Formatted/stationData2.json','w');
fprintf(fileID,'%s',jsontext);
fclose(fileID);