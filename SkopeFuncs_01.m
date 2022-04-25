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

        end

        function [X,Y] =SView(obj,SKope,xlim,ylim,Trig,directory,seed)
            i=1;
            tic

            while a    % constant loop
                [Y,X] = invoke(SKope, 'readwaveform', 'Channel1');

                Y=-Y;
                X=-X;

                plot(X,  Y);

                xlim=xlim;
                ylim=ylim;

                if(Y>Trig)
                    t=toc
                    name = append(i," _",t,"_",seed);
                    i=1+1
                    newdata = [X,Y]
                    dlmwrite(name,newdata)

                end

                grid on
                pause(0.0002);

            end

         
        end






    end
end
