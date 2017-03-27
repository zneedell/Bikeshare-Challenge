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
today = tripdata(~isweekend(tripdata.starttime+hours(3)) & tripdata.starttime > datetime(2015,12,21) & tripdata.starttime < datetime(2016,3,21),:);

startInd = floor(nHourBins*hours(timeofday(today.starttime)))+1;
stopInd = floor(nHourBins*hours(timeofday(today.stoptime)))+1;

[ tripArray, stationstruct ] = addArrivalDeparture( today, stationstruct, startInd, stopInd );
[ ODstruct , stationstruct] = createTripStruct( today, ODstruct, stationstruct, tripArray );
[stationstruct.W_WD] = stationstruct.StartStop; stationstruct = orderfields(stationstruct,[1:3,5,4:4]); stationstruct = rmfield(stationstruct,'StartStop');
[ODstruct.W_WD] = ODstruct.CORR; ODstruct = orderfields(ODstruct,[1:2,4,3:3]); ODstruct = rmfield(ODstruct,'CORR');

today = tripdata(isweekend(tripdata.starttime+hours(3)) & tripdata.starttime > datetime(2015,12,21) & tripdata.starttime < datetime(2016,3,21),:);

startInd = floor(nHourBins*hours(timeofday(today.starttime)))+1;
stopInd = floor(nHourBins*hours(timeofday(today.stoptime)))+1;

[ tripArray, stationstruct ] = addArrivalDeparture( today, stationstruct, startInd, stopInd );
[ ODstruct , stationstruct] = createTripStruct( today, ODstruct, stationstruct, tripArray );

[stationstruct.W_WE] = stationstruct.StartStop; stationstruct = orderfields(stationstruct,[1:4,6,5:5]); stationstruct = rmfield(stationstruct,'StartStop');
[ODstruct.W_WE] = ODstruct.CORR; ODstruct = orderfields(ODstruct,[1:3,5,4:4]); ODstruct = rmfield(ODstruct,'CORR');

%% Load Spring
today = tripdata(~isweekend(tripdata.starttime+hours(3))& tripdata.starttime > datetime(2016,3,21) & tripdata.starttime < datetime(2016,6,21),:);

startInd = floor(nHourBins*hours(timeofday(today.starttime)))+1;
stopInd = floor(nHourBins*hours(timeofday(today.stoptime)))+1;

[tripArray, stationstruct ] = addArrivalDeparture( today, stationstruct, startInd, stopInd );
[ ODstruct , stationstruct] = createTripStruct( today, ODstruct, stationstruct, tripArray );
[stationstruct.Sp_WD] = stationstruct.StartStop; stationstruct = orderfields(stationstruct,[1:5,7,6:6]); stationstruct = rmfield(stationstruct,'StartStop');
[ODstruct.Sp_WD] = ODstruct.CORR; ODstruct = orderfields(ODstruct,[1:4,6,5:5]); ODstruct = rmfield(ODstruct,'CORR');


today = tripdata(isweekend(tripdata.starttime+hours(3))& tripdata.starttime > datetime(2016,3,21) & tripdata.starttime < datetime(2016,6,21),:);

startInd = floor(nHourBins*hours(timeofday(today.starttime)))+1;
stopInd = floor(nHourBins*hours(timeofday(today.stoptime)))+1;

[tripArray, stationstruct ] = addArrivalDeparture( today, stationstruct, startInd, stopInd );
[ ODstruct , stationstruct] = createTripStruct( today, ODstruct, stationstruct, tripArray );
[stationstruct.Sp_WE] = stationstruct.StartStop; stationstruct = orderfields(stationstruct,[1:6,8,7:7]); stationstruct = rmfield(stationstruct,'StartStop');
[ODstruct.Sp_WE] = ODstruct.CORR; ODstruct = orderfields(ODstruct,[1:5,7,6:6]); ODstruct = rmfield(ODstruct,'CORR');

%% Load Summer
today = tripdata(~isweekend(tripdata.starttime+hours(3)) & tripdata.starttime > datetime(2016,6,21) & tripdata.starttime < datetime(2016,9,21),:);

startInd = floor(nHourBins*hours(timeofday(today.starttime)))+1;
stopInd = floor(nHourBins*hours(timeofday(today.stoptime)))+1;

[ tripArray, stationstruct ] = addArrivalDeparture( today, stationstruct, startInd, stopInd );
[ ODstruct , stationstruct] = createTripStruct( today, ODstruct, stationstruct, tripArray );
[stationstruct.Su_WD] = stationstruct.StartStop; stationstruct = orderfields(stationstruct,[1:7,9,8:8]); stationstruct = rmfield(stationstruct,'StartStop');
[ODstruct.Su_WD] = ODstruct.CORR; ODstruct = orderfields(ODstruct,[1:6,8,7:7]); ODstruct = rmfield(ODstruct,'CORR');

today = tripdata(isweekend(tripdata.starttime+hours(3)) & tripdata.starttime > datetime(2016,6,21) & tripdata.starttime < datetime(2016,9,21),:);

startInd = floor(nHourBins*hours(timeofday(today.starttime)))+1;
stopInd = floor(nHourBins*hours(timeofday(today.stoptime)))+1;

[ tripArray, stationstruct ] = addArrivalDeparture( today, stationstruct, startInd, stopInd );
[ ODstruct , stationstruct] = createTripStruct( today, ODstruct, stationstruct, tripArray );
[stationstruct.Su_WE] = stationstruct.StartStop; stationstruct = orderfields(stationstruct,[1:8,10,9:9]); stationstruct = rmfield(stationstruct,'StartStop');
[ODstruct.Su_WE] = ODstruct.CORR; ODstruct = orderfields(ODstruct,[1:7,9,8:8]); ODstruct = rmfield(ODstruct,'CORR');
%% Load Fall

today = tripdata(~isweekend(tripdata.starttime+hours(3)) & tripdata.starttime > datetime(2016,9,21) & tripdata.starttime < datetime(2016,12,21),:);

startInd = floor(nHourBins*hours(timeofday(today.starttime)))+1;
stopInd = floor(nHourBins*hours(timeofday(today.stoptime)))+1;

[ tripArray, stationstruct ] = addArrivalDeparture( today, stationstruct, startInd, stopInd );
[ ODstruct , stationstruct] = createTripStruct( today, ODstruct, stationstruct, tripArray );
[stationstruct.F_WD] = stationstruct.StartStop; stationstruct = orderfields(stationstruct,[1:9,11,10:10]); stationstruct = rmfield(stationstruct,'StartStop');
[ODstruct.F_WD] = ODstruct.CORR; ODstruct = orderfields(ODstruct,[1:8,10,9:9]); ODstruct = rmfield(ODstruct,'CORR');

today = tripdata(isweekend(tripdata.starttime+hours(3)) & tripdata.starttime > datetime(2016,9,21) & tripdata.starttime < datetime(2016,12,21),:);

startInd = floor(nHourBins*hours(timeofday(today.starttime)))+1;
stopInd = floor(nHourBins*hours(timeofday(today.stoptime)))+1;

[ tripArray, stationstruct ] = addArrivalDeparture( today, stationstruct, startInd, stopInd );
[ ODstruct , stationstruct] = createTripStruct( today, ODstruct, stationstruct, tripArray );
[stationstruct.F_WE] = stationstruct.StartStop; stationstruct = orderfields(stationstruct,[1:10,12,11:11]); stationstruct = rmfield(stationstruct,'StartStop');
[ODstruct.F_WE] = ODstruct.CORR; ODstruct = orderfields(ODstruct,[1:9,11,10:10]); ODstruct = rmfield(ODstruct,'CORR');
%%

jsontext = jsonencode(stationstruct);
fileID = fopen('../Formatted/stationData2.json','w');
fprintf(fileID,'%s',jsontext);
fclose(fileID);

jsontext = jsonencode(ODstruct);
fileID = fopen('../Formatted/ODdata.json','w');
fprintf(fileID,'%s',jsontext);
fclose(fileID);