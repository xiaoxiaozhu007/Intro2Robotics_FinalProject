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
%% UI setup of target
startXYZ =  [1, 1, 1];
targetXYZ=SetTarget(startXYZ,A,theta_points);
%% Breath fast search
[distanceBFS,pathPts] = BreathFastSearch(A,targetXYZ,theta_points,startXYZ);
vis3DPath(distanceBFS,pathPts,A);
end