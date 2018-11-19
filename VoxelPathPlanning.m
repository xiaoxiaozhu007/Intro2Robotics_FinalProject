function []=VoxelPathPlanning()
%clc,clear
%% Some initial and Collision Check %%
% Set up the angular resolution to the configeration space
theta_min = [-pi / 2, -pi / 2, 0];
%theta_min_str = ["-\pi / 2", "-\pi / 2", "0"];
theta_max = [pi / 2, 0, pi / 2];
%theta_max_str = ["\pi / 2", "0", "\pi / 2"];
theta_points = 10;
% Collision check returns config space with no collision
A = collisionCheck(theta_min, theta_max, theta_points, 4, 5, 5, 1);
%A = collisionCheck(theta_min, theta_max, theta_points, 1, 5, 5, 0);
%% UI setup
figuresize = [1024, 768];
%figure,vis3D(A),title('3D grid and obstacles initial settings');
f = figure('Name', 'Configuration Space (Obstacles only)', 'position', ...
           [200, 200, figuresize(1), figuresize(2)]);
subplot(4, 4, [5, 6, 7, 9, 10, 11, 13, 14, 15] );
title('Configuration Space (Obstacles only)');
vis3D_collision(A);
%subplot(4, 1, 1);
startXYZ =  [1, 1, 1]; % where you start (change to current position later
voxel( [startXYZ(1) - 0.5, startXYZ(2) - 0.5, startXYZ(3) - 0.5],...
           [1, 1, 1], 'green', 0.75);

       
pos = -2;
while pos==-2    
    %%% SLIDER 1
    b1 = uicontrol('Parent', f, 'Style', 'slider', 'Position', ...
                  [128, figuresize(2) - 60, figuresize(1) - 256, 20], ...
                  'value', 1, 'min', 1, ...
                  'max', theta_points, 'Callback', @Slider1_Callback );

    uicontrol('Parent', f, 'Style', 'text', 'Position', ...
              [96 - 20, figuresize(2) - 60, 40, 20], ...
              'String', 1); %'BackgroundColor', bgcolor);
    uicontrol('Parent', f, 'Style', 'text', 'Position', ...
              [figuresize(1) - 96 - 20, figuresize(2) - 60, 40, 20], ...
              'String', theta_points);
    uicontrol('Parent', f, 'Style', 'text', 'Position', ...
              [figuresize(1) - 96 + 20, figuresize(2) - 60, 40, 20], ...
              'String', get(b1,'Value') );

    %%% SLIDER 2
    b2 = uicontrol('Parent', f, 'Style', 'slider', 'Position', ...
                  [128, figuresize(2) - 120, figuresize(1) - 256, 20], ...
                  'value', 1, 'min', 1, ...
                  'max', theta_points, 'Callback', @Slider2_Callback);

    uicontrol('Parent', f, 'Style', 'text', 'Position', ...
              [96 - 20, figuresize(2) - 120, 40, 20], ...
              'String', 1);
    uicontrol('Parent', f, 'Style', 'text', 'Position', ...
              [figuresize(1) - 96 - 20, figuresize(2) - 120, 40, 20], ...
              'String', theta_points);
    uicontrol('Parent', f, 'Style', 'text', 'Position', ...
              [figuresize(1) - 96 + 20, figuresize(2) - 120, 40, 20], ...
              'String', get(b2,'Value') );

    %%% SLIDER 3
    b3 = uicontrol('Parent', f, 'Style', 'slider', 'Position', ...
                  [128, figuresize(2) - 180, figuresize(1) - 256, 20], ...
                  'value', 1, 'min', 1, ...
                  'max', theta_points,  'Callback', @Slider3_Callback);

    uicontrol('Parent', f, 'Style', 'text', 'Position', ...
              [96 - 20, figuresize(2) - 180, 40, 20], ...
              'String', 1);
    uicontrol('Parent', f, 'Style', 'text', 'Position', ...
              [figuresize(1) - 96 - 20, figuresize(2) - 180, 40, 20], ...
              'String', theta_points);
    uicontrol('Parent', f, 'Style', 'text', 'Position', ...
              [figuresize(1) - 96 + 20, figuresize(2) - 180, 40, 20], ...
              'String', get(b3,'Value') );

    %%% GO BUTTON
    uicontrol('Parent', f, 'Style', 'pushbutton', 'Position', ...
              [figuresize(1) - 256 + 20, figuresize(2) - 256 - 20 - 64, ...
               216, 64], 'String', 'GO', 'Callback', @Button_Callback);

    beginGO = 0;

    hold off;
    drawnow;
    %targetXYZ = [round(b1.Value), round(b2.Value), round(b3.Value)];
    while (beginGO == 0)  %%%%% What does this do? %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        pause(0.25);
    %     hold off;
    %     voxel( [targetXYZ(1) - 0.5, targetXYZ(2) - 0.5, targetXYZ(3) - 0.5],...
    %            [1, 1, 1], 'blue', 0);
    %     targetXYZ = [round(b1.Value), round(b2.Value), round(b3.Value)];
    %     hold on;
    %     voxel( [targetXYZ(1) - 0.5, targetXYZ(2) - 0.5, targetXYZ(3) - 0.5],...
    %            [1, 1, 1], 'blue', 0.75);
    %     
    %    drawnow;
    end

    targetXYZ = [round(b1.Value), round(b2.Value), round(b3.Value)];

    %vis3D_collision(A),title('3D grid and obstacles initial settings');

    %%% add sliders here

    %%% LOOP FOREVER (until exit graph)

    %%% Some callback that checks when GO is pressed

    %%% on GO, take sliders and assign them to targetXYZ and perform search
    %targetXYZ = [10, 10, 10]; % where you end

    % check that targetXYZ is an obstacle!
    pos=A(targetXYZ(1), targetXYZ(2), targetXYZ(3));
    %if (A(targetXYZ(1), targetXYZ(2), targetXYZ(3) ) == -2)
    disp('target is an obstacle!'), pause(1);   %%% How to make it display in the current window?

        %voxel( [targetXYZ(1) - 0.5, targetXYZ(2) - 0.5, targetXYZ(3) - 0.5],...
               %[1, 1, 1], 'black', 0.75);

        %return;
        %continue;
    %end
end
voxel( [targetXYZ(1) - 0.5, targetXYZ(2) - 0.5, targetXYZ(3) - 0.5],...
           [1, 1, 1], 'blue', 0.75);
       
drawnow;


%% Breath fast search
freespace = theta_points^3;
obstacle = -2;

distanceBFS = A;
distanceBFS(targetXYZ(1), targetXYZ(2), targetXYZ(3)) = 0; 
% set the starting location to distance of 0

% initialize queue of neighbors to explore
queue = repmat([-1,-1,-1],sum(distanceBFS(:)==freespace),1);

queue(1,:) = targetXYZ;
qP = 1;  % queue pointer to the next location to examine
qE = 1;  % number of locations in the queue  (pointer to the end of the queue)

while qP <= qE
    % look at the location pointed by queuePointer
    pt = queue(qP,:);
    dist = distanceBFS(pt(1), pt(2), pt(3));
    
    % ensure that we are in bounds
    % x + 1
    if ( (pt(1) + 1) <= theta_points)
        % check if obstacle and distance larger than prev. point + 1
        if ( (distanceBFS(pt(1) + 1, pt(2), pt(3) ) ~= obstacle) && ...
             (distanceBFS(pt(1) + 1, pt(2), pt(3) ) > (dist + 1) ) )
             qE = qE + 1;
             queue(qE, :) = [pt(1) + 1, pt(2), pt(3)];
             distanceBFS(pt(1) + 1, pt(2), pt(3) ) = dist + 1;            
        end
    end
    
    % repeat for 5 other points...
    % x - 1
    if ( (pt(1) - 1) > 0)
        if ( (distanceBFS(pt(1) - 1, pt(2), pt(3) ) ~= obstacle) && ...
             (distanceBFS(pt(1) - 1, pt(2), pt(3) ) > (dist + 1) ) )
             qE = qE + 1;
             queue(qE, :) = [pt(1) - 1, pt(2), pt(3)];
             distanceBFS(pt(1) - 1, pt(2), pt(3) ) = dist + 1;            
        end
    end
    
    % y + 1
    if ( (pt(2) + 1) <= theta_points)
        if ( (distanceBFS(pt(1), pt(2) + 1, pt(3) ) ~= obstacle) && ...
             (distanceBFS(pt(1), pt(2) + 1, pt(3) ) > (dist + 1) ) )
             qE = qE + 1;
             queue(qE, :) = [pt(1), pt(2) + 1, pt(3)];
             distanceBFS(pt(1), pt(2) + 1, pt(3) ) = dist + 1;            
        end
    end
    
    % y - 1
    if ( (pt(2) - 1) > 0)
        if ( (distanceBFS(pt(1), pt(2) - 1, pt(3) ) ~= obstacle) && ...
             (distanceBFS(pt(1), pt(2) - 1, pt(3) ) > (dist + 1) ) )
             qE = qE + 1;
             queue(qE, :) = [pt(1), pt(2) - 1, pt(3)];
             distanceBFS(pt(1), pt(2) - 1, pt(3) ) = dist + 1;            
        end
    end
    
    % z + 1
    if ( (pt(3) + 1) <= theta_points)
        if ( (distanceBFS(pt(1), pt(2), pt(3) + 1) ~= obstacle) && ...
             (distanceBFS(pt(1), pt(2), pt(3) + 1) > (dist + 1) ) )
             qE = qE + 1;
             queue(qE, :) = [pt(1), pt(2), pt(3) + 1];
             distanceBFS(pt(1), pt(2), pt(3) + 1) = dist + 1;            
        end
    end
    
    % z - 1
    if ( (pt(3) - 1) > 0)
        if ( (distanceBFS(pt(1), pt(2), pt(3) - 1) ~= obstacle) && ...
             (distanceBFS(pt(1), pt(2), pt(3) - 1) > (dist + 1) ) )
             qE = qE + 1;
             queue(qE, :) = [pt(1), pt(2), pt(3) - 1];
             distanceBFS(pt(1), pt(2), pt(3) - 1) = dist + 1;            
        end
    end
    
    % increment queuePointer
    qP = qP+1;
    
    %%% update drawing  Comment this out to make the code run fast!
%     if mod(qP,200)==0
%         %display(['on qP = ', num2str(qP),' and qE = ',num2str(qE)])
%         updateBFSplot(distanceBFS,qP)
%     end
end
% draw the depth map!
%updateBFSplot(distanceBFS,qP)

% check if there is a path between points!
if ( (distanceBFS(startXYZ(1), startXYZ(2), startXYZ(3) ) == freespace) ...
        || distanceBFS(startXYZ(1), startXYZ(2), startXYZ(3) ) == obstacle)
    disp('no path between points!');
    
    return;
end

% draw the best path starting from
pathlength = ceil(distanceBFS(startXYZ(1), startXYZ(2), startXYZ(3)));
pathPts = repmat(startXYZ,pathlength,1);

i = 1;
currentDirection = 1; % default direction in +x
% 1 = +x
% 2 = -x
% 3 = +y
% 4 = -y
% 5 = +z
% 6 = -z

while (pathPts(i,1) ~= targetXYZ(1))||(pathPts(i,2) ~= targetXYZ(2))||...
        (pathPts(i,3) ~= targetXYZ(3))
    
    [currentDirection, pathPts(i + 1, :)] = ...
                   nextPathPoint(distanceBFS, pathPts(i, :), ...
                                 currentDirection, theta_points);
                             
    i = i + 1;
end

vis3DPath(distanceBFS,pathPts);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [currentDirection, ptNext] = ...
        nextPathPoint(distanceBFS, pt, currentDirection, theta_points)
    % pick the min direction
    
    % +x
    if ( (pt(1) + 1) <= theta_points)
        dA(1) = distanceBFS(pt(1) + 1, pt(2), pt(3));
    else
        dA(1) = obstacle;
    end
    
    % -x
    if ( (pt(1) - 1) > 0)
        dA(2) = distanceBFS(pt(1) - 1, pt(2), pt(3));
    else
        dA(2) = obstacle;
    end
    
    % +y
    if ( (pt(2) + 1) <= theta_points)
        dA(3) = distanceBFS(pt(1), pt(2) + 1, pt(3));
    else
        dA(3) = obstacle;
    end
    
    % -y
    if ( (pt(2) - 1) > 0)
        dA(4) = distanceBFS(pt(1), pt(2) - 1, pt(3));
    else
        dA(4) = obstacle;
    end
    
    % +z
    if ( (pt(3) + 1) <= theta_points)
        dA(5) = distanceBFS(pt(1), pt(2), pt(3) + 1);
    else
        dA(5) = obstacle;
    end
    
    % -z
    if ( (pt(3) - 1) > 0)
        dA(6) = distanceBFS(pt(1), pt(2), pt(3) - 1);
    else
        dA(6) = obstacle;
    end
    
    % loop through and set equal to large number
    for index = 1 : 1 : 6
        if (dA(index) == obstacle)
           dA(index) = freespace;
        end
    end
    
    minval = min(dA);
    
    % if current direction isn't minimum value, switch directions
    if (dA(currentDirection) ~= minval)
        [~,currentDirection] = min(dA);
    end
    
    offsets = [1, 0, 0; -1, 0, 0;
               0, 1, 0; 0, -1, 0;
               0, 0, 1; 0, 0, -1];
    
    ptNext = pt + offsets(currentDirection, :);
end

function cost = obsCost(dist)
    if dist < 0
        cost = 10e8;
    else
        cost = dist;
    end
end

%     function updateBFSplot(distanceBFS,qP)
%         h1 = pcolor(distanceBFS);
%         set(h1, 'EdgeColor', 'none');
%         set(gca,'Ydir','reverse')
%         colorbar
%         title(['Breadth-First Search, Step ', num2str(qP)])
%  
%          m = ceil(max(distanceBFS(:)));
%          colormap( [0,0,0;
%          1,1,1;
%          jet(m)]);
%          
%          
%         drawnow

%% UI setting
    % Slider 1 callback
    function Slider1_Callback(object, ~)
        val = round(b1.Value);
        b1.Value = val;
        uicontrol('Parent', f, 'Style', 'text', 'Position', ...
          [figuresize(1) - 96 + 20, figuresize(2) - 60, 40, 20], ...
          'String', get(b1,'Value') ); %'BackgroundColor', bgcolor);
    end

    % Slider 2 callback
    function Slider2_Callback(object, ~)
        val = round(b2.Value);
        b2.Value = val;
        uicontrol('Parent', f, 'Style', 'text', 'Position', ...
          [figuresize(1) - 96 + 20, figuresize(2) - 120, 40, 20], ...
          'String', get(b2,'Value') ); %'BackgroundColor', bgcolor);
    end

    % Slider 3 callback
    function Slider3_Callback(object, ~)
        val = round(b3.Value);
        b3.Value = val;
        uicontrol('Parent', f, 'Style', 'text', 'Position', ...
          [figuresize(1) - 96 + 20, figuresize(2) - 180, 40, 20], ...
          'String', get(b3,'Value') ); %'BackgroundColor', bgcolor);
    end

    % Button callback
    function Button_Callback(object, ~)
        beginGO = 1;
    end
end

