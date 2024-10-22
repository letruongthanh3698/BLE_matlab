close all

p_exp1=0.75;
p_exp2=1.0;
p_exp3=1.25;
p_exp4=1.75;
p_exp5=2.0;
p_exp6=2.25;
dis_static1=[];
dis_static2=[];
dis_static3=[];
dis_static4=[];
dis_static5=[];
dis_static6=[];
ref=[];
R1=-40;
p_exp59=-(pathloss59-R1)./(10*log10(6.37));
p_exp93=-(pathloss93-R1)./(10*log10(7.04));
p_expc2=-(pathlossc2-R1)./(10*log10(8.78));
p_expc0=-(pathlossc0-R1)./(10*log10(5.41));
for i=1:1:length(tag93)
    dis_static1(i)=10.^((R1-(tagc0(i)))./(10*p_exp1));
    dis_static2(i)=10.^((R1-(tagc0(i)))./(10*p_exp2));
    dis_static3(i)=10.^((R1-(tagc0(i)))./(10*p_exp3));
end
%T=table(datestr(time,'yyyy-mm-dd  HH:MM:SS'),dis_static1',dis_static2',dis_static3',dc0',refc0');
%writetable(T,'PathlossExponent.ver5.xlsx','Sheet','Sheet1','Range','V1')

figure('Name','Static Pathloss Exponent')
plot(time,dis_static1,'r',time,dis_static2,'g',time,dis_static3,'b',time,dc0,'k',time,refc0,'m')
legend({'Pathloss Exponent =0.75','Pathloss Exponent =1.0','Pathloss Exponent =1.25','Dynamic Pathloss Exponent','Reference'},'FontSize',11,'Location','northoutside');
set(gca,'xtick',[t_min:t_step:t_max]) 
datetick('x','yyyy-mm-dd  HH:MM','keepticks')
xlabel('Time')
ylabel('Distacne (m)')
ax = gca;
ax.XTickLabelRotation = 30;
grid on

figure('Name','Dynamic Pathloss Exponent')
plot(time,p_exp59,'r',time,p_exp93,'g',time,p_expc2,'b',time,p_expc0,'k')
legend({'Dynamic Pathloss Exponent TAG59','Dynamic Pathloss Exponent TAG93','Dynamic Pathloss Exponent TAGC2','Dynamic Pathloss Exponent TAGC0'},'FontSize',11,'Location','northoutside');
%legend({'Dynamic Pathloss Exponent'},'FontSize',11,'Location','northoutside');
set(gca,'xtick',[t_min:t_step:t_max]) 
datetick('x','yyyy-mm-dd  HH:MM','keepticks')
xlabel('Time')
ylabel('Pathloss Exponent')
ax = gca;
ax.XTickLabelRotation = 30;
grid on

%figure('Name','Static Pathloss Exponent Custom')
%plot(time,dis_static2,'r',time,dc2,'b')
%legend({'Pathloss Exponent = 3.5','Dynamic Pathloss Exponent'},'FontSize',11,'Location','northoutside');
%set(gca,'xtick',[t_min:t_step:t_max]) 
%datetick('x','yyyy-mm-dd  HH:MM','keepticks')
%xlabel('Time')
%ylabel('Pathloss Exponent')
%ax = gca;
%ax.XTickLabelRotation = 30;
%grid on