% COLLISIONCHECK  check collision of robot arm and 2 obstacles
%   theta_min         - 3 entry array of theta1, theta2, theta3 minimums
%   theta_max         - 3 entry array of theta1, theta2, theta3 maximums
%   theta_points      - number of distinct thetas between min and max
%   iterationsAllowed - number of iterations for GJK() collision checking
%   r2                - length of r2 on robot arm
%   r3                - length of r3 on robot arm
%   createGraph       - show real-time graph of collision checking (slow!)
% Return the collission Map of configureation sapce
function [collisionMap]=collisionCheck(theta_min, theta_max, theta_points, ...
                           iterationsAllowed, r2, r3, createGraph)
                       
% Example script for GJK function
%   Animates two objects on a collision course and terminates animation
%   when they hit each other. Loads vertex and face data from
%   SampleShapeData.m. See the comments of GJK.m for more information
%
%   Most of this script just sets up the animation and transformations of
%   the shapes. The only key line is:
%   collisionFlag = GJK(S1Obj,S2Obj,iterationsAllowed)
%
%   Matthew Sheen, 2016

% 14-nov-18 asw  - Initial version.
%
%                  Note: All T matrices were created with the following DH 
%                  parameters (a = alpha, t = theta):
%
%                  Link   r      a      d      t
%                  1      0      -pi/2  0      t1
%                  2      r2     0      0      t2
%                  3      r3     0      0      t3

% Make a figure
if (createGraph == 1)
    fig = figure;
    hold on
end

freeSpaceVal = theta_points^3;

% Load sample vertex and face data for two convex polyhedra
RobotShapeData;

% Make shape 1
S1.Vertices = V1;
S1.Faces = F_ALL;
S1.FaceVertexCData = jet(size(V1,1));
S1.FaceColor = 'interp';

% Make shape 2
S2.Vertices = V2;
S2.Faces = F_ALL;
S2.FaceVertexCData = jet(size(V2,1));
S2.FaceColor = 'interp';

% Make shape 3
S3.Vertices = V3;
S3.Faces = F_ALL;
S3.FaceVertexCData = jet(size(V3,1));
S3.FaceColor = 'interp';

% Make obstacle 1
O1.Vertices = obst1_V;
O1.Faces = F_ALL;
O1.FaceVertexCData = jet(size(obst1_V,1));
O1.FaceColor = 'interp';

% Make obstacle 2
O2.Vertices = obst2_V;
O2.Faces = F_ALL;
O2.FaceVertexCData = jet(size(obst2_V,1));
O2.FaceColor = 'interp';

% Make obstacle 3
O3.Vertices = obst3_V;
O3.Faces = F_ALL;
O3.FaceVertexCData = jet(size(obst3_V,1));
O3.FaceColor = 'interp';

% Make obstacle 4
O4.Vertices = obst4_V;
O4.Faces = F_ALL;
O4.FaceVertexCData = jet(size(obst4_V,1));
O4.FaceColor = 'interp';

S1Obj = patch(S1);
S2Obj = patch(S2);
S3Obj = patch(S3);
Obst1 = patch(O1);
Obst2 = patch(O2);
Obst3 = patch(O3);
Obst4 = patch(O4);

hold off
axis equal
axis(75*[-5 5 -5 5 -5 5])
fig.Children.Visible = 'on'; % Turn off the axis for more pleasant viewing.
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');
fig.Color = [1 1 1];
rotate3d on;

%Store initial coordinates
S1Coords = S1Obj.Vertices;
S2Coords = S2Obj.Vertices;
S3Coords = S3Obj.Vertices;

t1_disc_rad = (theta_max(1) - theta_min(1) ) / (theta_points - 1);
t2_disc_rad = (theta_max(2) - theta_min(2) ) / (theta_points - 1);
t3_disc_rad = (theta_max(3) - theta_min(3) ) / (theta_points - 1);

if (createGraph == 1)
    t = text(3, 3, 3, 'Good!', 'FontSize', 20);
end

% need theta_points^3 memory locations
collisionMap = -1*ones(theta_points, theta_points, theta_points);
         
%%% i-th iteration - theta 1
for i = 0:1:(theta_points - 1)

    % determine theta1 for the i-th iteration and calculate sin and cos
    t1 = theta_min(1) + (i * t1_disc_rad);
    s_t1 = sin(t1);
    c_t1 = cos(t1);

    % Construct A1 matrix from DH parameters
    S1_A = [c_t1, 0,  -s_t1, 0;
            s_t1, 0,  c_t1,  0;
            0,    -1, 0,     0;
            0,    0,  0,     1;];

    % Multiply T matrices together, i-th iteration doesn't need translation
    S1Obj.Vertices = (S1_A(1:3,1:3) * S1Coords')';

%%% j-th iteration - theta 2
    for j = 0:1:(theta_points - 1)

        % determine theta2 for the j-th iteration and calculate sin and cos
        t2 = theta_min(2) + (j * t2_disc_rad);
        s_t2 = sin(t2);
        c_t2 = cos(t2);
        

        S2_A = [c_t2, -s_t2, 0, (r2) * c_t2;
                s_t2, c_t2,  0, (r2) * s_t2;
                0,    0,     1, 0;
                0,    0,     0, 1;        ];
            
            
        % Calculate T2 matrix by A1 * A2
        S2T = S1_A * S2_A;

        S2Obj.Vertices = (S2T(1:3,1:3) * S2Coords')';
         
%%% k-th iteration - theta 3
        for k = 0:1:(theta_points - 1)
            
            % determine theta3 for the k-th iteration and calculate sin and 
            % cos
            t3 = theta_min(3) + (k * t3_disc_rad);
            s_t3 = sin(t3);
            c_t3 = cos(t3);

            % Construct A3 matrix from DH parameters
            S3_A = [c_t3, -s_t3, 0, r3 * c_t3;
                    s_t3, c_t3,  0, r3 * s_t3;
                    0,    0,     1, 0;
                    0,    0,     0, 1;];

            % Calculate T3 matrix by A1 * A2 * A3 (same as T2 * A3)
            S3T = S2T * S3_A;
            
            % offset for 2nd polygon is based on joint 2
            S3Obj.Vertices = (S3T(1:3,1:3) * S3Coords')' + S2T(1:3,4)';
            
            if (createGraph == 1)
                drawnow;
            end

            % Perform collision detection
            collisionFlag = GJK(S2Obj, Obst1, iterationsAllowed) || ...
                            GJK(S3Obj, Obst1, iterationsAllowed) || ...
                            GJK(S2Obj, Obst2, iterationsAllowed) || ...
                            GJK(S3Obj, Obst2, iterationsAllowed) || ...
                            GJK(S2Obj, Obst3, iterationsAllowed) || ...
                            GJK(S3Obj, Obst3, iterationsAllowed) || ...
                            GJK(S2Obj, Obst4, iterationsAllowed) || ...
                            GJK(S3Obj, Obst4, iterationsAllowed);

            % Mark 1 for collision and leave 0 for no collision
            if collisionFlag
                if (createGraph == 1)
                    delete(t);
                    t = text(-5,-5, -5,'Collision!','FontSize',20);
                end

                collisionMap(i + 1, j + 1, k + 1) = -2;

            else
                if (createGraph == 1)
                    delete(t);
                    t = text(-5, -5, -5, 'Good!', 'FontSize', 20);
                end
                
                collisionMap(i + 1, j + 1, k + 1) = freeSpaceVal;
            end
        end
    end
end
