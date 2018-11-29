function[distanceBFS,pathPts]=BreathFastSearch(A,targetXYZ,theta_points,startXYZ)
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
             %distanceBFS(pt(1), pt(2) + 1, pt(3) ) = dist + 2;
             distanceBFS(pt(1), pt(2) + 1, pt(3) ) = dist + 1;  
        end
    end
    
    % y - 1
    if ( (pt(2) - 1) > 0)
        if ( (distanceBFS(pt(1), pt(2) - 1, pt(3) ) ~= obstacle) && ...
             (distanceBFS(pt(1), pt(2) - 1, pt(3) ) > (dist + 1) ) )
             qE = qE + 1;
             queue(qE, :) = [pt(1), pt(2) - 1, pt(3)];
             %distanceBFS(pt(1), pt(2) - 1, pt(3) ) = dist + 2;
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

% function cost = obsCost(dist)
%     if dist < 0
%         cost = 10e8;
%     else
%         cost = dist;
%     end
% end

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


end