%% 1. Explore and extract data from one year of OOI mooring data

filename = 'deployment0001_GP03FLMB.nc';
%1a. Use the function "ncdisp" to display information about the data contained in this file
ncdisp(filename)

%1b. Use the function "ncreadatt" to extract the latitude and longitude attributes of this dataset
%ncreadatt (filename)
lat = ncreadatt(filename,'/','lat');
lon = ncreadatt(filename,'/','lon');

%1c. Use the function "ncread" to extract the variables "time" and
%"ctdmo_seawater_temperature"
time = ncread(filename,'time');
SST = ncread(filename,'ctdmo_seawater_temperature');

% ncid= netcdf.open(filename, 'NC_NOWRITE');
% [numdims, numvars, numglobalatts,unlimdimID]= netcdf.inq(ncid);
% tt= netcdf.getVar(ncid, netcdf.inqVarID(ncid, 'time'));
% SL= netcdf.getVar(ncid, netcdf.inqVarID(ncid, 'zostoga'));

% Extension option: Also extract the variable "pressure" (which, due to the
% increasing pressure underwater, tells us about depth - 1 dbar ~ 1 m
% depth). How deep in the water column was this sensor deployed?
pressure = ncread(filename,'pressure');

%% 2. Converting the timestamp from the raw data to a format you can use
% Use the datenum function to convert the "time" variable you extracted
% into a MATLAB numerical timestamp (Hint: you will need to check the units
% of time from the netCDF file.)
tt=datenum(1900,1,1,0,0,time);

% Checking your work: Use the "datestr" function to check that your
% converted times match the time range listed in the netCDF file's
% attributes for time coverage
datestr(tt(1:5))

% 2b. Calculate the time resolution of the data (i.e. long from one
% measurement to the next) in minutes. Hint: the "diff" function will be
% helpful here.
diff (tt)

%% 3. Make an initial exploration plot to investigate your data
% Make a plot of temperature vs. time, being sure to show each individual
% data point. What do you notice about the seasonal cycle? What about how
% the variability in the data changes over the year?
% Hint: Use the function "datetick" to make the time show up as
% human-readable dates rather than the MATLAB timestamp numbers

plot(tt, SST)
hold on
datetick(tt)


%% 4. Dealing with data variability: smoothing and choosing a variability cutoff
% 4a. Use the movmean function to calculate a 1-day (24 hour) moving mean
% to smooth the data. Hint: you will need to use the time period between
% measurements that you calculated in 2b to determine the correct window
% size to use in the calculation.

% -->

% 4b. Use the movstd function to calculate the 1-day moving standard
% deviation of the data.

%% 5. Honing your initial investigation plot
% Building on the initial plot you made in #3 above, now add:
%5a. A plot of the 1-day moving mean on the same plot as the original raw data

%5b. A plot of the 1-day moving standard deviation, on a separate plot
%underneath, but with the same x-axis (hint: you can put two plots in the
%same figure by using "subplot" and you can specify

%% 6. Identifying data to exclude from analysis
% Based on the plot above, you can see that there are time periods when the
% data are highly variable - these are time periods when the raw data won't
% be suitable for use to use in studying the Blob.

%6a. Based on your inspection of the data, select a cutoff value for the
%1-day moving standard deviation beyond which you will exclude the data
%from your analysis. Note that you will need to justify this choice in the
%methods section of your writeup for this lab.

%6b. Find the indices of the data points that you are not excluding based
%on the cutoff chosen in 6a.

%6c. Update your figure from #5 to add the non-excluded data as a separate
%plotted set of points (i.e. in a new color) along with the other data you
%had already plotted.

%% 7. Apply the approach from steps 1-6 above to extract data from all OOI deployments in years 1-6
% You could do this by writing a for-loop or a function to adapt the code
% you wrote above to something you can apply across all 5 netCDF files
% (note that deployment 002 is missing)
