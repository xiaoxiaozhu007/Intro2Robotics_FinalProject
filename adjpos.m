function[minvol,maxvol,range]=adjpos(a,port)
minvol=5;
maxvol=0;
tic
while toc < 40
    curvol = readVoltage(a,port); 
    if curvol<minvol
        minvol=curvol;
    end
    if curvol>maxvol
        maxvol=curvol;
    end
    range=maxvol-minvol;
%disp(minvol,maxvol,range)
end

    