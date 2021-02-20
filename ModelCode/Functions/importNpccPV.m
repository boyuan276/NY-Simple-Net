function npccPV = importNpccPV(workbookFile, sheetName, dataLines)
%IMPORTFILE Import data from a spreadsheet
%  NPCCPV = IMPORTFILE(FILE) reads data from the first worksheet in the
%  Microsoft Excel spreadsheet file named FILE.  Returns the data as a
%  table.
%
%  NPCCPV = IMPORTFILE(FILE, SHEET) reads from the specified worksheet.
%
%  NPCCPV = IMPORTFILE(FILE, SHEET, DATALINES) reads from the specified
%  worksheet for the specified row interval(s). Specify DATALINES as a
%  positive scalar integer or a N-by-2 array of positive scalar integers
%  for dis-contiguous row intervals.
%
%  Example:
%  npccPV = importfile("D:\EERL\NY-Simple-Net\NY-Simple-Net-main\NPCC140\npcc.xlsx", "PV", [2, 48]);
%
%  See also READTABLE.

%% Input handling

% If no sheet is specified, read sheet "PV"
if nargin == 1 || isempty(sheetName)
    sheetName = "PV";
end

% If row start and end points are not specified, define defaults
if nargin <= 2
    dataLines = [2, 48];
end

%% Setup the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 18);

% Specify sheet and range
opts.Sheet = sheetName;
opts.DataRange = "B" + dataLines(1, 1) + ":S" + dataLines(1, 2);

% Specify column names and types
opts.VariableNames = ["idx", "u", "name", "Sn", "Vn", "bus", "busr", "p0", "q0", "pmax", "pmin", "qmax", "qmin", "v0", "vmax", "vmin", "ra", "xs"];
opts.SelectedVariableNames = ["idx", "u", "name", "Sn", "Vn", "bus", "p0", "q0", "pmax", "pmin", "qmax", "qmin", "v0", "vmax", "vmin", "ra", "xs"];
opts.VariableTypes = ["categorical", "categorical", "categorical", "double", "double", "categorical", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify variable properties
opts = setvaropts(opts, ["idx", "u", "name", "bus"], "EmptyFieldRule", "auto");

% Import the data
npccPV = readtable(workbookFile, opts, "UseExcel", false);

for idx = 2:size(dataLines, 1)
    opts.DataRange = "B" + dataLines(idx, 1) + ":S" + dataLines(idx, 2);
    tb = readtable(workbookFile, opts, "UseExcel", false);
    npccPV = [npccPV; tb]; %#ok<AGROW>
end

end