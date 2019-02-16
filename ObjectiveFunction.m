function[ o ] = ObjectiveFunction( x )

% List your constraints
%const1 = x(2)<= 2.2||x(2)>=5.4;
%const2 = (x(1)/2 + x(2)^2)>= 1;
%const3 = x(1)~=x(2);

%if const1 == 1 && const2 == 1 && const3==1
    o = sum(x.^2);% Osphere test function
%else
    %the solution is not feasible(infeasible)
    %o = sum(x.^2) + 200;% Osphere test function
%g = x(1);
%l = x(2);
%o = (g.^2.*l)/2;
%o = 800.*g./w^2;
end
%end