function[]=vis3D_collision(A)

% This function is used to plot 3D array showtest path distance A
for i = 1 : size(A,1)
    for j = 1 : size(A,2)
        for k = 1 : size(A,3)
            if A(i,j,k)== -2
                % offset by -0.5 to center on axis gridlines
                voxel( [i - 0.5, j - 0.5, k - 0.5], [1, 1, 1], 'red', 0.2);
                %voxel( [i - 1, j - 1, k - 1], [1, 1, 1], 'red', 0.05);
            end
        end
    end
end

axis([0 size(A,1)+1 0 size(A,2)+1 0 size(A,3)+1])
daspect([1,1,1]);
xlabel('\theta_1', 'Fontsize', 14, 'FontWeight', 'bold');
ylabel('\theta_2', 'Fontsize', 14, 'FontWeight', 'bold');
zlabel('\theta_3', 'Fontsize', 14, 'FontWeight', 'bold');

% offset by 0.5 to center on axis gridlines
set(gca,'xlim',[0.5 size(A,1)+0.5], 'ylim',[0.5 size(A,2)+0.5], ...
        'zlim',[0.5 size(A,3)+0.5]);
    
%set(gcf, 'position', [10, 10, 200, 100]);

grid on
%set(gca,'xlim',[0 size(A,1) + 1], 'ylim',[0 size(A,2) + 1], ...
%        'zlim',[0 size(A,3) + 1]);

% 
% scatter3(scatterMatrix(1:index, 1), scatterMatrix(1:index, 2), ...
%          scatterMatrix(1:index, 3) );
% %hold on
% 
% axis([0 size(A,1) 0 size(A,2) 0 size(A,3)])
% %colormap(jet)
% %colorbar
% %caxis([min(A(:)) max(A(:))])
% grid on
% pbaspect([1 1 1])
% hold off
end