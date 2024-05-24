function [finalpathdrone, solutiondrone] = interplanner(n,NodesA,NodesB,statusA,statusB)

mapData = load("uavMapCityBlock.mat","omap");
omap = mapData.omap;
% Consider unknown spaces to be unoccupied
omap.FreeThreshold = omap.OccupiedThreshold;
ss = ExampleHelperUAVStateSpace("MaxRollAngle",pi/6,...
                                "AirSpeed",6,...
                                "FlightPathAngleLimit",[-0.1 0.1],...
                                "Bounds",[-20 220; -20 220; 10 100; -pi pi]);




   
if statusA==0 && statusB==1
    setOccupancy(omap,[NodesB(n,1),NodesB(n,2),NodesB(n,3)], 1)

    threshold= [(NodesA(n+1,:)-0.1)' (NodesA(n+1,:)+0.1)'; -pi pi];
    setWorkspaceGoalRegion(ss,NodesA(n+1,:),threshold)

elseif statusA==1 && statusB==0 
    setOccupancy(omap,[NodesA(n,1),NodesA(n,2),NodesA(n,3)], 1)

    threshold= [(NodesB(n+1,:)-0.1)' (NodesB(n+1,:)+0.1)'; -pi pi];
    setWorkspaceGoalRegion(ss,NodesB(n+1,:),threshold)

end


sv = validatorOccupancyMap3D(ss,"Map",omap);
sv.ValidationDistance = 0.1;

planner = plannerRRT(ss,sv);
planner.MaxConnectionDistance = 10;
planner.GoalBias = 0.10;  
planner.MaxIterations = 1000;
planner.GoalReachedFcn = @(~,x,y)(norm(x(1:3)-y(1:3)) < 2);


rng default




if statusA==0 
%     disp("plan for A")
    [finalpathdrone, solutiondrone] = plan(planner,NodesA(n,:),NodesA(n+1,:));
end 

if statusB==0
%     disp("plan for B")
    [finalpathdrone, solutiondrone] = plan(planner,NodesB(n,:),NodesB(n+1,:));

end