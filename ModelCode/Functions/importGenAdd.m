function genAddition = importGenAdd(workbookFile, sheetName, dataLines)
%IMPORTFILE Import data from a spreadsheet
% Import Table IV-1: Proposed Generator Addition & GRIS Requests
% NYISO 2020 Gold Book

%% Input handling

% If no sheet is specified, read first sheet
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% If row start and end points are not specified, define defaults
if nargin <= 2
    dataLines = [3, 130];
end

%% Setup the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 14);

% Specify sheet and range
opts.Sheet = sheetName;
opts.DataRange = "A" + dataLines(1, 1) + ":N" + dataLines(1, 2);

% Specify column names and types
opts.VariableNames = ["QUEUEPOS", "OWNEROPERATOR", "STATIONUNIT", "ZONE", "ProposedDateMYY", "NAMEPLATERATINGMW", "REQUESTEDCRISMW", "CRISMW", "SUMMERMW", "WINTERMW", "UNITTYPE", "CLASSYEAR", "NOTES", "Category"];
opts.VariableTypes = ["double", "string", "string", "categorical", "string", "double", "double", "double", "double", "double", "categorical", "double", "string", "categorical"];

% Specify variable properties
opts = setvaropts(opts, ["OWNEROPERATOR", "STATIONUNIT", "ProposedDateMYY", "NOTES"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["OWNEROPERATOR", "STATIONUNIT", "ZONE", "ProposedDateMYY", "UNITTYPE", "NOTES", "Category"], "EmptyFieldRule", "auto");

% Import the data
genAddition = readtable(workbookFile, opts, "UseExcel", false);

for idx = 2:size(dataLines, 1)
    opts.DataRange = "A" + dataLines(idx, 1) + ":N" + dataLines(idx, 2);
    tb = readtable(workbookFile, opts, "UseExcel", false);
    genAddition = [genAddition; tb]; %#ok<AGROW>
end

end