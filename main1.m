%% this is the main function
fitness = @fitness2;
nvar = 1;
[x,fval] = gamultiobj(fitness,nvar);

%% Now lets check the results
x0 = -10:0.5:10;
f1 = (x0-2).^2 - 10;
f2 = (x0-2).^2 + 20;
figure;hold on
plot(x0,f1);
plot(x0,f2);
grid;
xlabel('x');
ylabel('f');

% now plot the results on top of that
plot(x,fval(:,1),'x');
plot(x,fval(:,2),'o');

% now we can plot the pareto format
figure
plot(fval(:,1),fval(:,2), 'o');
xlabel('f1');
ylabel('f2');
grid


