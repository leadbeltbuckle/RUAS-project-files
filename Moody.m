%create a vector with 100 logarithmically spaced values from 10^4 to 10^8
R = logspace (4, 8, 100);

%create values of e/D
e = 1;
D(1) = e/0.00001;
D(2) = e/0.0001;
D(3) = e/0.001;
D(4) = e/0.01;

%open Figure 1
%figure(j)


%evaluate all 4 values of e/D
for i = 1:4
    for j = 1:100
        
        %initial guess from given function
        f1 = 0.3164*R(j)^(-0.25);   
        
        %fixed point iteration (findFriction)
        %I was having trouble with the While Loop in this spot. It seemed to get stuck
        %in infinite loops all the time.. I used a for loop instead under the assumtion that
        %it would reach a reasonably small error after 500 iterations. The
        %results produced were reasonably smooth and consistent.
        for k = 1:500
            f2 = 0.25/(log10(((e/D(i))/3.7)+(2.51/(R(j)*sqrt(f1)))))^2;
            relativeError = abs(f2 - f1);
            if relativeError <= 0.000001
                break;
            else
                f1 = f2;
            end
            
        end
        
        f(j) = f1;
    end
    
    %plot the new line of f/R
    %hold on 
    %>>>> this doesn't seem to work to plot all four together.
    %It's probably just a syntax thing. However, each value of e/D seems to yeild good
    %results.
    figure(i)
    loglog (R,f);
end
