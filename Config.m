function []=Config()
a = arduino('COM3','Mega2560')

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
end