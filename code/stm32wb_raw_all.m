close all
clear all

%url = 'http://178.128.97.64:8080/stmtest/getall';
%options = weboptions('RequestMethod','get','Timeout',6000);
%data = webread(url,options);
load('data_stm32wb_17_3_15_19.mat')

gateway_last=[0 0 0 0 0];
gateway_count=[0 0 0 0 0];
gateway_sum=[0 0 0 0 0];
gateway_mean=[0 0 0 0 0];
gw=[];
gw_mean=[];
cnt_gw=0;
count_gw=[];
gw_kal=[];
gw_kal_last=0;

tag_kal=[];
tag_kal_last=0;
tag=[];
cnt_tag=0;
count_tag=[];

pathloss_kal=[];
pathloss_kal_last=0;
pathloss=[];
cnt_pathloss=0;
count_pathloss=[];

P=0.00075;
K=0;
Q=0.00075;
R=6;

gw_store=[];
tag_store=[];
pathloss_store=[];
count_store=[];
cnt_store=0;

cnt=0;

for i=1:1:length(data)
    if strcmp(data(i).data.name,'gateway_wb')
        sum=0;
        for j=1:1:5
            cnt=cnt+1;
            cnt_gw=cnt_gw+1;
            value=data(i).data.data.data5.value(j);
            if (gw_kal_last == 0)
                gw_kal_last = value;
            else
                [P,K,gw_kal_last]=estimate(value,P,K,Q,R,gw_kal_last);
            end
            gw(cnt_gw)=value;
            gw_kal(cnt_gw)=gw_kal_last;
            count_gw(cnt_gw)=cnt;
        end
        
    elseif strcmp(data(i).data.name,'tag_wb')
        for j=1:1:5
            cnt=cnt+1;
            value=data(i).data.data.data5.value(j);
            if (tag_kal_last == 0)
                tag_kal_last = value;
            else
                [P,K,tag_kal_last]=estimate(value,P,K,Q,R,tag_kal_last);
            end
            cnt_tag=cnt_tag+1;
            tag(cnt_tag)=value;
            tag_kal(cnt_tag)=tag_kal_last;
            count_tag(cnt_tag)=cnt;
        end
        
    elseif strcmp(data(i).data.name,'pathloss_wb')
        for j=1:1:5
            cnt=cnt+1;
            value=data(i).data.data.data5.value(j);
            if (pathloss_kal_last == 0)
                pathloss_kal_last = value;
            else
                [P,K,pathloss_kal_last]=estimate(value,P,K,Q,R,pathloss_kal_last);
            end
            cnt_pathloss=cnt_pathloss+1;
            pathloss(cnt_pathloss)=value;
            pathloss_kal(cnt_pathloss)=pathloss_kal_last;
            count_pathloss(cnt_pathloss)=cnt;
        end
    end
    cnt_store=cnt_store+1;
    count_store(cnt_store)=cnt_store;
    gw_store(cnt_store)=gw_kal_last;
    tag_store(cnt_store)=tag_kal_last;
    pathloss_store(cnt_store)=pathloss_kal_last;
end
figure('Name','GATEWAY')
plot(count_gw,gw);
grid on
    
figure('Name','TAG')
plot(count_tag,tag);
grid on
    
figure('Name','PATHLOSS')
plot (count_pathloss,pathloss);
grid on

figure('Name','COMBINE')
plot(count_gw,gw,'r',count_tag,tag,'g',count_pathloss,pathloss,'b');
%legend({'GATEWAY','TAG','PATHLOSS'},'FontSize',11,'Location','northoutside');
legend({'STM32WB PCB','ESP32 IPEX','STM32WB IPEX'},'FontSize',11,'Location','northoutside');
grid on

figure('Name','GW KAL');
plot(count_store,gw_store);
grid on

figure('Name','TAG KAL');
plot(count_store,tag_store);
grid on

figure('Name','PL KAL');
plot(count_store,pathloss_store);
grid on

figure('Name','COMBINE KALMAN')
plot(count_store,gw_store,'r',count_store,tag_store,'g',count_store,pathloss_store,'b');
%legend({'GATEWAY','TAG','PATHLOSS'},'FontSize',11,'Location','northoutside');
legend({'STM32WB PCB','ESP32 IPEX','STM32WB IPEX'},'FontSize',11,'Location','northoutside');
grid on

