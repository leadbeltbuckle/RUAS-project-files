function [leadlagmatrix,leadlagsoln] = LeadLagNumericalCalculator(Bnum,ra,R,e,w,Drag,MCFll,MIll,MCorll,Ba,N,leadlagmatrix,leadlagsoln)
    %Calculator of leadlag angle numerically

    dr = (R-e*R)/N;

    MDrag = 0;
    count = 1;
    while (count <= N)
        MDrag = MDrag + (ra(count)-e*R)*Drag(count);
        count = count + 1;
    end

    %Flapping derivative calculation
    if (Bnum == 1)
        dBdphi = (Ba(2) - Ba(360))/(2*pi/180);
    elseif (Bnum == 360)
        dBdphi = (Ba(1) - Ba(359))/(2*pi/180);
    else
        dBdphi = (Ba(Bnum+1) - Ba(Bnum-1))/(2*pi/180);
    end

    %Coriolis calculation
    MCorll = MCorll*w*Ba(Bnum)*dBdphi;

    %Refer to Ross' notes
    %a corresponds to coefficient of LL(n-1)
    %b corresponds to coefficient of LL(n)
    %c corresponds to coefficient of LL(n+1)
    a = MIll*w^2;
    b = MCFll*(pi/180)^2 - 2*MIll*w^2;
    c = MIll*w^2;

    %leadlagmatrix will have the following structure
    % [b c 0 0 0 0 ... a 0 0]
    % [a b c 0 0 0 ... 0 0 0]
    % [0 a b c 0 0 ... 0 0 0]
    % [0 0 a b c 0 ... 0 0 0]
    % . . . . . . . . . . . .
    % [0 0 0 0 0 0 ... a b c]
    % [c 0 0 0 0 0 ... 0 a b]

    if (Bnum == 1)
        leadlagmatrix(1,1) = b;
        leadlagmatrix(1,2) = c;
        leadlagmatrix(1,360) = a;
    elseif (Bnum == 360)
        leadlagmatrix(360,359) = a;
        leadlagmatrix(360,360) = b;
        leadlagmatrix(360,1) = c;
    else
        leadlagmatrix(Bnum,Bnum-1) = a;
        leadlagmatrix(Bnum,Bnum) = b;
        leadlagmatrix(Bnum,Bnum+1) = c;
    end

    leadlagsoln(Bnum) = (MDrag - MCorll)*(pi/180)^2;
end