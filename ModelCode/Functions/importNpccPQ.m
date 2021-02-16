function npccPQ = importNpccPQ(workbookFile, sheetName, dataLines)
%IMPORTFILE Import data from a spreadsheet
%  NPCCPQ = IMPORTFILE(FILE) reads data from the first worksheet in the
%  Microsoft Excel spreadsheet file named FILE.  Returns the data as a
%  table.
%
%  NPCCPQ = IMPORTFILE(FILE, SHEET) reads from the specified worksheet.
%
%  NPCCPQ = IMPORTFILE(FILE, SHEET, DATALINES) reads from the specified
%  worksheet for the specified row interval(s). Specify DATALINES as a
%  positive scalar integer or a N-by-2 array of positive scalar integers
%  for dis-contiguous row intervals.
%
%  Example:
%  npccPQ = importfile("D:\EERL\NY-Simple-Net\NY-Simple-Net-main\NPCC140\npcc.xlsx", "PQ", [2, 93]);
%
%  See also READTABLE.

%% Input handling

% If no sheet is specified, read sheet "PQ"
if nargin == 1 || isempty(sheetName)
    sheetName = "PQ";
end

% If row start and end points are not specified, define defaults
if nargin <= 2
    dataLines = [2, 93];
end

%% Setup the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 10);

% Specify sheet and range
opts.Sheet = sheetName;
opts.DataRange = "B" + dataLines(1, 1) + ":K" + dataLines(1, 2);

% Specify column names and types
opts.VariableNames = ["idx", "u", "name", "bus", "Vn", "p0", "q0", "vmax", "vmin", "owner"];
opts.VariableTypes = ["categorical", "categorical", "categorical", "categorical", "double", "double", "double", "double", "double", "categorical"];

% Specify variable properties
opts = setvaropts(opts, ["idx", "u", "name", "bus", "owner"], "EmptyFieldRule", "auto");

% Import the data
npccPQ = readtable(workbookFile, opts, "UseExcel", false);

for idx = 2:size(dataLines, 1)
    opts.DataRange = "B" + dataLines(idx, 1) + ":K" + dataLines(idx, 2);
    tb = readtable(workbookFile, opts, "UseExcel", false);
    npccPQ = [npccPQ; tb]; %#ok<AGROW>
end

end