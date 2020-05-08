close all
clear all

url = 'http://178.128.97.64:8080/stmtest/getall';
options = weboptions('RequestMethod','get','Timeout',6000);
data = webread(url,options);
%load('data_stm32wb_10_3_16_25.mat')

gateway_last=[0 0 0 0 0];
gateway_count=[0 0 0 0 0];
gateway_sum=[0 0 0 0 0];
gateway_mean=[0 0 0 0 0];
gw=[];
gw_mean=[];
cnt_gw=0;
count_gw=[];

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

P=0.0075;
K=0;
Q=0.0075;
R=6;

gw_store=[];
tag_store=[];
pathloss_store=[];
count_store=[];
cnt_store=0;

for i=1:1:length(data)
    if strcmp(data(i).data.name,'gateway_wb')
        sum=0;
        for j=1:1:5
            cnt_gw=cnt_gw+1;
            value=data(i).data.data.data1.value(j);
            gw(cnt_gw)=value;
            sum=sum+value;
            gateway_last(j)=value;
            gateway_count(j)=gateway_count(5)+j;
            gateway_sum(j)=gateway_sum(5)+sum;
            gateway_mean(j)=gateway_sum(j)/gateway_count(j);
            gw_mean(cnt_gw)=gateway_mean(j);
            count_gw(cnt_gw)=cnt_gw;
        end
        
    elseif strcmp(data(i).data.name,'tag_wb')
        for j=1:1:5
            value=data(i).data.data.data1.value(j);
            if (gateway_count(j)==0)
                value_crt=value;
            else
                value_crt=value-(gateway_last(j)-gateway_sum(j)/gateway_count(j));
            end
            if (tag_kal_last==0)
                tag_kal_last=value_crt;
            else
                [P,K,tag_kal_last]=estimate(value_crt,P,K,Q,R,tag_kal_last);
            end
            cnt_tag=cnt_tag+1;
            tag(cnt_tag)=value;
            tag_kal(cnt_tag)=tag_kal_last;
            count_tag(cnt_tag)=cnt_tag;
        end
    elseif strcmp(data(i).data.name,'pathloss_wb')
        for j=1:1:5
            value=data(i).data.data.data1.value(j);
            if (gateway_count(j)==0)
                value_crt=value;
            else
                value_crt=value-(gateway_last(j)-gateway_sum(j)/gateway_count(j));
            end
            if (pathloss_kal_last==0)
                pathloss_kal_last=value_crt;
            else
                [P,K,pathloss_kal_last]=estimate(value_crt,P,K,Q,R,pathloss_kal_last);
            end
            cnt_pathloss=cnt_pathloss+1;
            pathloss(cnt_pathloss)=value;
            pathloss_kal(cnt_pathloss)=pathloss_kal_last;
            count_pathloss(cnt_pathloss)=cnt_pathloss;
        end
    end
    cnt_store=cnt_store+1;
    count_store(cnt_store)=cnt_store;
    gw_store(cnt_store)=gateway_mean(5);
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

figure('Name','GW MEAN');
plot(count_store,gw_store);
grid on

figure('Name','TAG KAL');
plot(count_store,tag_store);
grid on

figure('Name','PL KAL');
plot(count_store,pathloss_store);
grid on

