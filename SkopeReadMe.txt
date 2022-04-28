% ========================================================================= %
% Title:        SkopeReadMe.txt          					                %
%                                                                           %
% Author:       Kristian Haverson                                           %
% Email:        kristianhaverson@gmail.com                                  %
% Date:         April 21, 2022                                              %
%                                                                           %
% ------------------------------------------------------------------------- %
% Description: Instructions on how to interface MATLAB with Tetronix DPO    %
% ========================================================================= %

% ---- what to find ---- %
(1) skope functions                 -> AnalysisFuncs_01.m
(3) walkthrough on how to use them  -> AnalysisWalkthrough.mlx
(2) Functions for the DAQ           -> SkopeFuncs_01.m
(3) Skope DAQ                       -> SkooeDAQ.m


% ---- Installation ---- %
(1) Install Matlab
(2) Install Instrument Control Toolbox
(3) Install Statitistics & machine learning tookbox


% ---- Running ---- %
(1) Be in same directory as "SkopeDAQ"
(2) recall setup 1 on the Oscillpscope
(3) make sure to "clear all" and "close all" before running!
(4) Click the Run button to start
(5) Click the stop button to stop

% ---- interfacing issues ---- %
(1) Open Instrument Control Toolbox
(2) Clear all interface objects & device objects
(3) Follow steps in "Interfacesteps.png"


% ---- Common causes of error --- %
(1) Check using consistenly either row or column vectors. 
(2) If "append error" try removing ' from lines 63 & 64 from "Skopefuncs_01.m"


% ----Issues  ---- %
(1)... currently the code will run until stopped manually, this will be updated on the GitHub
(2)... Reading files when their number of chars change breaks the code...
