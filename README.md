# Intro2Robotics_FinalProject
Intro to Robotics: Final Project

This Demonstration shows a three-link OWI robotic arm operating in the 3D workspace containing some obstacles (blocking walls), and it does a path planning directing the robot arm move to a arbitrarily selected point without colliding with the obstacles . 
In this project, the corresponding robot phase space q = (theta1, theta2, theta3) can be visualized in a space called configuration space in which the collision will be checked as the arm intersects obstacles. A collision free configuration space will be setup in this process. After setup, a Breadth first search is implemented in this voxelized collision free space for path planning.
To explore our model, you can redefine obstacles in the workspace (by real geometry settings of obstacles) and see the corresponding block setup in the configuration space. You can also relocated the start and end points in configuration space and exam our path planning function. 

