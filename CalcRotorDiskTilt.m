function [k_alpha_Df_e] = CalcRotorDiskTilt(Velocity)

%Calculate Rotor Disk Tilt
Weight = 80*9.80665;            % 80kg RUAS * g
Area = 3.14159*(1.4^2);
Density = 1.225;                % Air at Sea Level
VelocityPmin = 18;              % For minimum power as per Jullien Lamothe's calculations
%Velocity = 18;                  % THIS is the velocity that can be modified (Flight Velocity)

% See Section 3.2.1 in RR No.MR3-03 Version B for more detail on these
% formulae.

k__alpha_Df_e = zeros(51,4);

for q=1:51
    k = 1.1 + (q-1)*0.001; % k between 1.10 and 1.15 typically. This value is just a guess. Currently looking into a better approximation method.
    
    f = k*Weight^2 / (3*Area*Density^2*VelocityPmin^4); % This is only valid for Vpmin
    
    FuselageDragForce = 0.5*Density*Velocity^2*f;
    AlphaTipPathPlane = FuselageDragForce/Weight;       % Output in Radians
    AlphaDegrees = AlphaTipPathPlane * 180 / 3.14159;    % Output in Degrees
    
    FuseDrag2 = (Weight/cos(AlphaTipPathPlane))*sin(AlphaTipPathPlane); % Determining the Fuselage Drag Equivalent for Forward Flight at this Thrust
    
    PError = abs(FuselageDragForce-FuseDrag2)/FuseDrag2;    % Error between estimated drag and forward thrust component
    
    k__alpha_Df_e (q,1) = k;
    k__alpha_Df_e (q,2) = AlphaDegrees;
    k__alpha_Df_e (q,3) = FuselageDragForce;
    k__alpha_Df_e (q,4) = PError*100;
end

% k__alpha_Df_e

end
