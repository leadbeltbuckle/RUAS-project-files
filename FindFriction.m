function [f] = FindFriction (e, D, R)

f1 = 0.3164*R^(-0.25);   %initial guess
check = 0;

while check == 0
    f2 = 0.25/(log10(((e/D)/3.7)+(2.51/(R*sqrt(f1)))))^2;
    relativeError = abs(f2 - f1);
    if relativeError <= 0.000001
        check = 1;
    else
        f1 = f2;
    end
end

f = f1;

end
