function [finalpathdrone, solutiondrone] = interplanner(n,NodesA,NodesB,statusA,statusB,reached)

mapData = load("uavMapCityBlock.mat","omap");
omap = mapData.omap;
% Consider unknown spaces to be unoccupied
omap.FreeThreshold = omap.OccupiedThreshold;
ss = ExampleHelperUAVStateSpace("MaxRollAngle",pi/6,...
                                "AirSpeed",6,...
                                "FlightPathAngleLimit",[-0.1 0.1],...
                                "Bounds",[-20 220; -20 220; 10 100; -pi pi]);




   

if statusA==1 && statusB==0 && reached~=1
    if reached==2
        max=numel(NodesB(:,1));
        setOccupancy(omap,[NodesB(max,1),NodesB(max,2),NodesB(max,3)], 1)
    else
        setOccupancy(omap,[NodesB(n,1),NodesB(n,2),NodesB(n,3)], 1)
    end

    
    threshold= [(NodesA(n+1,:)-0.5)' (NodesA(n+1,:)+0.5)'; -pi pi];
    setWorkspaceGoalRegion(ss,NodesA(n+1,:),threshold)

elseif statusA==0 && statusB==1 && reached~=2

    if reached==1
        max=numel(NodesA(:,1));
        setOccupancy(omap,[NodesA(max,1),NodesA(max,2),NodesA(max,3)], 1)
    else
        setOccupancy(omap,[NodesA(n,1),NodesA(n,2),NodesA(n,3)], 1)
    end

    
    threshold= [(NodesB(n+1,:)-0.5)' (NodesB(n+1,:)+0.5)'; -pi pi];
    setWorkspaceGoalRegion(ss,NodesB(n+1,:),threshold)
end



sv = validatorOccupancyMap3D(ss,"Map",omap);
sv.ValidationDistance = 0.1;

planner = plannerRRT(ss,sv);
planner.MaxConnectionDistance = 50;
planner.GoalBias = 0.10;  
planner.MaxIterations = 400;
planner.GoalReachedFcn = @(~,x,y)(norm(x(1:3)-y(1:3)) < 5);


rng default

% disp("reached value=");
% disp(reached);


if statusA==1 && reached~=1
%     disp("plan for A")
    [finalpathdrone, solutiondrone] = plan(planner,NodesA(n,:),NodesA(n+1,:));

elseif statusA==1 && reached==1
    max=numel(NodesA(:,1));
%     disp("A reached, just copying previous path")
    [finalpathdrone, solutiondrone] = plan(planner,NodesA(max-1,:),NodesA(max,:));
end 

if statusB==1 && reached~=2
%     disp("plan for B")
    [finalpathdrone, solutiondrone] = plan(planner,NodesB(n,:),NodesB(n+1,:));

elseif statusB==1 && reached ==2
    max=numel(NodesB(:,1));
%     disp("B reached, just copying previous path")
    [finalpathdrone, solutiondrone] = plan(planner,NodesB(max-1,:),NodesB(max,:));
end

end
