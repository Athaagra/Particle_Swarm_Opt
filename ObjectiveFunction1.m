function[ o ] = ObjectiveFunction1(x)

    g = x(1);
    l = x(2);
    o = (g^2.*l)/2;
    %o = sum(abs(x)) + prod( abs(x));
end