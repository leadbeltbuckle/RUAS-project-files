clear;
fName = 'RossCon.mcr';         %# A file name
fid = fopen(fName,'w');         %# Open the file
off = 720-180;                  %# Number of time steps
if fid ~= -1
    fprintf(fid,'%s\r\n','#!MC 1300');
    fprintf(fid,'%s\r\n','# Created by Tecplot 360 build 13.1.0.15185');
    fprintf(fid,'%s\r\n','$!VarSet |MFBD| = ''C:\Users\John\Documents\GENUVP Simulations''');
    fprintf(fid,'%s\r\n','$!EXPORTSETUP EXPORTFORMAT = AVI');
    fprintf(fid,'%s\r\n','$!EXPORTSETUP IMAGEWIDTH = 842');
    fprintf(fid,'%s\r\n','$!EXPORTSETUP EXPORTFNAME = ''C:\Users\John\Desktop\RossCon.avi''');
    fprintf(fid,'%s\r\n','$!EXPORTSTART');
    fprintf(fid,'%s\r\n','  EXPORTREGION = CURRENTFRAME');
    for K=1:off-1
        fprintf(fid,'%s\r\n',['$!ACTIVEFIELDMAPS -= [' num2str(K) ']']); %# Disable Geo Zone
        fprintf(fid,'%s\r\n',['$!ACTIVEFIELDMAPS += [' num2str(K+1) ']']); %# Enable next Geo Zone
        fprintf(fid,'%s\r\n',['$!ACTIVEFIELDMAPS -= [' num2str(K+off) ']']); %# Disable Geo Zone
        fprintf(fid,'%s\r\n',['$!ACTIVEFIELDMAPS += [' num2str(K+1+off) ']']); %# Enable next Geo Zone
        fprintf(fid,'%s\r\n','$!REDRAW'); %# Redraw
        fprintf(fid,'%s\r\n','$!EXPORTNEXTFRAME'); %#Export
    end
    fprintf(fid,'%s\r\n','$!EXPORTFINISH');
    fprintf(fid,'%s\r\n','$!RemoveVar |MFBD|');
end
fclose(fid);                     %# Close the file
