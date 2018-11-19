% RobotShapeData 
%Just some sample face and vertex data.
% platonic_solid by Kevin Moerman: https://www.mathworks.com/matlabcentral/fileexchange/28213-platonic-solid
% helped me generate these numbers
     %x,y,z
V1 = [0, 0, 0;   %1
      0, 0, 1;   %2
      0, 1, 0;   %3
      0, 1, 1;   %4
      1, 0, 0;   %5
      1, 0, 1;   %6
      1, 1, 0;   %7
      1, 1, 1;]; %8

V1 = [V1(:,1), V1(:,2),V1(:,3)];

F1 = [1, 2, 4, 3; %left
      5, 6, 8, 7; %right
      1, 3, 7, 5; %bottom
      2, 4, 8, 6; %top
      1, 2, 6, 5; %front
      3, 4, 8, 7; %back
      ];
  
V2 = [0, 0, 0;   %1
      0, 0, 1;   %2
      0, 1, 0;   %3
      0, 1, 1;   %4
      1, 0, 0;   %5
      1, 0, 1;   %6
      1, 1, 0;   %7
      1, 1, 1;]; %8

V2 = [V2(:,1)*5, V2(:,2), V2(:,3)];

F2 = [1, 2, 4, 3; %left
      5, 6, 8, 7; %right
      1, 3, 7, 5; %bottom
      2, 4, 8, 6; %top
      1, 2, 6, 5; %front
      3, 4, 8, 7; %back
      ];
  
V3 = [0, 0, 0;   %1
      0, 0, 1;   %2
      0, 1, 0;   %3
      0, 1, 1;   %4
      1, 0, 0;   %5
      1, 0, 1;   %6
      1, 1, 0;   %7
      1, 1, 1;]; %8

V3 = [V3(:,1)*5, V3(:,2), V3(:,3)];

F3 = [1, 2, 4, 3; %left
      5, 6, 8, 7; %right
      1, 3, 7, 5; %bottom
      2, 4, 8, 6; %top
      1, 2, 6, 5; %front
      3, 4, 8, 7; %back
      ];

obst1_V = [0, 0, 0;   %1
           0, 0, 1;   %2
           0, 1, 0;   %3
           0, 1, 1;   %4
           1, 0, 0;   %5
           1, 0, 1;   %6
           1, 1, 0;   %7
           1, 1, 1;]; %8

obst1_V = [obst1_V(:,1) * 7 + 1, obst1_V(:,2) * 7 + 1,obst1_V(:,3)];

obst1_F = [1, 2, 4, 3; %left
           5, 6, 8, 7; %right
           1, 3, 7, 5; %bottom
           2, 4, 8, 6; %top
           1, 2, 6, 5; %front
           3, 4, 8, 7; %back
           ];
       
obst2_V = [0, 0, 0;   %1
           0, 0, 1;   %2
           0, 1, 0;   %3
           0, 1, 1;   %4
           1, 0, 0;   %5
           1, 0, 1;   %6
           1, 1, 0;   %7
           1, 1, 1;]; %8

obst2_V = [obst2_V(:,1)* 7 + 3, obst2_V(:,2) - 4, obst2_V(:,3) * 7 - 1];

obst2_F = [1, 2, 4, 3; %left
           5, 6, 8, 7; %right
           1, 3, 7, 5; %bottom
           2, 4, 8, 6; %top
           1, 2, 6, 5; %front
           3, 4, 8, 7; %back
           ];