function[]=vis3D(A)
% This function is used to plot 3D array showtest path distance A
Amin=min(A(:));
Amax=max(A(:));
alphaScale=Amax-Amin+1;
unreachable_val = size(A,1) * size(A,2) * size(A,3);

x_coords = zeros(size(A,1)*size(A,2)*size(A,3), 1);
y_coords = zeros(size(A,1)*size(A,2)*size(A,3), 1);
z_coords = zeros(size(A,1)*size(A,2)*size(A,3), 1);
color    = zeros(size(A,1)*size(A,2)*size(A,3), 1);
c_index = 1;

for i = 1 : size(A,1)
    for j = 1 : size(A,2)
        for k = 1 : size(A,3)
            if (A(i,j,k)~= -2) && (A(i, j, k) ~= unreachable_val)
                %scatter3(i,j,k,50,'k','filled');
                %hold on
                %voxel( [i - 0.5, j - 0.5, k - 0.5], [1, 1, 1], A(i,j,k), (A(i,j,k)-Amin+0.1)/alphaScale);
                %scatter3(i,j,k,100,A(i,j,k),'filled');
                
                x_coords(c_index) = i;
                y_coords(c_index) = j;
                z_coords(c_index) = k;
                color(c_index) = A(i,j,k);
                
                c_index = c_index + 1;
                
                hold on
            end
        end
    end
end

scatter3(x_coords(1:c_index), y_coords(1:c_index), z_coords(1:c_index), ...
         50, color(1:c_index), 'filled' );

axis([0 size(A,1) 0 size(A,2) 0 size(A,3)]);
colormap(jet(256) );
c = colorbar;
c.Label.String = 'Distance';
caxis([1 max(color(:))])
grid on
pbaspect([1 1 1])

xlabel('\theta_1', 'Fontsize', 14, 'FontWeight', 'bold');
ylabel('\theta_2', 'Fontsize', 14, 'FontWeight', 'bold');
zlabel('\theta_3', 'Fontsize', 14, 'FontWeight', 'bold');

hold off
hold on
hold off
end