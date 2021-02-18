function retiredPeakers = importGenRetire(workbookFile, sheetName, dataLines)
%IMPORTFILE Import data from a spreadsheet
% Import Table IV-6: Proposed Generator Stutus Changes to Comply with DEC Peaker Rule
% NYISO 2020 Gold Book

%% Input handling

% If no sheet is specified, read first sheet
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% If row start and end points are not specified, define defaults
if nargin <= 2
    dataLines = [3, 76];
end

%% Setup the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 10);

% Specify sheet and range
opts.Sheet = sheetName;
opts.DataRange = "A" + dataLines(1, 1) + ":J" + dataLines(1, 2);

% Specify column names and types
opts.VariableNames = ["OWNEROPERATOR", "STATIONUNIT", "ZONE", "DATE", "PTID", "SUMMERCRISMW", "WINTERCRISMW", "SUMMERCAPABILITYMW", "WINTERCAPABILITYMW", "Notes"];
opts.VariableTypes = ["categorical", "string", "categorical", "datetime", "categorical", "double", "double", "double", "double", "categorical"];

% Specify variable properties
opts = setvaropts(opts, "STATIONUNIT", "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["OWNEROPERATOR", "STATIONUNIT", "ZONE", "PTID", "Notes"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, "DATE", "InputFormat", "");

% Import the data
retiredPeakers = readtable(workbookFile, opts, "UseExcel", false);

for idx = 2:size(dataLines, 1)
    opts.DataRange = "A" + dataLines(idx, 1) + ":J" + dataLines(idx, 2);
    tb = readtable(workbookFile, opts, "UseExcel", false);
    retiredPeakers = [retiredPeakers; tb]; %#ok<AGROW>
end

end