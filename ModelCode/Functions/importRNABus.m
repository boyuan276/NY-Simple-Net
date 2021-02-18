function RNABus = importRNABus(filename, dataLines)
%IMPORTFILE Import data from a text file
%  RNABUS = IMPORTFILE(FILENAME) reads data from text file FILENAME for
%  the default selection.  Returns the data as a table.
%
%  RNABUS = IMPORTFILE(FILE, DATALINES) reads data for the specified row
%  interval(s) of text file FILENAME. Specify DATALINES as a positive
%  scalar integer or a N-by-2 array of positive scalar integers for
%  dis-contiguous row intervals.
%
%  Example:
%  RNABus = importfile("D:\EERL\NY-Simple-Net\NY-Simple-Net-main\Data\2020RNABus.csv", [2, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 01/16/2021 15:53:28

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [2, Inf];
end

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 3, "Encoding", "UTF-8");

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["No", "Name", "Category"];
opts.VariableTypes = ["double", "string", "categorical"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, "Name", "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Name", "Category"], "EmptyFieldRule", "auto");

% Import the data
RNABus = readtable(filename, opts);

end