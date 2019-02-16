%% main function - minimization
clc, clear, close all

FitFcn = @myFitness;
nvars = 2;
[x, fval] = ga(FitFcn,nvars);