p_exp1=1.75;
p_exp2=2;
p_exp3=2.25;
dis_static1=[];
dis_static2=[];
dis_static3=[];
R1=-40;
p_exp=-(pathloss93-R1)./(10*log10(5.95));
for i=1:1:length(tag93)
    dis_static1(i)=10.^((R1-(tag93(i)))./(10*p_exp1));
    dis_static2(i)=10.^((R1-(tag93(i)))./(10*p_exp2));
    dis_static3(i)=10.^((R1-(tag93(i)))./(10*p_exp3));
end

figure('Name','Static Pathloss Exponent')
plot(time,dis_static1,'r',time,dis_static2,'g',time,dis_static3,'b',time,d93,'k')
legend({'Pathloss Exponent =1.75','Pathloss Exponent =2.00','Pathloss Exponent =2.25','Dynamic Pathloss Exponent'},'FontSize',11,'Location','northoutside');
set(gca,'xtick',[t_min:t_step:t_max]) 
datetick('x','yyyy-mm-dd  HH:MM','keepticks')
xlabel('Time')
ylabel('Distacne (m)')
ax = gca;
ax.XTickLabelRotation = 30;
grid on

figure('Name','Dynamic Pathloss Exponent')
plot(time,p_exp)
legend({'Dynamic Pathloss Exponent'},'FontSize',11,'Location','northoutside');
set(gca,'xtick',[t_min:t_step:t_max]) 
datetick('x','yyyy-mm-dd  HH:MM','keepticks')
xlabel('Time')
ylabel('Pathloss Exponent')
ax = gca;
ax.XTickLabelRotation = 30;
grid on