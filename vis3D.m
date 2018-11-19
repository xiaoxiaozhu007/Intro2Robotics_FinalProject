function[]=vis3D(A)
% This function is used to plot 3D array showtest path distance A
for i = 1 : size(A,1)
    for j = 1 : size(A,2)
        for k = 1 : size(A,3)
            if A(i,j,k)== -2
                scatter3(i,j,k,50,'k','filled');
                hold on
            else
                scatter3(i,j,k,100,A(i,j,k),'filled');
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