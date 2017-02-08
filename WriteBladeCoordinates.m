function WriteBladeOne( twistRate, AoARoot, Cmain, xDistr, yDistrBlade, yDistrTip, tipSweep, tipTaperRatio, tipAnhedral)
%WriteBladeOne
%   This function writes the (x,y,z) coordinates for a uniformly-twisted,
%   constant chord rotor blade
%
%   twistRate defines the angle of twist in degrees per metre along the rotor span
%   AoARoot is the angle of attack in degrees at the root of the rotor blade
%   Cmain is the chord of the rotor blade in metres
%   xDistr is the non-dimensional node distribution along the chord line
%       example: x=[0 0.25 0.5 0.75 1]
%   yDistrBlade is the dimensional node distribution in metres along the
%   rotor span excluding the tip
%       example: y=[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 1.1 1.2]
%   yDistrTip is the dimensional node distribution in metres of the blade
%   tip. The first value of this vector should be the same as the last
%   value of yDistrBlade
%   tipSweep is the quarter chord sweep angle (aft) of the blade tip in
%   degrees
%   tipTaperRatio is the taper ratio of the blade tip as a decimal
%   tipAnhedral is the anhedral angle of the tip in degrees
%       -positive angles will point the tip downward

NumBladeSpanLocs = length(yDistrBlade);
NumChordLocs = length (xDistr);
NumTipSpanLocs = length (yDistrTip);

xRotorCenter = 0.5*Cmain*cosd(AoARoot);    %Aligns the blade chord center on negative x-axis
zRotorCenter = 0.5*Cmain*sind(AoARoot);    %Aligns the blade chord center on negative x-axis

for n = 1:NumBladeSpanLocs
    
    alpha = AoARoot + (twistRate*yDistrBlade(n));                
    xChordStart = xRotorCenter - 0.5*Cmain*cosd(alpha);     %Defines first x-coordinate for this span location
    zChordStart = zRotorCenter - 0.5*Cmain*sind(alpha);     %Defines first z-coordinate for this span location
    
    for m = 1:NumChordLocs
        
        x(n,m) = (xChordStart + Cmain*xDistr(m)*cosd(alpha));    %Determine x-coordinate --- negative to mirror about x-axis
        y(n,m) = yDistrBlade(n);                               %Determine y-coordinate
        z(n,m) = zChordStart + Cmain*xDistr(m)*sind(alpha);    %Determine z-coordinate
        A=[x(n,m) y(n,m) z(n,m)];                              %Store coordinates into vector A
        
        disp(A)                                                %Display the contents of vector A
        
             
    end
    
    disp(' ')
    
end

tipLength = yDistrTip(NumTipSpanLocs)-yDistrTip(1);     %physical tip length
tipVectLength = length(yDistrTip);                      %length of vector needed to represent the span locations of the tip      

for n = 1:tipVectLength
    cTipDistr(n) = Cmain + (Cmain*((1/tipTaperRatio)-1)*(yDistrTip(n)-yDistrTip(1))/tipLength);  %vector of chord lengths to account for taper ratio
end

xTipCenter(1) = xRotorCenter;
zTipCenter(1) = zRotorCenter;
xTempCenter = xTipCenter(1);
zTempCenter = zTipCenter(1);

for n = 1:(tipVectLength-1)
    alpha1 = AoARoot + (twistRate*yDistrTip(n));
    alpha2 = AoARoot + (twistRate*yDistrTip(n+1)); 
    xTipCenter(n+1) = xTempCenter - (0.25*(cTipDistr(n)*cosd(alpha1) - cTipDistr(n+1)*cosd(alpha2)) - (yDistrTip(n+1)-yDistrTip(n))*tand(tipSweep));
    %adjusts center x coordinate of the tip by accounting for sweep and
    %taper
    zTipCenter(n+1) = zTempCenter - (yDistrTip(n+1)-yDistrTip(n))*tand(tipAnhedral);
    %adjusts center z coordinate of the tip by accounting for anhedral
    xTempCenter = xTipCenter(n+1);
    zTempCenter = zTipCenter(n+1);
    %temp center change every loop to create a new datum to work from while
    %determining the TipCenter vectors
end

for n = 2:NumTipSpanLocs
    alpha = AoARoot + (twistRate*yDistrTip(n));           
    xChordStart = xTipCenter(n) - 0.5*cTipDistr(n)*cosd(alpha);      %Defines first x-coordinate for this span location
    zChordStart = zTipCenter(n) - 0.5*cTipDistr(n)*sind(alpha);      %Defines first z-coordinate for this span location
    
    for m = 1:NumChordLocs
        
        x((n+NumBladeSpanLocs),m) = (xChordStart + cTipDistr(n)*xDistr(m)*cosd(alpha));     %Determine x-coordinate --- negative to mirror about x-axis
        y((n+NumBladeSpanLocs),m) = yDistrTip(n);                                           %Determine y-coordinate
        z((n+NumBladeSpanLocs),m) = zChordStart + cTipDistr(n)*xDistr(m)*sind(alpha);       %Determine z-coordinate
        A=[x((n+NumBladeSpanLocs),m) y((n+NumBladeSpanLocs),m) z((n+NumBladeSpanLocs),m)];  %Store coordinates into vector A
        
        disp(A)     %Display the contents of vector A
        
             
    end
    
    disp(' ')
    
end
%The code below is for visualization only. This will not be included in the
%Blade.One file.

plot3(x,y,z,'+r')
axis ([-0.05 0.2 0 1.2 -0.05 0.05])
xlabel('X(m)')
ylabel('Y(m)')
zlabel('Z(m)')
grid on

%plot(x,y,'+r')
%axis ([-0.08 0.003 0 1.4])
%xlabel('X(m)')
%ylabel('Y(m)')
%grid on

end


