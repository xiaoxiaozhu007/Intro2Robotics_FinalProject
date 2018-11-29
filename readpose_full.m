function[curvol]=readpose_full(a, port)

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

% pot pin
port = m5; %m3, m4, m5

curvol = readVoltage(a,port); 

clear a;

end
