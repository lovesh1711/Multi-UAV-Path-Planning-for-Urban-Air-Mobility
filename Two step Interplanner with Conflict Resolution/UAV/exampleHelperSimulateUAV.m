function [xENU,yENU,zENU] = exampleHelperSimulateUAV(waypoints,airSpeed,Tend)
%exampleHelperSimulateUAV Simulate the UAV waypoint following behavior using an ode solver

%   Copyright 2019 The MathWorks, Inc.

% Define Model and gains for the fixed wing guidance model.
model = fixedwing;
model.Configuration.PDRoll = [40 3.9];
model.Configuration.PHeight = 3.9;
model.Configuration.PFlightPathAngle = 39;
model.Configuration.PAirSpeed = 0.39;
model.Configuration.FlightPathAngleLimits = [-0.1 0.1];

% Setup environment struct for fixed wing guidance model
e = environment(model);

% Setup model initial states
% The states are in the format given below:
% North, East, Height, AirSpeed, Heading Angle, FlightPathAngle, RollAngle,
% RollAngleRate
y0 = state(model);
y0(1:8)=[waypoints(1,1);waypoints(1,2);waypoints(1,3); airSpeed;waypoints(1,4);0;0;0];

% Setup WayPoint Follower Object
wpFollowerObj = uavWaypointFollower('UAVType','fixed-wing','Waypoints',waypoints(:,1:3),'TransitionRadius',0.05,'StartFrom','First');

% Set Heading Control Gain for Heading Controller.
PHeadingAngle=2;

% Define Roll Angle Limit for UAV
UAVRollLimit=pi/4;

% Define Look Ahead Distance of the Waypoint Follower.
lookAheadDist=3;

% Simulate model
simOut = ode45(@(t,y)exampleHelperUAVDerivatives(y,wpFollowerObj,lookAheadDist,model,e,PHeadingAngle,airSpeed,UAVRollLimit), linspace(0,Tend,1000),y0);
xENU=simOut.y(1,:);
yENU=simOut.y(2,:);
zENU=simOut.y(3,:);


end


