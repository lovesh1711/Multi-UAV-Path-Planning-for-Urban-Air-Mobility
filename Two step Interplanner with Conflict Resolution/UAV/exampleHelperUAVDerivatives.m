function [dydt]=exampleHelperUAVDerivatives(y,wpFollowerObj,LookAheadDist,model,e,PHeadingAngle,airSpeed,rollAngleLimit)
%exampleHelperUAVDerivatives Compute the derivative of states of the controlled UAV

%   Copyright 2019 The MathWorks, Inc.

[lookAheadPoint,desiredHeading] = wpFollowerObj([y(1) ;y(2) ;y(3); y(5)],LookAheadDist);

%NED to NEH frame conversion
desiredHeight=-lookAheadPoint(3);
RollAngle=exampleHelperHeadingControl(y,desiredHeading,e,PHeadingAngle,rollAngleLimit);

% Create control signal
u = control(model);
u.RollAngle=RollAngle;
u.Height=desiredHeight;
u.AirSpeed=airSpeed;

%convert to NEH frame
yNEH=y;
yNEH(3)=-y(3);
dydtNEH = derivative(model,yNEH,u,e);

%convert from NEH to NED frame back
dydt=dydtNEH;
dydt(3)=-dydtNEH(3);

end