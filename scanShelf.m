function [EPC, EPCASCII] = scanShelf()
    % Tells the arduino to scan the shelf

    s = serialport('COM3',115200);      %opens serial port to arduino
    data = readline(s);                 %read opening line
    pause(0.5);                         %just gives the N6E Nano a little time to prepare serial port
    writeline(s,"start");       %tells N6E Nano to start reading

    for i =1:30
        data(i) = readline(s);          %reads data 100 times
    end
    clear s;                            %disconnect and clear serialport connection

    %Manipulating data 

    dataSplit = split(data(2:end)');    %delimits text to seperate values
    dataCell = cellstr(dataSplit);      %turns the strings into cells for manipulation

    for i = 1:size(dataCell,1)
        EPC_all{i} = strjoin(dataSplit(i,4:end),' ');
        EPCASCII_all{i} = strjoin(cellstr(char(hex2dec(dataCell(i,4:end)))));  %convert to ASCII text
    end

    % Finding unique tags by removing duplicates
    EPC = cellstr(unique(string(EPC_all)))
    EPCASCII = cellstr(unique(string(EPCASCII_all)))
	
end