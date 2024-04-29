function [finalpath, solution] = interplanner(n,NodesA,NodesB,statusA,statusB)

load("office_area_gridmap.mat","occGrid")

if statusA==0 && statusB==1
    
    setOccupancy(occGrid,[NodesB(n,1),NodesB(n,2)], 1)
else
    setOccupancy(occGrid,[NodesA(n,1),NodesA(n,2)], 1)
end


bounds = [occGrid.XWorldLimits; occGrid.YWorldLimits; [-pi pi]];

ss = stateSpaceDubins(bounds);
ss.MinTurningRadius = 0.4;

stateValidator2 = validatorOccupancyMap(ss); 
stateValidator2.Map = occGrid;
stateValidator2.ValidationDistance = 0.05;

interaplanner = plannerRRT(ss,stateValidator2);
interaplanner.MaxConnectionDistance = 0.1;
interaplanner.MaxIterations = 60000;

interaplanner.GoalReachedFcn = @exampleHelperCheckIfGoal2;



rng default

if statusA==0
    [finalpath, solution] = plan(interaplanner,NodesA(n,:),NodesA(n+1,:));
elseif statusB==0
    [finalpath, solution] = plan(interaplanner,NodesB(n,:),NodesB(n+1,:));
end




end