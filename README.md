# Multi-UAV-Path-Planning-for-Urban-Air-Mobility


MultiUAV path planning has gained significant attention, driven by the applications of UAVs in commercial contexts. However, prevailing research often limits the full spectrum of real-world constraints inherent in this complex problem. This report investigates efficient path planning of agents navigating urban environments. Each agent is tasked with delivery responsibilities, necessitating movement to starting points and subsequent goal positions while navigating obstacles and avoiding collisions with other agents. 


Two distinct approaches are introduced: the Two Step Interplanner and the Two Step Interplanner with Conflict Resolution. These methodologies meticulously consider potential points of conflict and various constraints. Through experimentation, these algorithms are simulated on a pre-generated 3D occupancy map. The latter algorithm is particularly pertinent in scenarios where real-time computation is paramount. Initially tested in a 2D environment with multiple agents assigned specific tasks and goals, these methodologies were extended to a 3D map, accounting for UAV-specific constraints such as maximum roll angle and forward flight speed. 


## Two Step Interplanner

![image](https://github.com/lovesh1711/Multi-UAV-Path-Planning-for-Urban-Air-Mobility/assets/88122434/028e52dc-3b49-46e2-a6ad-25f802a47e59)

![image](https://github.com/lovesh1711/Multi-UAV-Path-Planning-for-Urban-Air-Mobility/assets/88122434/daffdde3-27cb-466c-a8d1-e311058d32d7)




In addition to the proposed approaches, a case study on task reallocation is presented, which is a critical aspect of multi UAV operations. While most existing studies focus on static task allocation, the investigation conducted addresses the dynamic nature of task execution. Unforeseen events like UAV failures or environmental changes can disrupt the original task allocation, impeding task completion. We propose a Partial Reassignment Algorithm (PRA) to solve this challenge. The PRA selectively reallocates tasks among UAVs, optimizing task success rates and alleviating communication and computation burdens. By integrating this algorithm into the framework, the adaptability and robustness of multi UAV operations in dynamic environments is enhanced.
