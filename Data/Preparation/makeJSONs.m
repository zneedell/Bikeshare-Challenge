dname='../Trips/';
files=dir([dname,'*.csv']);
nHourBins = 2;

%% Load and generate station struct

[ stationdata, stationstruct, ODstruct ] = readStationFile( '../Hubway_Stations_2011_2016.csv' );

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

%% Load Winter
today = tripdata(~isweekend(tripdata.starttime),:);

startInd = floor(nHourBins*hours(timeofday(today.starttime)))+1;
stopInd = floor(nHourBins*hours(timeofday(today.stoptime)))+1;

[ outTable, tripArray, stationstruct ] = addArrivalDeparture( today, stationstruct, startInd, stopInd );
[stationstruct.WinterStarts] = stationstruct.Starts; stationstruct = orderfields(stationstruct,[1:3,6,4:5]); stationstruct = rmfield(stationstruct,'Starts');
[stationstruct.WinterEnds] = stationstruct.Ends; stationstruct = orderfields(stationstruct,[1:4,6,5:5]); stationstruct = rmfield(stationstruct,'Ends');
%% Load Spring

clear tripdata
for i=15:17
    if ~exist('tripdata','var') == 1
        tripdata=readTripFile([dname,files(i).name]);
    else
        subdata = readTripFile([dname,files(i).name]);
        tripdata = [tripdata;subdata];
    end

end


[y,m,d] = ymd(tripdata.starttime);
today = tripdata(~isweekend(tripdata.starttime),:);

startInd = floor(nHourBins*hours(timeofday(today.starttime)))+1;
stopInd = floor(nHourBins*hours(timeofday(today.stoptime)))+1;

[ outTable, tripArray, stationstruct ] = addArrivalDeparture( today, stationstruct, startInd, stopInd );
[stationstruct.SpringStarts] = stationstruct.Starts; stationstruct = orderfields(stationstruct,[1:5,8,6:7]); stationstruct = rmfield(stationstruct,'Starts');
[stationstruct.SpringEnds] = stationstruct.Ends; stationstruct = orderfields(stationstruct,[1:6,8,7:7]); stationstruct = rmfield(stationstruct,'Ends');

%% Load Summer

clear tripdata
for i=18:20
    if ~exist('tripdata','var') == 1
        tripdata=readTripFile([dname,files(i).name]);
    else
        subdata = readTripFile([dname,files(i).name]);
        tripdata = [tripdata;subdata];
    end

end


[y,m,d] = ymd(tripdata.starttime);
today = tripdata(~isweekend(tripdata.starttime),:);

startInd = floor(nHourBins*hours(timeofday(today.starttime)))+1;
stopInd = floor(nHourBins*hours(timeofday(today.stoptime)))+1;

[ outTable, tripArray, stationstruct ] = addArrivalDeparture( today, stationstruct, startInd, stopInd );
[stationstruct.SummerStarts] = stationstruct.Starts; stationstruct = orderfields(stationstruct,[1:7,10,8:9]); stationstruct = rmfield(stationstruct,'Starts');
[stationstruct.SummerEnds] = stationstruct.Ends; stationstruct = orderfields(stationstruct,[1:8,10,9:9]); stationstruct = rmfield(stationstruct,'Ends');

%% Load Fall

clear tripdata
for i=21:23
    if ~exist('tripdata','var') == 1
        tripdata=readTripFile([dname,files(i).name]);
    else
        subdata = readTripFile([dname,files(i).name]);
        tripdata = [tripdata;subdata];
    end

end


[y,m,d] = ymd(tripdata.starttime);
today = tripdata(~isweekend(tripdata.starttime),:);

startInd = floor(nHourBins*hours(timeofday(today.starttime)))+1;
stopInd = floor(nHourBins*hours(timeofday(today.stoptime)))+1;

[ outTable, tripArray, stationstruct ] = addArrivalDeparture( today, stationstruct, startInd, stopInd );
[stationstruct.FallStarts] = stationstruct.Starts; stationstruct = orderfields(stationstruct,[1:9,12,10:11]); stationstruct = rmfield(stationstruct,'Starts');
[stationstruct.FallEnds] = stationstruct.Ends; stationstruct = orderfields(stationstruct,[1:10,12,11:11]); stationstruct = rmfield(stationstruct,'Ends');

%%

jsontext = jsonencode(stationstruct);
fileID = fopen('../Formatted/stationData.json','w');
fprintf(fileID,'%s',jsontext);
fclose(fileID);