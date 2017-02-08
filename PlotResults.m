clear all

load artic_data.dat
load DLRTPL.DAT

NTIMER = length(DLRTPL);
omega = 164.8;
T_period = 2*pi/omega;
dt = 0.602e-3;

time = artic_data(:,1)*dt;
time = time/T_period;

figure(1), subplot(3,1,1), plot(time, artic_data(:,2)), grid on, zoom on, hold on
ylabel('PITCH ANGLE (DEG)')
title('ARTICULATION FEEDBACK --- BO105 DESCENT, NO WAKE','FontSize',16)
figure(1), subplot(3,1,2), plot(time, artic_data(:,3)), grid on, zoom on, hold on
ylabel('FLAP ANGLE (DEG)')
figure(1), subplot(3,1,3), plot(time, artic_data(:,4)), grid on, zoom on, hold on
ylabel('LAG ANGLE (DEG)')
xlabel('NOMALIZED TIME [REVOLUTION] ')

load tipdis.dat


figure(2), subplot(3,1,1), plot(time, tipdis(2:NTIMER+1,1)), grid on, zoom on, hold on
ylabel('TIP DISP - a1 - (m)')
title('TIP DISPLACEMENTS --- BO105 DESCENT','FontSize',16)
figure(2), subplot(3,1,2), plot(time, tipdis(2:NTIMER+1,2)), grid on, zoom on, hold on
ylabel('TIP DISP - a2 - (m)')
figure(2), subplot(3,1,3), plot(time, tipdis(2:NTIMER+1,3)), grid on, zoom on, hold on
ylabel('TIP DISP - a3 - (m))')
xlabel('NOMALIZED TIME [REVOLUTION] ')

load tiprot.dat

figure(3), subplot(3,1,1), plot(time, tiprot(2:NTIMER+1,1)), grid on, zoom on, hold on
ylabel('TIP ROT - a1 - (DEG)')
title('TIP ROTATIONS --- BO105 DESCENT','FontSize',16)
figure(3), subplot(3,1,2), plot(time, tiprot(2:NTIMER+1,2)), grid on, zoom on, hold on
ylabel('TIP ROT - a2 - (DEG)')
figure(3), subplot(3,1,3), plot(time, tiprot(2:NTIMER+1,3)), grid on, zoom on, hold on
ylabel('TIP ROT - a3 - (DEG)')
xlabel('NOMALIZED TIME [REVOLUTION] ')


load elbc.dat

figure(4), subplot(3,1,1), plot(time(2:NTIMER), elbc(:,3),time(2:NTIMER), elbc(:,2)/(4*pi),'b-.'), grid on, zoom on, hold on
ylabel('ELBC V_n ROOT (m/s)')
title('ELASTIC NORMAL VELOCITY --- BO105 DESCENT, NO WAKE','FontSize',16)
figure(4), subplot(3,1,2), plot(time(2:NTIMER), elbc(:,5),time(2:NTIMER), elbc(:,4)/(4*pi),'b-.'), grid on, zoom on, hold on
ylabel('ELBC V_n MID (m/s)')
figure(4), subplot(3,1,3), plot(time(2:NTIMER), elbc(:,7),time(2:NTIMER), elbc(:,6)/(4*pi),'b-.'), grid on, zoom on, hold on
ylabel('ELBC V_n TIP (m/s)')
xlabel('NOMALIZED TIME [REVOLUTION] ')



figure(5), subplot(3,1,1), plot(time, DLRTPL(:,2)), grid on, zoom on, hold on
ylabel('TOTAL AERO LOAD - X1G (N)')
title('TOTAL AERODYNAMIC LOADING ON BLADE --- BO105 DESCENT, NO WAKE','FontSize',16)
figure(5), subplot(3,1,2), plot(time, DLRTPL(:,3)), grid on, zoom on, hold on
ylabel('TOTAL AERO LOAD - X2G (N)')
figure(5), subplot(3,1,3), plot(time, DLRTPL(:,4)), grid on, zoom on, hold on
ylabel('TOTAL AERO LOAD - X3G (N))')
xlabel('NOMALIZED TIME [REVOLUTION]  ')


cd ../BO_105_FINAL.49

clear all

firstcase = 'BO_105_FINAL.52 - AERO DAMP,TILT CORRECTION';
case39 = 'BO_105_FINAL.49 - AERO DAMP, NO TILT ANGLE';

load artic_data.dat
load DLRTPL.DAT

NTIMER = length(DLRTPL);
omega = 164.8;
T_period = 2*pi/omega;
dt = 0.602e-3;

time = artic_data(:,1)*dt;
time = time/T_period;

figure(1), subplot(3,1,1), plot(time, artic_data(:,2),'r--'), grid on, zoom on, hold off
ylabel('PITCH ANGLE (DEG)')
title('ARTICULATION FEEDBACK --- BO105 DESCENT, NO WAKE','FontSize',16)
figure(1), subplot(3,1,2), plot(time, artic_data(:,3),'r--'), grid on, zoom on, hold off
ylabel('FLAP ANGLE (DEG)')
figure(1), subplot(3,1,3), plot(time, artic_data(:,4),'r--'), grid on, zoom on, hold off
ylabel('LAG ANGLE (DEG)')
xlabel('NOMALIZED TIME [REVOLUTION] ')

legend(firstcase,case39,0)

load tipdis.dat


figure(2), subplot(3,1,1), plot(time, tipdis(2:NTIMER+1,1),'r--'), grid on, zoom on, hold off
ylabel('TIP DISP - a1 - (m)')
title('TIP DISPLACEMENTS --- BO105 DESCENT','FontSize',16)
figure(2), subplot(3,1,2), plot(time, tipdis(2:NTIMER+1,2),'r--'), grid on, zoom on, hold off
ylabel('TIP DISP - a2 - (m)')
figure(2), subplot(3,1,3), plot(time, tipdis(2:NTIMER+1,3),'r--'), grid on, zoom on, hold off
ylabel('TIP DISP - a3 - (m))')
xlabel('NOMALIZED TIME [REVOLUTION] ')
legend(firstcase,case39,0)

load tiprot.dat

figure(3), subplot(3,1,1), plot(time, tiprot(2:NTIMER+1,1),'r--'), grid on, zoom on, hold off
ylabel('TIP ROT - a1 - (DEG)')
title('TIP ROTATIONS --- BO105 DESCENT','FontSize',16)
figure(3), subplot(3,1,2), plot(time, tiprot(2:NTIMER+1,2),'r--'), grid on, zoom on, hold off
ylabel('TIP ROT - a2 - (DEG)')
figure(3), subplot(3,1,3), plot(time, tiprot(2:NTIMER+1,3),'r--'), grid on, zoom on, hold off
ylabel('TIP ROT - a3 - (DEG)')
xlabel('NOMALIZED TIME [REVOLUTION] ')
legend(firstcase,case39,0)


load elbc.dat

figure(4), subplot(3,1,1), plot(time(2:NTIMER), elbc(:,3),'r--',time(2:NTIMER), elbc(:,2)/(4*pi),'r-.'), grid on, zoom on, hold off
ylabel('ELBC V_n ROOT (m/s)')
title('ELASTIC NORMAL VELOCITY --- BO105 DESCENT, NO WAKE','FontSize',16)
figure(4), subplot(3,1,2), plot(time(2:NTIMER), elbc(:,5),'r--',time(2:NTIMER), elbc(:,4)/(4*pi),'r-.'), grid on, zoom on, hold off
ylabel('ELBC V_n MID (m/s)')
figure(4), subplot(3,1,3), plot(time(2:NTIMER), elbc(:,7),'r--',time(2:NTIMER), elbc(:,6)/(4*pi),'r-.'), grid on, zoom on, hold off
ylabel('ELBC V_n TIP (m/s)')
xlabel('NOMALIZED TIME [REVOLUTION] ')
legend(firstcase,case39,0)


figure(5), subplot(3,1,1), plot(time, DLRTPL(:,2),'r--'), grid on, zoom on, hold off
ylabel('TOTAL AERO LOAD - X1G (N)')
title('TOTAL AERODYNAMIC LOADING ON BLADE --- BO105 DESCENT, NO WAKE','FontSize',16)
figure(5), subplot(3,1,2), plot(time, DLRTPL(:,3),'r--'), grid on, zoom on, hold off
ylabel('TOTAL AERO LOAD - X2G (N)')
figure(5), subplot(3,1,3), plot(time, DLRTPL(:,4),'r--'), grid on, zoom on, hold off
ylabel('TOTAL AERO LOAD - X3G (N))')
xlabel('NOMALIZED TIME [REVOLUTION]  ')
legend(firstcase,case39,0)

cd ../BO_105_FINAL.52