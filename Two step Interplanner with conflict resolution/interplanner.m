function [finalpath, solution] = interplanner(n,NodesX,NodesY,statusX,statusY)

load("office_area_gridmap.mat","occGrid")


if statusX==0 && statusY==1
    
    setOccupancy(occGrid,[NodesY(n,1),NodesY(n,2)], 1)
else
    setOccupancy(occGrid,[NodesX(n,1),NodesX(n,2)], 1)
end


bounds = [occGrid.XWorldLimits; occGrid.YWorldLimits; [-pi pi]];

ss = stateSpaceDubins(bounds);
ss.MinTurningRadius = 0.4;

stateValidator2 = validatorOccupancyMap(ss); 
stateValidator2.Map = occGrid;
stateValidator2.ValidationDistance = 0.05;

interaplanner = plannerRRT(ss,stateValidator2);
interaplanner.MaxConnectionDistance = 0.1;
interaplanner.MaxIterations = 30000;

interaplanner.GoalReachedFcn = @exampleHelperCheckIfGoal2;



rng default

if statusX==0
    [finalpath, solution] = plan(interaplanner,NodesX(n,:),NodesX(n+1,:));
elseif statusY==0
    [finalpath, solution] = plan(interaplanner,NodesY(n,:),NodesY(n+1,:));
end




end