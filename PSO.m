function[GBEST,cgCurve] = PSO(noP,maxIter,problem,dataVis)

% Define the details of the objective function
nVar = problem.nVar;
ub = problem.ub;
lb = problem.lb;
fobj = problem.fobj;

% Extra variable for data visualization
%average_objective = zeros(1,maxIter);
%cgCurve = zeros(1,maxIter);
%FirstP_D1= zeros(1,maxiter);
%position_history = zeros(noP,maxIter, nVar);
% We define the number of the variables
%nVar = 2;
% We define the upper bound and we write them all
%ub = [10 10];
%lb = [-10 -10];
%fobj = @ObjectiveFunction;

% Define the PSO's parameters
%noP = 30;
%maximum number of iterations
%maxIter = 500;
%inertia weights
wMax = 0.9;
wMin = 0.2;
%coeficients
c1 = 2;
c2 = 2;
vMax=(ub - lb)*0.2;
vMin=-vMax;


%The PSO algorithm

%Initialize the particles
for k=1 : noP
    Swarm.Particles(k).X = (ub-lb.*rand(1,nVar)+ lb);
    Swarm.Particles(k).V = zeros(1, nVar);
    Swarm.Particles(k).PBEST.X = zeros(1,nVar);
    Swarm.Particles(k).PBEST.O = inf;
    
    Swarm.GBEST.X = zeros(1,nVar);
    Swarm.GBEST.O = inf;
end

%Main loop of PSO
for t = 1 : maxIter
    %Calculate the objective value
    for k =1 : noP
        currentX = Swarm.Particles(k).X;
        %position_history(k, t,:) = CurrentX;
        
        Swarm.Particles(k).O = fobj(currentX);
        %average_objective(t) = average_objective(t) + Swarm.Particles(k).O;
        % Update the PBEST
        if Swarm.Particles(k).O < Swarm.Particles(k).PBEST.O
           Swarm.Particles(k).PBEST.X = currentX;
           Swarm.Particles(k).PBEST.O = Swarm.Particles(k).O;
        end
        % Update the GBEST
        if Swarm.Particles(k).O < Swarm.GBEST.O
            Swarm.GBEST.X = currentX;
            Swarm.GBEST.O = Swarm.Particles(k).O;
        end
    end
    
    % Update the X and V vector
    w = wMax - t.*((wMax-wMin)/maxIter);
    
    for k = 1 : noP
        Swarm.Particles(k).V = w.*Swarm.Particles(k).V + c1.*rand(1,nVar).*(Swarm.Particles(k).PBEST.X - Swarm.Particles(k).X)...
                                                       + c2.*rand(1,nVar).*(Swarm.GBEST.X- Swarm.Particles(k).X); 
        %Check velocities
        index1 = find(Swarm.Particles(k).V > vMax);
        index2 = find(Swarm.Particles(k).V < vMin);
        
        Swarm.Particles(k).V(index1) = vMax(index1);
        Swarm.Particles(k).V(index2) = vMin(index2);
        
        
        Swarm.Particles(k).X = Swarm.Particles(k).X + Swarm.Particles(k).V;
        
        % Check positions
        index1 = find(Swarm.Particles(k).X > ub);
        index2 = find(Swarm.Particles(k).X < lb);
        
        Swarm.Particles(k).X(index1)=ub(index1);
        Swarm.Particles(k).X(index2)=lb(index2);
    end
    if dataVis== 1
     outmsg = ['iteration#', num2str(t), 'Swarm.GBEST.O =', num2str(Swarm.GBEST.O)];
     disp(outmsg);
    end
    cgCurve(t) = Swarm.GBEST.O;
    %average_obejctive(1) = average_objective(1)/noP;
end

GBEST = Swarm.GBEST;

if dataVis == 1
    semilogy(cgCurve);
    xlabel('Iteration#')
    ylabel('Weight')
end
