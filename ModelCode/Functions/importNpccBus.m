function npccBus = importNpccBus(workbookFile, sheetName, dataLines)
%IMPORTFILE Import data from a spreadsheet
%  NPCCBUS = IMPORTFILE(FILE) reads data from the first worksheet in the
%  Microsoft Excel spreadsheet file named FILE.  Returns the data as a
%  table.
%
%  NPCCBUS = IMPORTFILE(FILE, SHEET) reads from the specified worksheet.
%
%  NPCCBUS = IMPORTFILE(FILE, SHEET, DATALINES) reads from the specified
%  worksheet for the specified row interval(s). Specify DATALINES as a
%  positive scalar integer or a N-by-2 array of positive scalar integers
%  for dis-contiguous row intervals.
%
%  Example:
%  npccBus = importfile("D:\EERL\NY-Simple-Net\NY-Simple-Net-main\NPCC140\npcc.xlsx", "Bus", [2, 141]);
%
%  See also READTABLE.

%% Input handling

% If no sheet is specified, read sheet "Bus"
if nargin == 1 || isempty(sheetName)
    sheetName = "Bus";
end

% If row start and end points are not specified, define defaults
if nargin <= 2
    dataLines = [2, 141];
end

%% Setup the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 13);

% Specify sheet and range
opts.Sheet = sheetName;
opts.DataRange = "B" + dataLines(1, 1) + ":N" + dataLines(1, 2);

% Specify column names and types
opts.VariableNames = ["idx", "u", "name", "Vn", "vmax", "vmin", "v0", "a0", "xcoord", "ycoord", "area", "zone", "owner"];
opts.VariableTypes = ["categorical", "categorical", "string", "double", "double", "double", "double", "double", "double", "double", "categorical", "categorical", "categorical"];

% Specify variable properties
opts = setvaropts(opts, "name", "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["idx", "u", "name", "area", "zone", "owner"], "EmptyFieldRule", "auto");

% Import the data
npccBus = readtable(workbookFile, opts, "UseExcel", false);

for idx = 2:size(dataLines, 1)
    opts.DataRange = "B" + dataLines(idx, 1) + ":N" + dataLines(idx, 2);
    tb = readtable(workbookFile, opts, "UseExcel", false);
    npccBus = [npccBus; tb]; %#ok<AGROW>
end

end