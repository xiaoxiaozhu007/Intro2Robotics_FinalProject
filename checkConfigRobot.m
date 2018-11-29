a = arduino('COM3','Mega2560');

m3='A2';
m4='A3';
m5='A4';

m3_en = 'D5';
m3_pin = 'D28';
m4_en = 'D6';
m4_pin = 'D30';
m5_en = 'D7';
m5_pin = 'D32';

configurePin(a,m3_en,'PWM');
configurePin(a,m3_pin,'DigitalOutput');
configurePin(a,m4_en,'PWM');
configurePin(a,m4_pin,'DigitalOutput');
configurePin(a,m5_en,'PWM');
configurePin(a,m5_pin,'DigitalOutput');

PR=importdata('PR.mat');

pathPts = [1, 10, 10];
theta_points = 20;

adjpostest(a, PR(3,2)-((pathPts(1)-1)*(PR(3,2)-PR(3,1))/(theta_points-1)), m5_en, m5_pin, m5, 0, 10);           
adjpostest(a, PR(2,1)+((pathPts(2)-1)*(PR(2,2)-PR(2,1))/(theta_points-1)), m4_en, m4_pin, m4, 1, 10);
adjpostest(a, PR(1,2)-((pathPts(3)-1)*(PR(1,2)-PR(1,1))/(theta_points-1)), m3_en, m3_pin, m3, 0, 10);          
% 
% pathPts = [1, 3, 10];
% distance = 10;
% theta_points = 20;
% 
% % max_time = 11;
% % adjpostest(a, PR(3,2)-((pathPts(1)-1)*(PR(3,2)-PR(3,1))/(theta_points-1)), ...
% %    m5_en, m5_pin, m5, 0, max(4, (max_time/(theta_points-1) * (distance) ) ) );

% max_time = 8;
% adjpostest(a, PR(2,1)+((pathPts(2)-1)*(PR(2,2)-PR(2,1))/(theta_points-1)), ...
%     m4_en, m4_pin, m4, 1, max(4, (max_time/(theta_points-1) * (distance) ) ) );

% max_time = 12;
% adjpostest(a, PR(1,2)-((pathPts(3)-1)*(PR(1,2)-PR(1,1))/(theta_points-1)), ...
%      m3_en, m3_pin, m3, 0, max(5, (max_time/(theta_points-1) * (distance) ) ) );           

clear a;
            