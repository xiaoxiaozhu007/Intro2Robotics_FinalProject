clear all
a = arduino('COM3','Mega2560');
[minvol,maxvol,range]=adjpos(a,'A3')
reading=[minvol,maxvol,range];
filename = 'Config.xlsx';
xlswrite(filename,reading,'Sheet1','B5:D5')