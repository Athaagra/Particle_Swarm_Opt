clear
clc

%Problem preparation
problem.nVar = 5;
problem.ub = [100,100,100,100,100];
problem.lb = [-100,-100,-100,-100,-100];
problem.fobj = @ackley;

%PSO parameters
noP = 5;
maxIter = 500;
visFlag = 1;

disp('PSO is optimizing the objective function')
[GBEST, cgcurve] = PSO(noP, maxIter, problem, visFlag);
disp('End of the optimization process')