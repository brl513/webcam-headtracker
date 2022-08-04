% pyrunfile("Headtracker.py")

subjectIdentifier = '.txt';

% Connect to the local server
udpr = dsp.UDPReceiver('RemoteIPAddress', '127.0.0.1',...
                       'LocalIPPort',5555); 
                   
% Make a cell array to store head tracking data values
htValues = {};

% Need a way to predetermine the values of cell array size, therefore need
% to relate to sweep length and capture every 1/30 seconds?
% sweepLength = x; % seconds
% frameRate = 1/30; 
% totalFrames = x/frameRate


yaw = 0;
pitch = 0;
roll =0;
xoffset = 0;
depth = 0;
yoffset = 0;
T = table(yaw, pitch, roll, xoffset, depth, yoffset); % name the columns inside yaw / pitch / etc

% Read data from the head tracker
while true   
    py_output = step(udpr);
    
    if ~isempty(py_output)
        data = str2double(split(convertCharsToStrings(char(py_output)), ','));
        yaw = data(1);
        pitch = data(2);
        roll = data(3);
        xoffset = data(4);
        depth = data(5);
        yoffset = data(6);
        T1 = table(yaw, pitch, roll, xoffset, depth, yoffset);
        T = vertcat(T, T1);
        
%         disp([' yaw:', num2str(data(1)),...
%              ' pitch:', num2str(data(2)),...
%              ' roll:', num2str(data(3)),...
%              ' xOffset:', num2str(data(4)),...
%              ' depth:', num2str(data(5)),...
%              ' yoffset:', num2str(data(6))])
    end

end 

    writetable(T,'myData.txt','Delimiter',' ')  
    type 'myData.txt'
% NEed to putput table as text file now.
