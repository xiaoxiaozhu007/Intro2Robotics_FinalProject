function[]=vis3D(A)
% This function is used to plot 3D array showtest path distance A
Amin=min(A(:));
Amax=max(A(:));
alphaScale=Amax-Amin+1;
for i = 1 : size(A,1)
    for j = 1 : size(A,2)
        for k = 1 : size(A,3)
            if A(i,j,k)~= -2
                %scatter3(i,j,k,50,'k','filled');
                %hold on
                voxel( [i - 0.5, j - 0.5, k - 0.5], [1, 1, 1], A(i,j,k), (A(i,j,k)-Amin+0.1)/alphaScale);
                %scatter3(i,j,k,100,A(i,j,k),'filled');
                hold on
            end
        end
    end
end
axis([0 size(A,1) 0 size(A,2) 0 size(A,3)])
colormap(jet)
colorbar
caxis([min(A(:)) max(A(:))])
grid on
pbaspect([1 1 1])
hold off
end