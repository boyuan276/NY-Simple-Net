function npccSlack = importNpccSlack(workbookFile, sheetName, dataLines)
%IMPORTFILE Import data from a spreadsheet
%  NPCCSLACK = IMPORTFILE(FILE) reads data from the first worksheet in
%  the Microsoft Excel spreadsheet file named FILE.  Returns the data as
%  a table.
%
%  NPCCSLACK = IMPORTFILE(FILE, SHEET) reads from the specified
%  worksheet.
%
%  NPCCSLACK = IMPORTFILE(FILE, SHEET, DATALINES) reads from the
%  specified worksheet for the specified row interval(s). Specify
%  DATALINES as a positive scalar integer or a N-by-2 array of positive
%  scalar integers for dis-contiguous row intervals.
%
%  Example:
%  npccSlack = importfile("D:\EERL\NY-Simple-Net\NY-Simple-Net-main\NPCC140\npcc.xlsx", "Slack", [2, 2]);
%
%  See also READTABLE.

%% Input handling

% If no sheet is specified, read sheet "Slack"
if nargin == 1 || isempty(sheetName)
    sheetName = "Slack";
end

% If row start and end points are not specified, define defaults
if nargin <= 2
    dataLines = [2, 2];
end

%% Setup the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 20);

% Specify sheet and range
opts.Sheet = sheetName;
opts.DataRange = "A" + dataLines(1, 1) + ":T" + dataLines(1, 2);

% Specify column names and types
opts.VariableNames = ["Var1", "idx", "u", "name", "Sn", "Vn", "bus", "Var8", "p0", "q0", "pmax", "pmin", "qmax", "qmin", "v0", "vmax", "vmin", "ra", "xs", "a0"];
opts.SelectedVariableNames = ["idx", "u", "name", "Sn", "Vn", "bus", "p0", "q0", "pmax", "pmin", "qmax", "qmin", "v0", "vmax", "vmin", "ra", "xs", "a0"];
opts.VariableTypes = ["char", "categorical", "categorical", "categorical", "double", "double", "categorical", "char", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify variable properties
opts = setvaropts(opts, ["Var1", "Var8"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "idx", "u", "Var8"], "EmptyFieldRule", "auto");

% Import the data
npccSlack = readtable(workbookFile, opts, "UseExcel", false);

for idx = 2:size(dataLines, 1)
    opts.DataRange = "A" + dataLines(idx, 1) + ":T" + dataLines(idx, 2);
    tb = readtable(workbookFile, opts, "UseExcel", false);
    npccSlack = [npccSlack; tb]; %#ok<AGROW>
end

end