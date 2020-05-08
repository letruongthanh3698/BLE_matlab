clear all
close all
%dai
load('data_antenna_2020.04.23.20.02_dai.mat');
data_dai=[];
cnt_dai=[];
cnt=0;
for i=1:1:length(data)
    for j=1:1:5
        cnt=cnt+1;
        data_dai(cnt)=data(i).data.data.data1.value(j);
        cnt_dai(cnt)=cnt;
    end
end
%trung binh
load('data_antenna_2020.04.23.20.02_tb.mat');
data_tb=[];
cnt_tb=[];
cnt=0;
for i=1:1:length(data)
    for j=1:1:5
        cnt=cnt+1;
        data_tb(cnt)=data(i).data.data.data1.value(j);
        cnt_tb(cnt)=cnt;
    end
end

%ngan
load('data_antenna_2020.04.23.20.02_ngan.mat');
data_ngan=[];
cnt_ngan=[];
cnt=0;
for i=1:1:length(data)
    for j=1:1:5
        cnt=cnt+1;
        data_ngan(cnt)=data(i).data.data.data1.value(j);
        cnt_ngan(cnt)=cnt;
    end
end

figure('Name','Raw Data')
plot(cnt_dai,data_dai,'r',cnt_tb,data_tb,'g',cnt_ngan,data_ngan,'b');
legend({'Long','Medium','Short'},'FontSize',11,'Location','northoutside');
grid on

kal_dai=kalman(0.00075,0,0.00075,6,data_dai);
kal_tb=kalman(0.00075,0,0.00075,6,data_tb);
kal_ngan=kalman(0.00075,0,0.00075,6,data_ngan);

figure('Name','Kalman Data')
plot(cnt_dai,kal_dai,'r',cnt_tb,kal_tb,'g',cnt_ngan,kal_ngan,'b');
legend({'Long','Medium','Short'},'FontSize',11,'Location','northoutside');
grid on

