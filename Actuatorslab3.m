%%%%%%%%%%%%%
% ECE 3610
% LAB 10 -- Actuators 3: Combining Sensorimotor Loops
%%%%%%%%%%%%%

%%%%%%%%%%%%%
% Modern cyberphysical systems are simultaneously handling sensor input 
% from a number of sources, then intelligently combining that into a 
% number of actuator signals. So far you have only mapped sensors and 
% actuators in a 1:1 fashion. This lab is purposefully open-ended; 
% hopefully it will give you time to both catch up if you're behind and 
% explore if you're ahead. 

% Deliverables:
%   - A circuit and associated code which uses no fewer than six of your 
%   components and contains (not counting the Arduino, motor carrier,  or 
%   a resistor that is part of a voltage divider used to read values) 
%   at least two different feedback/sensorimotor loops operating at the 
%   same time. At least one of the sensorimotor loops should fuse sensor 
%   data from at least two different sources.
%   - Tell me a story about what your device is meant to do. This can be
%   just part of a larger (imaginary) system, you can use analogies 
%   ("instead of an led, this would be a ____ "). Get creative!
%
% Extensions:
%   - Work with a partner to have your systems interact.
%%%%%%%%%%%%%%

%% 1. CONNECT TO YOUR NANOBOT
%  Remember to replace the first input argument with text corresponding to
%  the correct serial port you found through the Arduino IDE. Note that the
%  clc and clear all will clear your command window and all saved
%  variables!

clc
clear all

% for PC:
nb = nanobot('COMX', 115200, 'serial');
% for Mac:
%nb = nanobot('/dev/cu.usbmodem14301', 115200, 'serial');

%% 2. Building your sensorimotor loops
% Take stock of your available input and output devices. Write down a list
% of each. Categorize each input as either BINARY or CONTINUOUS. Next to
% each input in your list, if it is a sensor, write down the associated
% physical quantity being transduced.

% HINT: When working with design challenges, it can help to clearly define
% your objectives, list usable components, and brainstorm possible next
% steps. Once you have a decent idea pinned down, start by breaking your
% design task into sections.

% E.g. something for this lab could look like:
%
% Objective: 6 components, 2 interacting sensorimotor loops
%
% Components: DC Motor, LED, potentometer, photoresistor, etc.
%
% Possible concepts: System for robot that changes LED with ultrasonic,
% motor speed dependent on another sensor, etc.
%
% CODE STRUCUTRE:
% 1. pin assignments and initialization
% first Input devices are Flex Sensor to control the color we are in 
% seceond input devices are going to be
% 
% First For flex sensor  
nb.pinMode('A1', 'ainput'); 
nb.pinMode('A2', 'ainput'); % For potentiometer
nb.initRGB('D12','D11','D10'); % Initialize the RGB

mean_voltage = (meanval / 1024) * maxSystemVoltage; % Convert ADC reading to voltage



% Since the measured value fluctuates a bit, let's average 10 samples of 
% the input to get the average analog value recorded:
numreads = 10;
vals = zeros(1,numreads);
for i = 1:numreads
    vals(i) = nb.analogRead('A1');
end
meanval = mean(vals);
fprintf('mean ADC reading = %.0f\n', meanval);

% To convert this to a voltage, we can use the equation:
% 
% analog_voltage_measured / max_system_voltage 
%                               = ADC_reading / total_number_of_ADC_values 
%

maxSystemVoltage = 5; % Assuming a 5V system
fprintf('mean voltage = %.1f\n', mean_voltage);

% 2. defining useful variables and ranges

mean_voltage = (meanval / 1024) * maxSystemVoltage; % Convert ADC reading to voltage

% 3. start of while loop

while true 
    


% 4.   data collection/processing


%Initialize the reflectance sensor array with default pins D8, D12, D11, 
% D10, A0, A1


% 6.   sensorimotor/feedback loops
nb.pinMode('A1', 'ainput');
while(true)
    tic
    numreads = 10;
    vals = zeros(1,numreads);
    for i = 1:numreads
        vals(i) = nb.analogRead('A1');
    end
    meanval = mean(vals);
    mean_voltage = '?';  %copy the same equation from the last section
    fprintf('mean voltage = %f V\n', mean_voltage);
    while(toc < '?') % What period in seconds corresponds 2 Hz? 
        pause(0.01); % Do nothing in small increments until time to re-print
    end
end


% X. End of while loop/ resetting functions

% You've been setting up sensorimotor loops almost every lab so far, so go
% crazy with finding ways to combine multiple sensors and actuators/transducers!



%% X. EXTENSION (optional)
% - Work with a partner to have your systems interact.


%% X. DISCONNECT
%  Clears the workspace and command window, then
%  disconnects from the nanobot, freeing up the serial port.

clc
delete(nb);
clear('nb');
clear all