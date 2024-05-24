function isReached = exampleHelperCheckIfGoal2(planner, goalState, newState)
%EXAMPLEHELPERCHECKIFGOAL

    isReached = false;
    threshold = 0.1;
    if planner.StateSpace.distance(newState, goalState) < threshold
        isReached = true;
    end

end
