function [theta,lambda] = BEMT_Hover(sigma,theta0,thetatw,theta1c,theta1s,CT_req,lc,alpha0,Cla,e,N)
% Aerodynamic characteristics of a rotor blade using BEMT analysis  
 
dr= (1-e)/N;                 % Radial Incrememnt
lamda = zeros(N+1,360);
lambda = zeros(N+1,360);

phi = 1;
while (phi <= 360)
    thetainc = 1;
    while (thetainc < 20)
        if (thetainc == 1)
            theta = ( (6* CT_req)/(sigma*Cla) ) - theta0 - (3/4)*thetatw - theta1c*cos(phi*pi/180) - theta1s*sin(phi*pi/180) - alpha0 + ( (3/2)* sqrt(CT_req/2) );  %pitch0 first guess at twist0
        end
        count = 1;
        while (count <= N+1)
            if (count == 1)
                r(count) = e;
            else
                r(count) = r(count-1)+dr;
            end
    
            %%% Blade twist: Linear 
            twist(count) = (theta+theta0) + thetatw*r(count) + theta1c*cos(phi*pi/180) + theta1s*sin(phi*pi/180) - alpha0;
        
            %%%%Inflow Ratio  
            lamda(count,phi) = sqrt(( (sigma*Cla/16) - (lc/2) )^2+ sigma*Cla*twist(count)*r(count)/8) - ( (sigma*Cla/16)- (lc/2) );  

            % %%% Coefficient of Thrust
            dCT(count) =( (sigma*Cla/2)*(twist(count)*(r(count))^2 - lamda(count,1)*r(count)) )* dr;      %incremental thrust over span
            Cp(count) = lamda(count)*dCT(count);
        
            count = count+1;
        end
    
        CT = sum(dCT);      %total Thrust
        theta_prev = theta;
        theta = theta_prev + ( (6*(CT_req-CT))/(sigma*Cla) + ( (3*sqrt(2)/4)*(sqrt(CT_req)-sqrt(CT)) ) );
        thetainc = thetainc + 1;
    end
    phi = phi + 1;
end

theta = real(theta);
lambda = -real(lamda);

% subplot(2,3,1);
% plot(r,real(twist)*180/pi,'r'); 
% xlabel('x/R');
% ylabel('Twist- Degrees');
% title('Blade Twist Distribution');
% 
% subplot(2,3,2);
% %figure(2)
% plot(r,lambda,'r');
% xlabel('x/R');
% ylabel('Inflow ratio');
% title('Inflow Ratio Distribution');
% 
% subplot(2,3,3);
% %figure(4)
% plot(r, real(dCT)/dr);
% xlabel('x/R');
% ylabel( 'dCT / dr');
% title('Thrust Coefficient Distribution');
% % 
% %%% Induced AOA
% induce = lambda./r;
% subplot(2,3,4);
% %figure(3)
% plot(r,induce);
% xlabel('x/R');
% ylabel('Induced AOA (radians)');
% title('Induced Angle of Attack');
% % 
% % 
% % %%% Power Coefficient
% CP = sum (real(Cp));
% 
% subplot(2,3,5);
% %figure(6)
% plot(r,real(Cp));
% xlabel('x/R');
% ylabel('dCP / dr');
% title('Power Coefficient');
% 
% % % %%% Lift Coefficient
%  CL= Cla * ( real(twist) - (lambda./r) );
% subplot(2,3,6);
% %figure(7);
% plot(r,CL);
% xlabel('x/R');
% ylabel('dCL / dr');
% title('Lift Coefficient');

end