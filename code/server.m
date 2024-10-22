close all

%url = 'http://178.128.97.64:8080/rtlsbletest/getall';
%url = 'http://localhost:5000/rtlsbletest/getall';
%options = weboptions('RequestMethod','get');
%data = webread(url,options);

load('data_sv_database.2020.05.08_raw.mat')

%[gateway, tag, pathloss, t_gateway, t_tag, t_pathloss]=processdata(data);

%init data
count_mean=[];
count_tag=[];
count_pathloss=[];
R_tag=[];
R_path=[];
R_sum=[];
R_tag_kal=[];
R_pathloss_kal=[];
init_gateway=0;
init_tag=0;
init_pathloss=0;

%init Kalman
Q=0.00075;
R=5;
P=Q;
K=0;
last_est_tag=[];
last_est_path=[];

kal=KMF;

index=-5;
index_tag=0;
index_pathloss=0;

withkalman=0;

for i=1:1:700%length(data)
    if strcmp(data(i).data.name,'gateway_home')
        index=index+length(data(i).data.data.data4.value);
        for j=1:1:length(data(i).data.data.data4.value)
            gateway(j)=data(i).data.data.data4.value(j);
            if init_gateway==0
                R_sum(index+j)=gateway(j);
                count_mean(index+j)=1;
                init_gateway=1;
            else
                R_sum(index+j)=R_sum(index+j-1)+gateway(j);
            end
            count_mean(index+j)=index+j;
        end
    end
    if strcmp(data(i).data.name,'tag_home')
        for j=1:1:length(data(i).data.data.data4.value)  
            tag(j)=data(i).data.data.data4.value(j);
            if init_tag==0
                R_tag_kal(index_tag+j)=tag(j);
                init_tag=1;
            else
                R_correct=tag(j)-(gateway(j)-R_sum(index+j)/count_mean(index+j));
                if withkalman==1
                    [P,K,last]=estimate(R_correct,P,K,Q,R,R_tag_kal(index_tag+j-1));
                else
                    last=R_correct;
                end
                R_tag_kal(index_tag+j)=last;
            end
            count_tag(index_tag+j)=index+j;
        end
        index_tag=index_tag+length(data(i).data.data.data4.value);
    end
    if strcmp(data(i).data.name,'pathloss_home')
        for j=1:1:length(data(i).data.data.data4.value)  
            pathloss(j)=data(i).data.data.data4.value(j);
            if init_pathloss==0
                R_pathloss_kal(index_pathloss+j)=pathloss(j);
                init_pathloss=1;
            else
                R_correct=pathloss(j)-(gateway(j)-R_sum(index+j)/count_mean(index+j));
                if withkalman==1
                    [P,K,last]=estimate(R_correct,P,K,Q,R,R_pathloss_kal(index_pathloss+j-1));
                else
                    last=R_correct;
                end
                R_pathloss_kal(index_pathloss+j)=last;
            end
            count_pathloss(index_pathloss+j)=index+j;
        end
        index_pathloss=index_pathloss+length(data(i).data.data.data4.value);
    end   
end

R_mean=[];
for i=1:1:length(R_sum)
    R_mean(i)=R_sum(i)/count_mean(i);
end 
figure(1)
plot(count_tag,R_tag_kal,'r',count_pathloss,R_pathloss_kal,'b',count_mean,R_mean,'g')
legend({'TAG','PATHLOSS','GATEWAY'},'FontSize',11,'Location','northoutside');
xlabel('STEP')
ylabel('RSSI')
grid on

if withkalman==0
    T=table(count_mean',R_mean');
    T.Properties.VariableNames={'Step_Gateway';'gateway'};
    writetable(T,'improve_rssi.xlsx','Sheet','Sheet1','Range','M2')
    
    T=table(count_pathloss',R_pathloss_kal');
    T.Properties.VariableNames={'Step_Pathloss';'Pathloss'};
    writetable(T,'improve_rssi.xlsx','Sheet','Sheet1','Range','O2')
    
    T=table(count_tag',R_tag_kal');
    T.Properties.VariableNames={'Step_Tag';'Tag'};
    writetable(T,'improve_rssi.xlsx','Sheet','Sheet1','Range','Q2')
end

%figure(2)
%plot(count_dis,distance);
%grid on
