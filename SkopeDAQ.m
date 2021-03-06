% ========================================================================= %
% Title:        SkopeDAQ                                                    %
%                                                                           %
% Author:       Kristian Haverson                                           %
% Email:        kristianhaverson@gmail.com                                  %
% Date:         April 21, 2022                                              %
%                                                                           %
% ------------------------------------------------------------------------- %
% Description: Interfaces MATLAB with tetronix DPO 3034 oscilloscope        %
% ------------------------------------------------------------------------- %
% Notes: Rate of 2Hz                                                        %
% ========================================================================= %

% - Clear  windows & workspaces
clear all
close all


obj = SkopeFuncs_01; % Call functions from class

% (1) ---- interface with Skope  ---- (1)
SKope = obj.SKopeTetDPO();

% (2) ---- Rendering  ---- (2)
xlim1 = [-5*10^-6 4*10^-6];
ylim1 = [19.66 19.78];
Trig= 10; %If you dont want to save files, just set the trigget to 1000000
seed = "_test.csv"; % file 
directory = '/Users/krishaverson/Documents/MATLAB/OscilloscopAnalysis/skopeDaq/SkopeDaq_1/WriteDirecTest/';
obj.SView(SKope,xlim1,ylim1,Trig,directory,seed);




