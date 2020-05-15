close all
s = get(0, 'ScreenSize');
time_pause=0.00001;
saving=0; %choose to saving or not

figure('Name','59','Position', [0 0 s(3) s(4)]);
sp=subplot(1,1,1);
plot(time,tag59,'r',time,pathloss59,'b',time,gateway59,'g')
legend({'TAG','PATHLOSS','GATEWAY'},'FontSize',11,'Location','northoutside');
set(gca,'xtick',[t_min:t_step:t_max])
set(gca,'ytick',[-65:5:-45])
ylim([-65 -45])
draw_daynight(time_point,time_value,time,sp);
datetick('x','yyyy-mm-dd ddd HH:MM ','keepticks')
xlabel('Time')
ylabel('RSSI (dBm)')
ax = gca;
ax.XTickLabelRotation = 30;
pause(time_pause);
name='R59';
saving_fig(name,saving);
if saving==1
    T=table(datestr(time,'yyyy-mm-dd ddd HH:MM:SS'),tag59,pathloss59,gateway59);
    T.Properties.VariableNames={'Time_Tag';'Tag';'Pathloss';'Gateway'};
    writetable(T,'no_adjust.xlsx','Sheet','Sheet1','Range','A2')
end


figure('Name','59 Delta','Position', [0 0 s(3) s(4)]);
sp=subplot(2,1,1);
plot(t_,d59,'r',time,ref59,'b');
set(gca,'xtick',[t_min:t_step:t_max])
ylim([0 10])
draw_daynight(time_point,time_value,time,sp);
datetick('x','yyyy-mm-dd ddd HH:MM ','keepticks')
xlabel('Time')
ylabel('Distance (m)')
ax = gca;
ax.XTickLabelRotation = 30;
sp=subplot(2,1,2);
plot(t_,del59);
set(gca,'xtick',[t_min:t_step:t_max]) 
ylim([0 10])
draw_daynight(time_point,time_value,time,sp);
datetick('x','yyyy-mm-dd ddd HH:MM ','keepticks')
xlabel('Time')
ylabel('Error (m)')
ax = gca;
ax.XTickLabelRotation = 30;
pause(time_pause);
name='Delta59';
saving_fig(name,saving);
if saving==1
    T=table(datestr(time,'yyyy-mm-dd ddd HH:MM:SS'),d59',ref59',del59');
    T.Properties.VariableNames={'Time';'Distance';'Reference';'Error'};
    writetable(T,'no_adjust.xlsx','Sheet','Sheet1','Range','F2')
end

figure('Name','93','Position', [0 0 s(3) s(4)]);
sp=subplot(1,1,1);
plot(time,tag93,'r',time,pathloss93,'b',time,gateway93,'g')
legend({'TAG','PATHLOSS','GATEWAY'},'FontSize',11,'Location','northoutside');
set(gca,'xtick',[t_min:t_step:t_max]) 
set(gca,'ytick',[-65:5:-45])
ylim([-65 -45])
draw_daynight(time_point,time_value,time,sp);
datetick('x','yyyy-mm-dd ddd HH:MM ','keepticks')
xlabel('Time')
ylabel('RSSI (dBm)')
ax = gca;
ax.XTickLabelRotation = 30;
pause(time_pause);
name='R93';
saving_fig(name,saving);
if saving==1
    T=table(datestr(time,'yyyy-mm-dd ddd HH:MM:SS'),tag93,pathloss93,gateway93);
    T.Properties.VariableNames={'Time_Tag';'Tag';'Pathloss';'Gateway'};
    writetable(T,'no_adjust.xlsx','Sheet','Sheet1','Range','K2')
end

figure('Name','93 Delta','Position', [0 0 s(3) s(4)]);
sp=subplot(2,1,1);
plot(t_,d93,'r',time,ref93,'b');
set(gca,'xtick',[t_min:t_step:t_max]) 
ylim([0 10])
draw_daynight(time_point,time_value,time,sp);
datetick('x','yyyy-mm-dd ddd HH:MM ','keepticks')
xlabel('Time')
ylabel('Distance (m)')
ax = gca;
ax.XTickLabelRotation = 30;
sp=subplot(2,1,2);
plot(t_,del93);
set(gca,'xtick',[t_min:t_step:t_max]) 
ylim([0 10])
draw_daynight(time_point,time_value,time,sp);
datetick('x','yyyy-mm-dd ddd HH:MM ','keepticks')
xlabel('Time')
ylabel('Error (m)')
ax = gca;
ax.XTickLabelRotation = 30;
pause(time_pause);
name='Delta93';
saving_fig(name,saving);
if saving==1
    T=table(datestr(time,'yyyy-mm-dd ddd HH:MM:SS'),d93',ref93',del93');
    T.Properties.VariableNames={'Time';'Distance';'Reference';'Error'};
    writetable(T,'no_adjust.xlsx','Sheet','Sheet1','Range','P2')
end

figure('Name','C2','Position', [0 0 s(3) s(4)]);
sp=subplot(1,1,1);
plot(time,tagc2,'r',time,pathlossc2,'b',time,gatewayc2,'g')
legend({'TAG','PATHLOSS','GATEWAY'},'FontSize',11,'Location','northoutside');
set(gca,'xtick',[t_min:t_step:t_max]) 
set(gca,'ytick',[-65:5:-45])
ylim([-65 -45])
draw_daynight(time_point,time_value,time,sp);
datetick('x','yyyy-mm-dd ddd HH:MM ','keepticks')
xlabel('Time')
ylabel('RSSI (dBm)')
ax = gca;
ax.XTickLabelRotation = 30;
pause(time_pause);
name='RC2';
saving_fig(name,saving);
if saving==1
    T=table(datestr(time,'yyyy-mm-dd ddd HH:MM:SS'),tagc2,pathlossc2,gatewayc2);
    T.Properties.VariableNames={'Time_Tag';'Tag';'Pathloss';'Gateway'};
    writetable(T,'no_adjust.xlsx','Sheet','Sheet1','Range','U2')
end

figure('Name','C2 Delta','Position', [0 0 s(3) s(4)]);
sp=subplot(2,1,1);
plot(t_,dc2,'r',time,refc2,'b');
set(gca,'xtick',[t_min:t_step:t_max]) 
ylim([0 10])
draw_daynight(time_point,time_value,time,sp);
datetick('x','yyyy-mm-dd ddd HH:MM ','keepticks')
xlabel('Time')
ylabel('Distance (m)')
ax = gca;
ax.XTickLabelRotation = 30;
sp=subplot(2,1,2);
plot(t_,delc2);
set(gca,'xtick',[t_min:t_step:t_max]) 
ylim([0 10])
draw_daynight(time_point,time_value,time,sp);
datetick('x','yyyy-mm-dd ddd HH:MM ','keepticks')
xlabel('Time')
ylabel('Error (m)')
ax = gca;
ax.XTickLabelRotation = 30;
pause(time_pause);
name='DeltaC2';
saving_fig(name,saving);
if saving==1
    T=table(datestr(time,'yyyy-mm-dd ddd HH:MM:SS'),dc2',refc2',delc2');
    T.Properties.VariableNames={'Time';'Distance';'Reference';'Error'};
    writetable(T,'no_adjust.xlsx','Sheet','Sheet1','Range','AA2')
end

figure('Name','C0','Position', [0 0 s(3) s(4)]);
sp=subplot(1,1,1);
plot(time,tagc0,'r',time,pathlossc0,'b',time,gatewayc0,'g')
legend({'TAG','PATHLOSS','GATEWAY'},'FontSize',11,'Location','northoutside');
set(gca,'xtick',[t_min:t_step:t_max]) 
set(gca,'ytick',[-65:5:-45])
ylim([-65 -45])
draw_daynight(time_point,time_value,time,sp);
datetick('x','yyyy-mm-dd ddd HH:MM ','keepticks')
xlabel('Time')
ylabel('RSSI (dBm)')
ax = gca;
ax.XTickLabelRotation = 30;
pause(time_pause);
name='RC0';
saving_fig(name,saving);
if saving==1
    T=table(datestr(time,'yyyy-mm-dd ddd HH:MM:SS'),tagc0,pathlossc0,gatewayc0);
    T.Properties.VariableNames={'Time_Tag';'Tag';'Pathloss';'Gateway'};
    writetable(T,'no_adjust.xlsx','Sheet','Sheet1','Range','AF2')
end

figure('Name','C0 Delta','Position', [0 0 s(3) s(4)]);
sp=subplot(2,1,1);
plot(t_,dc0,'r',time,refc0,'b');
set(gca,'xtick',[t_min:t_step:t_max]) 
ylim([0 10])
draw_daynight(time_point,time_value,time,sp);
datetick('x','yyyy-mm-dd ddd HH:MM ','keepticks')
xlabel('Time')
ylabel('Distance (m)')
ax = gca;
ax.XTickLabelRotation = 30;
sp=subplot(2,1,2);
plot(t_,delc0);
set(gca,'xtick',[t_min:t_step:t_max]) 
ylim([0 10])
draw_daynight(time_point,time_value,time,sp);
datetick('x','yyyy-mm-dd ddd HH:MM ','keepticks')
xlabel('Time')
ylabel('Error (m)')
ax = gca;
ax.XTickLabelRotation = 30;
pause(time_pause);
name='DeltaC0';
saving_fig(name,saving);
if saving==1
    T=table(datestr(time,'yyyy-mm-dd ddd HH:MM:SS'),dc0',refc0',delc0');
    T.Properties.VariableNames={'Time';'Distance';'Reference';'Error'};
    writetable(T,'no_adjust.xlsx','Sheet','Sheet1','Range','AK2')
end

figure('Name','ERROR','Position', [0 0 s(3) s(4)]);
sp=subplot(1,1,1);
plot(time,err);
set(gca,'xtick',[t_min:t_step:t_max]) 
draw_daynight(time_point,time_value,time,sp);
datetick('x','yyyy-mm-dd ddd HH:MM ','keepticks')
xlabel('Time')
ylabel('Error (m)')
ax = gca;
ax.XTickLabelRotation = 30;
pause(time_pause);
name='ERROR';
saving_fig(name,saving);
if saving==1
    T=table(datestr(time,'yyyy-mm-dd ddd HH:MM:SS'),err);
    T.Properties.VariableNames={'Time';'ERROR_LOCATION'};
    writetable(T,'no_adjust.xlsx','Sheet','Sheet1','Range','AP2')
end
%slider(length(count),point,radius,loc,time);

%figure('Name','Distance')
%plot(count, dis2,'y',count, dis2_kal,'r')
%grid on