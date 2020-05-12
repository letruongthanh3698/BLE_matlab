clear all
close all

%url = 'http://178.128.97.64:8080/rtls_list/getall';
%url1= 'http://178.128.97.64:8080/rtlsbletest/getall';
%url = 'http://localhost:5000/rtls_list/getall';
%options = weboptions('RequestMethod','get','Timeout',6000);
%data = webread(url,options);
%data1= webread(url,options);
load('data_sv_2020.05.11.17.04_R1m.40_local_calculator_database.2020.05.11_start.500.mat')
%load('data_esp_18_3_16_51_cal.mat')
R1=-40;

IsAdjust=1;

tag59=zeros(length(data),1);
pathloss59=zeros(length(data),1);
gateway59=zeros(length(data),1);

tag93=zeros(length(data),1);
pathloss93=zeros(length(data),1);
gateway93=zeros(length(data),1);

tagc2=zeros(length(data),1);
pathlossc2=zeros(length(data),1);
gatewayc2=zeros(length(data),1);

tagc0=zeros(length(data),1);
pathlossc0=zeros(length(data),1);
gatewayc0=zeros(length(data),1);

count=zeros(length(data),1);
time=zeros(length(data),1);
err=zeros(length(data),1);
loc={};
first=0;
dis_59=[];
dis_93=[];
dis_c2=[];
dis_c0=[];
delta_59=[];
delta_93=[];
delta_c2=[];
delta_c0=[];
for i=first+1:1:length(data)
    [gw, tg, pl, dis ]=getdata(data(i));
    gateway59(i-first)=gw(1);tag59(i-first)=tg(1);pathloss59(i-first)=pl(1);dis_59(i-first)=dis(1);delta_59(i-first)=abs(dis(1)-4.61);
    gateway93(i-first)=gw(2);tag93(i-first)=tg(2);pathloss93(i-first)=pl(2);dis_93(i-first)=dis(2);delta_93(i-first)=abs(dis(2)-5.95);
    gatewayc2(i-first)=gw(3);tagc2(i-first)=tg(3);pathlossc2(i-first)=pl(3);dis_c2(i-first)=dis(3);delta_c2(i-first)=abs(dis(3)-8.78);
    gatewayc0(i-first)=gw(4);tagc0(i-first)=tg(4);pathlossc0(i-first)=pl(4);dis_c0(i-first)=dis(4);delta_c0(i-first)=abs(dis(4)-7.19);
    
    count(i-first)=i-first;
    
    d_lat=data(i).rssi_mean.Delta.lat;
    d_lon=data(i).rssi_mean.Delta.lon;
    if isempty(data(i).rssi_mean.Tag.location)==0 
        y=data(i).rssi_mean.Tag.location.lat / d_lat;%doc
        x=data(i).rssi_mean.Tag.location.lon / d_lon;%ngang
    
        loc{i-first}=[x y];
        err(i-first)=sqrt((x-2.43)^2+(y-4.53)^2);
    end
    
    datetime_str=data(i).createtime;
    dt_str=datetime_str(1:19);
    dt_str(11)=' ';
    t=datetime(dt_str,'TimeZone','+00:00');
    t.TimeZone='+07:00';
    time(i-first)=datenum(t);
        
end
%P=0.005;
%K=0;
%Q=0.005;
%R=5;
%for i=2:1:length(data)
%    [P,K,tag59(i)]=estimate(tag59(i),P,K,Q,R,tag59(i-1));
%    [P,K,pathloss59(i)]=estimate(pathloss59(i),P,K,Q,R,pathloss59(i-1));
%    
%    [P,K,tag93(i)]=estimate(tag93(i),P,K,Q,R,tag93(i-1));
%    [P,K,pathloss93(i)]=estimate(pathloss93(i),P,K,Q,R,pathloss93(i-1));
%    
%    [P,K,tagc2(i)]=estimate(tagc2(i),P,K,Q,R,tagc2(i-1));
%    [P,K,pathlossc2(i)]=estimate(pathlossc2(i),P,K,Q,R,pathlossc2(i-1));
%    
%    [P,K,tagc0(i)]=estimate(tagc0(i),P,K,Q,R,tagc0(i-1));
%    [P,K,pathlossc0(i)]=estimate(pathlossc0(i),P,K,Q,R,pathlossc0(i-1));
%end


point=[ 1.34 0.05; 7.55 1.50; 7.55 11.66; 1.5 11.66; 2.43 4.53];

%59
[ref59, delta59, dis59, dis59_kal]=sv_kal_cal(pathloss59, tag59, 6.37, 4.61, R1);

%93
[ref93, delta93, dis93, dis93_kal]=sv_kal_cal(pathloss93, tag93, 7.04, 5.95, R1);

%C2
[refc2, deltac2, disc2, disc2_kal]=sv_kal_cal(pathlossc2, tagc2, 7.39, 8.78, R1);

%C0
[refc0, deltac0, disc0, disc0_kal]=sv_kal_cal(pathlossc0, tagc0, 5.41, 7.19, R1);

cnt_=0;
d59=[];del59=[];
d93=[];del93=[];
dc2=[];delc2=[];
dc0=[];delc0=[];
t_=[];
cnt_=cnt_+1;
d59(cnt_)=dis_59(1);del59(cnt_)=delta_59(1);
d93(cnt_)=dis_93(1);del93(cnt_)=delta_93(1);
dc2(cnt_)=dis_c2(1);delc2(cnt_)=delta_c2(1);
dc0(cnt_)=dis_c0(1);delc0(cnt_)=delta_c0(1);
t_(cnt_)=time(1);

if (IsAdjust==1)
    for i=2:1:length(dis_59)
        if (dis_59(i)~=0)
            cnt_=cnt_+1;
            d59(cnt_)=dis_59(i);del59(cnt_)=delta_59(i);
            d93(cnt_)=dis_93(i);del93(cnt_)=delta_93(i);
            dc2(cnt_)=dis_c2(i);delc2(cnt_)=delta_c2(i);
            dc0(cnt_)=dis_c0(i);delc0(cnt_)=delta_c0(i);
            t_(cnt_)=time(i);
        else 
            cnt_=cnt_+1;
            d59(cnt_)=d59(cnt_-1);del59(cnt_)=del59(cnt_-1);
            d93(cnt_)=d93(cnt_-1);del93(cnt_)=del93(cnt_-1);
            dc2(cnt_)=dc2(cnt_-1);delc2(cnt_)=delc2(cnt_-1);
            dc0(cnt_)=dc0(cnt_-1);delc0(cnt_)=delc0(cnt_-1);
            t_(cnt_)=time(i);
        end
    end 
else
    d59=dis59;del59=delta59;
    d93=dis93;del93=delta93;
    dc2=disc2;delc2=deltac2;
    dc0=disc0;delc0=deltac0;
    t_=time;
end
radius=[d59; d93; dc2; dc0];

t_min=time(1);
t_max=time(length(time));
t_step=3*(datenum('01:00')-datenum('00:00'));

last_time=0; %0:unidentify   1: day  2: night
time_point=[];
time_value=[];
cnt_time=0;
for i=1:1:length(time)
    tmp=datestr(time(i),'HH');
    n = str2num(['uint8(',tmp,')']);
    if (n>=18) || (n<8)
        current_time=2;
    else
        current_time=1;
    end
    if current_time~=last_time
        cnt_time=cnt_time+1;
        time_point(cnt_time)=i;
        time_value(cnt_time)=current_time;
        last_time=current_time;
    end
end

cnt_time=cnt_time+1;
time_point(cnt_time)=length(time);
time_value(cnt_time)=0;

