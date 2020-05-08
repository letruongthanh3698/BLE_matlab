close all
clear all

gw={};
pathloss={};
tag={};
cnt_gw={};
cnt_pathloss={};
cnt_tag={};

url = 'http://178.128.97.64:8080/stmtest/getall';
options = weboptions('RequestMethod','get','Timeout',600);
data = webread(url,options);
%load('data_stm32wb_10_3_16_25.mat')

kalman_para=[   0.0075,      0,   0.0075,      6;
                0.00075,     0,   0.00075,     6;
                0.00005,     0,   0.00005,     6];
name=['GW KAL','TAG KAL','PATHLOSS KAL'];
for i=1:1:3
       
    P=kalman_para(i,1);
    K=kalman_para(i,2);
    Q=kalman_para(i,3);
    R=kalman_para(i,4);

    [cnt_gw{i},gw{i},cnt_tag{i},tag{i},cnt_pathloss{i},pathloss{i}]=combine_km(data,P,K,Q,R);
end

kalman_para_str=num2str(kalman_para,'%f,  ');

figure('Name','GW KAL');
plot(cnt_gw{1},gw{1},'r',cnt_gw{2},gw{2},'g',cnt_gw{3},gw{3},'b');
legend({kalman_para_str},'FontSize',11,'Location','northoutside');
grid on

figure('Name','TAG KAL');
plot(cnt_tag{1},tag{1},'r',cnt_tag{2},tag{2},'g',cnt_tag{3},tag{3},'b');
legend({kalman_para_str},'FontSize',11,'Location','northoutside');
grid on

figure('Name','PL KAL');
plot(cnt_pathloss{1},pathloss{1},'r',cnt_pathloss{2},pathloss{2},'g',cnt_pathloss{3},pathloss{3},'b');
legend({kalman_para_str},'FontSize',11,'Location','northoutside');
grid on






