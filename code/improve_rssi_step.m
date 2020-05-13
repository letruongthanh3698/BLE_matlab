%% this file create for drawing step by step in improve rssi algorithm.
%% step 1: draw raw rssi
%% step 2: draw raw gateway rssi and it's mean
%% step 3: draw improve rssi of tag and pathloss without kalman
%% hint: run this file after run sv_raw

%2020.05.13 run on beacon C2
close all
step_gw=[];
for i=1:1:cnt_gw
    step_gw(i)=(i);
end

step_pl=[];
for i=1:1:cnt_pl
    step_pl(i)=(i);
end

step_tg=[];
for i=1:1:cnt_tg
    step_tg(i)=(i);
end

%step1:
figure('Name','C2')
plot(step_tg,tgc2,'r',step_pl,plc2,'b',step_gw,gwc2,'g')
legend({'TAG','PATHLOSS','GATEWAY'},'FontSize',11,'Location','northoutside');
grid on
T=table(step_gw',gwc2');
T.Properties.VariableNames={'Step_Gateway';'Gateway'};
writetable(T,'improve_rssi.xlsx','Sheet','Sheet1','Range','A2')

T=table(step_tg',tgc2');
T.Properties.VariableNames={'Step_Tag';'Tag'};
writetable(T,'improve_rssi.xlsx','Sheet','Sheet1','Range','C2')

T=table(step_pl',plc2');
T.Properties.VariableNames={'Step_Pathloss';'Pathloss'};
writetable(T,'improve_rssi.xlsx','Sheet','Sheet1','Range','E2')

%step2:
R_mean=[];
R_sum=0;
for i=1:1:cnt_gw
    R_sum=R_sum+gwc2(i);
    R_mean(i)=R_sum/i;
end

figure('Name','Gateway Mean')
plot(step_gw,gwc2,'b',step_gw,R_mean,'r');
legend({'RAW RSSI';'MEAN RSSI'},'FontSize',11,'Location','northoutside');
grid on
T=table(step_gw',gwc2',R_mean');
T.Properties.VariableNames={'Step_Gateway';'Raw';'Mean'};
writetable(T,'improve_rssi.xlsx','Sheet','Sheet1','Range','H2')

%step3:
%run file server.m to process step3; changw withkalman=0