% pyrunfile("Headtracker.py")

% Connect to the local server
udpr = dsp.UDPReceiver('RemoteIPAddress', '127.0.0.1',...
                       'LocalIPPort',5555); 

% Read data from the head tracker
while true   
    py_output = step(udpr);
    if ~isempty(py_output)
        data = str2double(split(convertCharsToStrings(char(py_output)), ','));
        disp([' yaw:', num2str(data(1)),...
             ' pitch:', num2str(data(2)),...
             ' roll:', num2str(data(3)),...
             'xOffset:', num2str(data(4)),...
             'depth:', num2str(data(5)),...
             'yoffset:', num2str(data(6))])
    end
end 
