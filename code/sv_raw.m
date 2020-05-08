clear all
close all

%url = 'http://178.128.97.64:8080/rtlsbletest/getall';
%options = weboptions('RequestMethod','get','Timeout',6000);
%data = webread(url,options);
load('data_sv_2020.04.09.14.21_raw_R1m.45.5.mat')

gw59=[];tg59=[];pl59=[];
gw93=[];tg93=[];pl93=[];
gwc2=[];tgc2=[];plc2=[];
gwc0=[];tgc0=[];plc0=[];

cnt_tg=0;t_tg=[];
cnt_pl=0;t_pl=[];
cnt_gw=0;t_gw=[];

first=0;
for i=first+1:1:length(data)
    [gw, tg, pl, name, time]=getrawdata(data(i));
    if strcmp(name,'Gateway')
        for i=1:1:5
            gw59(cnt_gw+i)=gw(i,1);
            gw93(cnt_gw+i)=gw(i,2);
            gwc2(cnt_gw+i)=gw(i,3);
            gwc0(cnt_gw+i)=gw(i,4);
            t_gw(cnt_gw+i)=time(i);
        end
        cnt_gw=cnt_gw+5;
    elseif strcmp(name,'Tag')
        for i=1:1:5
            tg59(cnt_tg+i)=tg(i,1);
            tg93(cnt_tg+i)=tg(i,2);
            tgc2(cnt_tg+i)=tg(i,3);
            tgc0(cnt_tg+i)=tg(i,4);
            t_tg(cnt_tg+i)=time(i);
        end
        cnt_tg=cnt_tg+5;
    elseif strcmp(name,'Pathloss')
        for i=1:1:5
            pl59(cnt_pl+i)=pl(i,1);
            pl93(cnt_pl+i)=pl(i,2);
            plc2(cnt_pl+i)=pl(i,3);
            plc0(cnt_pl+i)=pl(i,4);
            t_pl(cnt_pl+i)=time(i);
        end
        cnt_pl=cnt_pl+5;
    end
end

%set(gca,'xtick',[t_tg(3):t_tg(length(t_tg))])

figure('Name','59')
plot(t_tg,tg59,'r',t_pl,pl59,'b',t_gw,gw59,'g')
legend({'TAG','PATHLOSS','GATEWAY'},'FontSize',11,'Location','northoutside');
datetick('x','HH:MM','keepticks')
grid on

figure('Name','93')
plot(t_tg,tg93,'r',t_pl,pl93,'b',t_gw,gw93,'g')
legend({'TAG','PATHLOSS','GATEWAY'},'FontSize',11,'Location','northoutside');
datetick('x','HH:MM','keepticks')
grid on

figure('Name','C2')
plot(t_tg,tgc2,'r',t_pl,plc2,'b',t_gw,gwc2,'g')
legend({'TAG','PATHLOSS','GATEWAY'},'FontSize',11,'Location','northoutside');
datetick('x','HH:MM','keepticks')
grid on

figure('Name','C0')
plot(t_tg,tgc0,'r',t_pl,plc0,'b',t_gw,gwc0,'g')
legend({'TAG','PATHLOSS','GATEWAY'},'FontSize',11,'Location','northoutside');
datetick('x','HH:MM','keepticks')
grid on
