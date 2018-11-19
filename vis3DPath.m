function []=vis3DPath(distanceBFS,pathPts)
global hlink;
figure,title('Planned path');
s1 = subplot(1,2,2); vis3D(distanceBFS), hold on
scatter3(pathPts(:,1),pathPts(:,2),pathPts(:,3),150,'+','w','LineWidth',1.5),hold on
scatter3(pathPts(:,1),pathPts(:,2),pathPts(:,3),150,'o','r','LineWidth',1.5),hold off

s2 = subplot(1,2,1);
scatter3(pathPts(:,1),pathPts(:,2),pathPts(:,3),150,'+','w','LineWidth',1.5),hold on
scatter3(pathPts(:,1),pathPts(:,2),pathPts(:,3),150,'o','r','LineWidth',1.5),%axis equal, hold off
hold off
axis([0 size(distanceBFS,1) 0 size(distanceBFS,2) 0 size(distanceBFS,3)])
pbaspect([1 1 1])

hlink = linkprop([s1,s2],{'CameraPosition','CameraUpVector'});
rotate3d on

end