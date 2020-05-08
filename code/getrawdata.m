function [ gw, tag, pl, name, time ] = getrawdata( data )
%GETDATA Summary of this function goes here
%   Detailed explanation goes here
    Mac59='ac:23:3f:a2:16:59';
    Mac93='ac:23:3f:a2:16:93';
    MacC2='ac:23:3f:a2:16:c2';
    MacC0='ac:23:3f:a2:16:c0';
    
    for i=1:1:4
        temp_=struct2cell(data.data.data);
        temp=temp_{i};
        if strcmp(temp.Mac,Mac59)
            tmp59=temp.value;
        elseif strcmp(temp.Mac,Mac93)
            tmp93=temp.value;
        elseif strcmp(temp.Mac,MacC2)
            tmpc2=temp.value;
        elseif strcmp(temp.Mac,MacC0)
            tmpc0=temp.value;
        end
    end
    
    datetime_str=data.createtime;
    dt_str=datetime_str(1:19);
    dt_str(11)=' ';
    t=datetime(dt_str,'TimeZone','+00:00');
    t.TimeZone='+07:00';
    time=datenum(t+seconds(-24:6:0));
    
    if strcmp(data.data.name,'tag_home')
        tag=[tmp59 tmp93 tmpc2 tmpc0];
        gw=0;
        pl=0;
        name='Tag';
    elseif strcmp(data.data.name,'pathloss_home')
        tag=0;
        gw=0;
        pl=[tmp59 tmp93 tmpc2 tmpc0];
        name='Pathloss';
    elseif strcmp(data.data.name,'gateway_home')
        tag=0;
        gw=[tmp59 tmp93 tmpc2 tmpc0];
        pl=0;
        name='Gateway';
    end

end

