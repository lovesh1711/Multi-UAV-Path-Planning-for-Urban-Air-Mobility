function [finalpath,solution] = individualPlanner(n,NodesX)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
load("office_area_gridmap.mat","occGrid")

bounds = [occGrid.XWorldLimits; occGrid.YWorldLimits; [-pi pi]];

ss = stateSpaceDubins(bounds);
ss.MinTurningRadius = 0.4;

stateValidator2 = validatorOccupancyMap(ss); 
stateValidator2.Map = occGrid;
stateValidator2.ValidationDistance = 0.05;

individualPlanner = plannerRRT(ss,stateValidator2);
individualPlanner.MaxConnectionDistance = 0.5;
individualPlanner.MaxIterations = 30000;

individualPlanner.GoalReachedFcn = @exampleHelperCheckIfGoal;

rng default
[finalpath, solution] = plan(individualPlanner,NodesX(n,:),NodesX(n+1,:));



end

