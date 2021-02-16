function npccLine = importNpccLine(workbookFile, sheetName, dataLines)
%IMPORTFILE Import data from a spreadsheet
%  NPCCLINE = IMPORTFILE(FILE) reads data from the first worksheet in
%  the Microsoft Excel spreadsheet file named FILE.  Returns the data as
%  a table.
%
%  NPCCLINE = IMPORTFILE(FILE, SHEET) reads from the specified worksheet.
%
%  NPCCLINE = IMPORTFILE(FILE, SHEET, DATALINES) reads from the
%  specified worksheet for the specified row interval(s). Specify
%  DATALINES as a positive scalar integer or a N-by-2 array of positive
%  scalar integers for dis-contiguous row intervals.
%
%  Example:
%  npccLine = importfile("D:\EERL\NY-Simple-Net\NY-Simple-Net-main\NPCC140\npcc.xlsx", "Line", [2, 234]);
%
%  See also READTABLE.

%% Input handling

% If no sheet is specified, read sheet "Line"
if nargin == 1 || isempty(sheetName)
    sheetName = "Line";
end

% If row start and end points are not specified, define defaults
if nargin <= 2
    dataLines = [2, 234];
end

%% Setup the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 20);

% Specify sheet and range
opts.Sheet = sheetName;
opts.DataRange = "B" + dataLines(1, 1) + ":U" + dataLines(1, 2);

% Specify column names and types
opts.VariableNames = ["idx", "u", "name", "bus1", "bus2", "Sn", "fn", "Vn1", "Vn2", "r", "x", "b", "g", "b1", "g1", "b2", "g2", "trans", "tap", "phi"];
opts.VariableTypes = ["categorical", "categorical", "string", "categorical", "categorical", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify variable properties
opts = setvaropts(opts, "name", "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["idx", "u", "name", "bus1", "bus2"], "EmptyFieldRule", "auto");

% Import the data
npccLine = readtable(workbookFile, opts, "UseExcel", false);

for idx = 2:size(dataLines, 1)
    opts.DataRange = "B" + dataLines(idx, 1) + ":U" + dataLines(idx, 2);
    tb = readtable(workbookFile, opts, "UseExcel", false);
    npccLine = [npccLine; tb]; %#ok<AGROW>
end

end