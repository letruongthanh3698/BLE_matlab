close all
s = get(0, 'ScreenSize');
time_pause=0.00001;
save=0; %choose to save or not

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
save_fig(name,save);


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
save_fig(name,save);

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
save_fig(name,save);

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
save_fig(name,save);

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
save_fig(name,save);

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
save_fig(name,save);

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
save_fig(name,save);

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
save_fig(name,save);

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
save_fig(name,save);

%slider(length(count),point,radius,loc,time);

%figure('Name','Distance')
%plot(count, dis2,'y',count, dis2_kal,'r')
%grid on