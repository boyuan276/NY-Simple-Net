function zonalPrice = importZonalPrice(filename, dataLines)
%IMPORTFILE Import data from a text file
%  DAMLBMPZONE = IMPORTFILE(FILENAME) reads data from text file FILENAME
%  for the default selection.  Returns the data as a table.
%
%  DAMLBMPZONE = IMPORTFILE(FILE, DATALINES) reads data for the
%  specified row interval(s) of text file FILENAME. Specify DATALINES as
%  a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  zonalPrice = importZonalPrice("D:\EERL\2019_NYISO\2019_DAM_LBMP_Zonal\20190101damlbmp_zone.csv", [2, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 03/11/2021 01:52:46

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [2, Inf];
end

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 6);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["TimeStamp", "ZoneName", "PTID", "LBMP", "MarginalCostLosses", "MarginalCostCongestion"];
opts.VariableTypes = ["datetime", "categorical", "categorical", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["ZoneName", "PTID"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, "TimeStamp", "InputFormat", "MM/dd/yyyy HH:mm");

% Import the data
zonalPrice = readtable(filename, opts);

end