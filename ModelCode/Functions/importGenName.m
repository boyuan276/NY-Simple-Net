function genTable = importGenName(filename, dataLines)
%IMPORTFILE Import data from a text file
%  NYISOGENERATORNAME = IMPORTGENNAME(FILENAME) reads data from text file
%  FILENAME for the default selection.  Returns the data as a table.
%
%  NYISOGENERATORNAME = IMPORTGENNAME(FILE, DATALINES) reads data for the
%  specified row interval(s) of text file FILENAME. Specify DATALINES as
%  a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  NYISOGeneratorName = importGenName("D:\EERL\NY-Simple-Net\NY-Simple-Net-main\Data\NYISO_Generator_Name.csv", [2, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 02/17/2021 10:35:05

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
opts.VariableNames = ["GeneratorName", "PTID", "Subzone", "Zone", "Latitude", "Longitude"];
opts.VariableTypes = ["categorical", "categorical", "categorical", "categorical", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["GeneratorName", "PTID", "Subzone", "Zone"], "EmptyFieldRule", "auto");

% Import the data
genTable = readtable(filename, opts);

end