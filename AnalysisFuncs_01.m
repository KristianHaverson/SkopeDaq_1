% ======================================================================= %
% Title:        AnalysisFuncs_01.m                                        %
%                                                                         %
% Author:       Kristian Haverson                                         %
% Email:        kristianhaverson@gmail.com                                %
% Date:         April 21, 2022                                            %
%                                                                         %
% ----------------------------------------------------------------------- %
% Description: Functions for reading and analysing csv files              %
% ----------------------------------------------------------------------- %
% Functions:   SPlot(Time, Voltage, Title, XAxis, YAxis)                  %
%              SInit(FilePrefix_extension, directory)                     %
%              SFetch(csv, FileNum, cent, flip)                           %
%              SHist(obj,csv, data, fit,Title,XAxis)                      %
% ======================================================================= %

classdef AnalysisFuncs_01
    properties
    end
    methods

% ***** SPlot: Simple plot function ************************************* %

function  SPlot(obj,Time,Voltage,Title,XAxis,YAxis)
    plot(Time,Voltage)
    grid on;
    box on;
    title({Title},'interpreter','latex','FontSize',11);
    xlabel({XAxis},'interpreter','latex','FontSize',11);
    ylabel({YAxis},'interpreter','latex','FontSize',11);
end


% ***** SInit: Initialise the csv files ********************************* %


function csv = SInit(obj, FilePrefix_extension, directory)          % pass in the file prefix & directory
    location = dir([directory FilePrefix_extension]);
    for i=1:length(location)
        csv(i,:)=append(location(i).folder,'\',location(i).name);   % Store each filename in an object
    end
end


% ***** SFetch: obtians the data from the csv passed ******************** %

function [time,voltage] = SFetch(obj,csv, FileNum,cent,flip)
    % 1(The object containing all file names)
    % 2(The filenumber you want)
    % 3(if cent==1 ,it centers the signal around 0)
    % 4(if flip==1 ,it inverts both X and Y)

    global headersize;                                               % Must define global headersize in macro!
    Filename = [ num2str(csv(FileNum,:))];                           % Pulls a "filename" from csv obj & stores into Filename
    variable1 = readtable(Filename,...                               % Stores data from Filename
        'ReadVariableNames', false,...
        'HeaderLines', headersize);

    time = variable1.Var1;                                           % Column1 is Time
    voltage = variable1.Var2;                                        % Column2 is Voltage

    if(cent==1)
        baseline=0;
        for i =1:100
            baseline = baseline + voltage(i);
        end
        baseline=baseline/100;
        for i=1:length(time)
            voltage(i) = voltage(i)-baseline;
        end
    end
    if(flip==1)
        voltage=-voltage;
        time=-time;
    end
end

% ***** SHist: integrates & fits **************************************** %

function SHist(obj,csv, data, fit,Title,XAxis,cent,flip,bins)

    hist(length(data))=0;                                           % Allocates space

    for i=1:length(data)
        FileNum = data(i);
        [Time,Voltage]=SFetch(obj,csv,FileNum,cent,flip);                % Fetch csv
        hist(i)=trapz(Time,Voltage);                                % Create Hist
    end

    if fit ~= 0                                                     % Fit hist

        histfit(hist,bins);
        xlabel(XAxis);
        title(Title);
    else
        histogram(hist,bins);
        xlabel(XAxis);
        title(Title);
    end
  
% *********************************************************************** %
        
          %function



% *********************************************************************** %
end
    end

end
   