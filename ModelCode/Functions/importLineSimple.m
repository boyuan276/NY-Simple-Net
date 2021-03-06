function line2NYCABus = importLineSimple(filename, dataLines)
%IMPORTFILE Import data from a text file
%  LINE2NYCABUS = IMPORTFILE(FILENAME) reads data from text file
%  FILENAME for the default selection.  Returns the data as a table.
%
%  LINE2NYCABUS = IMPORTFILE(FILE, DATALINES) reads data for the
%  specified row interval(s) of text file FILENAME. Specify DATALINES as
%  a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  line2NYCABus = importLineSimple("D:\EERL\NY-Simple-Net\NY-Simple-Net-main\Data\NPCC140\line_with_ny_bus.csv", [2, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 02/23/2021 11:58:02

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [2, Inf];
end

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 31);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["idx", "Var2", "Var3", "bus1_idx", "bus2_idx", "Var6", "Var7", "Var8", "Var9", "r", "x", "b", "Var13", "Var14", "Var15", "Var16", "Var17", "trans", "tap", "phi", "bus1_name", "bus1_area", "Var23", "Var24", "Var25", "bus2_name", "bus2_area", "Var28", "Var29", "Var30", "Var31"];
opts.SelectedVariableNames = ["idx", "bus1_idx", "bus2_idx", "r", "x", "b", "trans", "tap", "phi", "bus1_name", "bus1_area", "bus2_name", "bus2_area"];
opts.VariableTypes = ["categorical", "string", "string", "categorical", "categorical", "string", "string", "string", "string", "double", "double", "double", "string", "string", "string", "string", "string", "double", "double", "double", "categorical", "categorical", "string", "string", "string", "categorical", "categorical", "string", "string", "string", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var2", "Var3", "Var6", "Var7", "Var8", "Var9", "Var13", "Var14", "Var15", "Var16", "Var17", "Var23", "Var24", "Var25", "Var28", "Var29", "Var30", "Var31"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["idx", "Var2", "Var3", "bus1_idx", "bus2_idx", "Var6", "Var7", "Var8", "Var9", "Var13", "Var14", "Var15", "Var16", "Var17", "bus1_name", "bus1_area", "Var23", "Var24", "Var25", "bus2_name", "bus2_area", "Var28", "Var29", "Var30", "Var31"], "EmptyFieldRule", "auto");

% Import the data
line2NYCABus = readtable(filename, opts);

end