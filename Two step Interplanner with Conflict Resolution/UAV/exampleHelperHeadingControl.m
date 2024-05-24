function rollAngle = exampleHelperHeadingControl(flightState,desiredHeading, environment, PHeadingAngle,rollAngleLimit)
    %exampleHelperHeadingControl Compute the roll angle in response to a desired heading
    
    %   Copyright 2019 The MathWorks, Inc.
    
    Va =    flightState(4);
    headingAngle =  flightState(5);
    flightPathAngle =flightState(6);
    
    YawAngle = headingAngle - asin((1/Va)*[environment.WindNorth, environment.WindEast]*[-sin(headingAngle); cos(headingAngle)]);
    b = [cos(headingAngle)*cos(flightPathAngle), sin(headingAngle)*cos(flightPathAngle), -sin(flightPathAngle)]*[environment.WindNorth; environment.WindEast; environment.WindDown];
    c = [environment.WindNorth, environment.WindEast, environment.WindDown]*[environment.WindNorth; environment.WindEast; environment.WindDown]- Va^2;
    Vg = -b+sqrt(b^2-c);
    
    rollAngle = atan2(PHeadingAngle*angdiff(headingAngle,desiredHeading)*Vg,environment.Gravity*cos(headingAngle-YawAngle));
    if(rollAngle>abs(rollAngleLimit))
       rollAngle=abs(rollAngleLimit);
    end
    if(rollAngle<-abs(rollAngleLimit))
       rollAngle=-abs(rollAngleLimit);
    end
end
