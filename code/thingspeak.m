% Template MATLAB code for visualizing data from a channel as a 2D line
% plot using PLOT function.

% Prior to running this MATLAB code template, assign the channel variables.
% Set 'readChannelID' to the channel ID of the channel to read from. 
% Also, assign the read field ID to 'fieldID1'. 

% TODO - Replace the [] with channel ID to read data from:
readChannelID1 = [929512];
readChannelID2 = [926199];
readChannelID3 = [926910];
% TODO - Replace the [] with the Field ID to read data from:
fieldID1 = [1];

% Channel Read API Key 
% If your channel is private, then enter the read API
% Key between the '' below: 
readAPIKey1 = '31RQUZ2HW4XO71P4';
readAPIKey2 = 'IRAPFQ4IA84DVYVA';
readAPIKey3 = '0ZLEW80JAHSTGH74';

%% Read Data %%

[gateway, time1] = thingSpeakRead(readChannelID1, 'Field', fieldID1, 'NumPoints', 500, 'ReadKey', readAPIKey1);
[tag, time2] = thingSpeakRead(readChannelID2, 'Field', fieldID1, 'NumPoints', 500, 'ReadKey', readAPIKey2);
[pathloss, time3] = thingSpeakRead(readChannelID3, 'Field', fieldID1, 'NumPoints', 500, 'ReadKey', readAPIKey3);


R_mean=0;
R_tag_kal=0;
R_pathloss_kal=0;

Q=0.005;
R=10;

P_tag=Q;
K_tag=0;
last_est_tag=0;

P_path=Q;
K_path=0;
last_est_path=0;

%Kal_tag=KMF;
%Kal_pathloss=KMF;

R_tag_kal=[];
R_pathloss_kal=[];
R_mean_=[];
x=[];
cnt=1;

for i=1:1:min([length(gateway),length(tag),length(pathloss)])
    if i==1
        R_mean=gateway(i);
        R_tag_kal(cnt)=tag(i);
        R_pathloss_kal(cnt)=pathloss(i);
        last_est_tag=tag(i);
        last_est_path=pathloss(i);
    else
        R_mean=R_mean+gateway(i);
        
        R_tag_correct=tag(i)-(gateway(i)-R_mean/cnt);
        [P_tag,K_tag,last_est_tag]=estimate(R_tag_correct,P_tag,K_tag,Q,R,last_est_tag);
        R_tag_kal(cnt)=last_est_tag;
        
        R_pathloss_correct=pathloss(i)-(gateway(i)-R_mean/cnt);
        [P_path,K_path,last_est_path]=estimate(R_pathloss_correct,P_path,K_path,Q,R,last_est_path);
        R_pathloss_kal(cnt)=last_est_path;
    end
    x(cnt)=(cnt-1)*5;
    R_mean_(cnt)=R_mean/cnt;
    cnt=cnt+1;
    
end

pathloss=-(R_pathloss_kal+59)./(10*log10(4.38));
distance=10.^((-59-R_tag_kal)./(10*pathloss));

figure(1)
plot(x,R_tag_kal,'r',x,R_pathloss_kal,'b');

legend({'TAG','PATHLOSS'})

figure(2);
plot(x,distance,'r');
grid on

figure(3);
plot(x,R_mean_,'r');
grid on