function RNALines = importRNALines(workbookFile, sheetName, dataLines)
%IMPORTFILE Import data from a spreadsheet
%  RNALINES = IMPORTFILE(FILE) reads data from the first worksheet in
%  the Microsoft Excel spreadsheet file named FILE.  Returns the data as
%  a table.
%
%  RNALINES = IMPORTFILE(FILE, SHEET) reads from the specified worksheet.
%
%  RNALINES = IMPORTFILE(FILE, SHEET, DATALINES) reads from the
%  specified worksheet for the specified row interval(s). Specify
%  DATALINES as a positive scalar integer or a N-by-2 array of positive
%  scalar integers for dis-contiguous row intervals.
%
%  Example:
%  RNALines = importfile("D:\EERL\NY-Simple-Net\NY-Simple-Net-main\Data\Transmission\Figure 22 Firm Transmission Plans included in 2020 RNA Base Case.xlsx", "Table 1", [2, 208]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 01/26/2021 10:24:11

%% Input handling

% If no sheet is specified, read first sheet
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% If row start and end points are not specified, define defaults
if nargin <= 2
    dataLines = [2, 208];
end

%% Setup the Import Options and import the data
opts = spreadsheetImportOptions("NumVariables", 13);

% Specify sheet and range
opts.Sheet = sheetName;
opts.DataRange = "A" + dataLines(1, 1) + ":M" + dataLines(1, 2);

% Specify column names and types
opts.VariableNames = ["TransmissionOwner", "Terminal1", "Terminal2", "LineLengthinMiles", "InService", "InServiceDatePriortoYear", "OperatingNominalVoltagekV", "DesignNominalVoltagekV", "Numberofcircuits", "SummerThermalRatings", "WinterThermalRatings", "ProjectDescriptionConductorSize", "Category"];
opts.VariableTypes = ["categorical", "string", "string", "double", "categorical", "double", "double", "double", "double", "string", "string", "string", "categorical"];

% Specify variable properties
opts = setvaropts(opts, ["SummerThermalRatings", "WinterThermalRatings", "ProjectDescriptionConductorSize"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["TransmissionOwner", "Terminal1", "Terminal2", "InService", "SummerThermalRatings", "WinterThermalRatings", "ProjectDescriptionConductorSize", "Category"], "EmptyFieldRule", "auto");

% Import the data
RNALines = readtable(workbookFile, opts, "UseExcel", false);

for idx = 2:size(dataLines, 1)
    opts.DataRange = "A" + dataLines(idx, 1) + ":M" + dataLines(idx, 2);
    tb = readtable(workbookFile, opts, "UseExcel", false);
    RNALines = [RNALines; tb]; %#ok<AGROW>
end

end