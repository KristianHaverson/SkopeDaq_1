% ========================================================================= %
% Title:        SKopeFuncs_01.m          					                %
%                                                                           %
% Author:       Kristian Haverson                                           %
% Email:        kristianhaverson@gmail.com                                  %
% Date:         April 21, 2022                                              %
%                                                                           %
% ------------------------------------------------------------------------- %
% Description: Funcs for SKope..                                            %
% ------------------------------------------------------------------------- %
% Functions:   SKopeTetDPO()                                                %
%              SView(SKope,xlim,ylim,Trig,directory,seed)                   %
% ========================================================================= %

%delete([deviceObj interfaceObj]);
%clear groupObj;
%clear deviceObj;
%clear interfaceObj;




classdef SkopeFuncs_01
    properties
    end
    methods

        function  SKope= SKopeTetDPO(obj)
            if (exist("deviceObj")==1)
                clear groupObj;
                clear deviceObj;
            end

            % - Create a VISA-USB object.
            interfaceObj = instrfind('Type', 'visa-usb', 'RsrcName', 'USB0::0x0699::0x0413::C013417::0::INSTR', 'Tag', '');
            if isempty(interfaceObj) %Create the VISA-USB object if it does not exist
                interfaceObj = visa('NI', 'USB0::0x0699::0x0413::C013417::0::INSTR');
            else % otherwise use the object that was found.
                fclose(interfaceObj);
                interfaceObj = interfaceObj(1);
            end

            % - Create a device object.
            deviceObj = icdevice('tektronix_tds210.mdd', interfaceObj);

            % - Connect device object to hardware.
            set(interfaceObj, 'InputBufferSize', 3000000);
            connect(deviceObj);
            SKope = get(deviceObj, 'Waveform');
            disp("Connected")
        end




        function SView(obj,SKope,xlim1,ylim1,Trig,directory,seed)
            i=100; % Need start naming files from 100

            a=1;
            while a    % constant loop
                [Y,X] = invoke(SKope, 'readwaveform', 'Channel1');

                Y=-Y'; % take inverse and transpose
                X=-X';

                %  -- Create plots -- %
                figure(1)
                plot(X,  Y);
                grid on
                
                % -- If pulse is over a threshold, save file -- %
                if(Y>Trig)
                    name = append(i,"_",seed); % create file name
                    i=i+1;
                    newdata = [X,Y]; % Bundle data
                    dlmwrite(name,newdata); % WRite it to a file

                end
                pause(0.0002); % Need this pause for system to register changes 
            end
        end






    end
end
