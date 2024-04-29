function plotter(finalpath, NodesA, NodesB)

load("office_area_gridmap.mat","occGrid")

show(occGrid)
hold on

plot(finalpath.States(:,1),finalpath.States(:,2),'r-','LineWidth',2)

plot(NodesA(1,1),NodesA(1,2),'ro')
plot(NodesA(36,1),NodesA(36,2),'mo')


plot(NodesB(1,1),NodesB(1,2),'ro')
plot(NodesB(36,1),NodesB(36,2),'mo')

hold off

end
