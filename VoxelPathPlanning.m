function []=VoxelPathPlanning()
close all;
%% Set up the angular resolution to the configeration space
% following sequence of [theta1, theta2, theta3]
theta_min = [0, -pi/2, -pi/2];
%theta_max = [pi, 0, pi*3/4];
theta_max = [pi, 0, pi/2];
r1 = 90;  %cm
r2 = 250; %cm
motor_time_min = [4, 4, 5];
motor_time_max = [11, 8, 12];
theta_points = 20; % andular resolution

%% Some initial and Collision Check %%
obstacleset = 'Set1_A'; %define the name of which obstacle set to use
obstacleset = strcat(obstacleset, '_', num2str(theta_points), '.mat');

%% Run collision check on the selected obstacles
if ~isfile(obstacleset)
    % Collision check, returns config space 'A' with no collision
    A = collisionCheck(theta_min, theta_max, theta_points, 4, r1, r2, 0);
    save(obstacleset, 'A');
else
    load (obstacleset, 'A');
end

%% Setup the starting location and choose the targeted location
%The starting searching location in configuration space
startXYZ = [1, 10, 10];

% UI setup of target with Some TEST POINTS for target settings
%10x10x10
% [6, 10, 4]
% [1, 1, 6]
%20x20x20
% [10, 20, 8] under block center
% [1, 20, 8]
% [10, 10, 13] under block center (raised)
targetXYZ=SetTarget_Normalized(startXYZ,A,theta_points)% UI input

%% Breath fast search
[distanceBFS,pathPts] = BreathFastSearch(A,targetXYZ,theta_points,startXYZ);
vis3DPath(distanceBFS,pathPts,A); % A plot showing the searched path


%% Arduino part for robot control %%
%% Configure to arduino (Change based on your own robots)
a = arduino('COM3','Mega2560');
m1='A0';
m2='A1';
m3='A2';
m4='A3';
m5='A4';
m1_en = 'D3';
m1_pin = 'D24';
m2_en = 'D4';
m2_pin = 'D26';
m3_en = 'D5';
m3_pin = 'D28';
m4_en = 'D6';
m4_pin = 'D30';
m5_en = 'D7';
m5_pin = 'D32';
configurePin(a,m1_en,'PWM');
configurePin(a,m1_pin,'DigitalOutput');
configurePin(a,m2_en,'PWM');
configurePin(a,m2_pin,'DigitalOutput');
configurePin(a,m3_en,'PWM');
configurePin(a,m3_pin,'DigitalOutput');
configurePin(a,m4_en,'PWM');
configurePin(a,m4_pin,'DigitalOutput');
configurePin(a,m5_en,'PWM');
configurePin(a,m5_pin,'DigitalOutput');

%% perform path planning on robots
direction = zeros(1, 3);
i = 1;
length = 0;
PR=importdata('PR.mat');
% change one link at a time with consistent movement programmed
while ( (pathPts(i, 1) ~= targetXYZ(1) ) || ...
        (pathPts(i, 2) ~= targetXYZ(2) ) || ...
        (pathPts(i, 3) ~= targetXYZ(3) ) )   
    if (direction == 0)
        direction = abs(pathPts(i + 1, 1:3) - pathPts(i, 1:3) );
    end
    % if same direction
    if (direction == abs((pathPts(i + 1, 1:3) - pathPts(i, 1:3) ) ) )
        length = length + 1;
    else
        if (direction == [1, 0, 0])
            disp(length);
            disp('units in theta1 direction');
            adjpostest(a, PR(3,2)-((pathPts(i,1)-1)*(PR(3,2)-PR(3,1))/(theta_points-1)), m5_en, m5_pin, m5, 0, ...
                       max(motor_time_min(1), (motor_time_max(1)/(theta_points-1) ) * (length) ) );
        end
          
        if (direction == [0, 1, 0])
            disp(length);
            disp('units in theta2 direction');
            adjpostest(a, PR(2,1)+((pathPts(i,2)-1)*(PR(2,2)-PR(2,1))/(theta_points-1)), m4_en, m4_pin, m4, 1, ...
                       max(motor_time_min(2), (motor_time_max(2)/(theta_points-1) ) * (length) ) );
        end
            
        if (direction == [0, 0, 1])
            disp(length);
            disp('units in theta3 direction');
            adjpostest(a, PR(1,2)-((pathPts(i,3)-1)*(PR(1,2)-PR(1,1))/(theta_points-1)), m3_en, m3_pin, m3, 0, ...
                       max(motor_time_min(3), (motor_time_max(3)/(theta_points-1) ) * (length) ) );
        end      
        length = 1;
        direction = abs(pathPts(i + 1, 1:3) - pathPts(i, 1:3) );
    end  
    i = i + 1;
end

if (direction == [1, 0, 0])
    disp(length);
    disp('units in theta1 direction');
    adjpostest(a, PR(3,2)-((pathPts(i,1)-1)*(PR(3,2)-PR(3,1))/(theta_points-1)), m5_en, m5_pin, m5, 0, ...
               max(motor_time_min(1), (motor_time_max(1)/(theta_points-1) ) * (length) ) );
end

if (direction == [0, 1, 0])
    disp(length);
    disp('units in theta2 direction');
    adjpostest(a, PR(2,1)+((pathPts(i,2)-1)*(PR(2,2)-PR(2,1))/(theta_points-1)), m4_en, m4_pin, m4, 1, ...
               max(motor_time_min(2), (motor_time_max(2)/(theta_points-1) ) * (length) ) );
end

if (direction == [0, 0, 1])
    disp(length);
    disp('units in theta3 direction');
    adjpostest(a, PR(1,2)-((pathPts(i,3)-1)*(PR(1,2)-PR(1,1))/(theta_points-1)), m3_en, m3_pin, m3, 0, ...
               max(motor_time_min(3), (motor_time_max(3)/(theta_points-1) ) * (length) ) );
end

clear a;
end