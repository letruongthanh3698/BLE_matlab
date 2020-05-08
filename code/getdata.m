function [ gateway, tag, pathloss, dis ] = getdata( data )
%GETDATA Summary of this function goes here
%   Detailed explanation goes here
    Mac59='ac:23:3f:a2:16:59';
    Mac93='ac:23:3f:a2:16:93';
    MacC2='ac:23:3f:a2:16:c2';
    MacC0='ac:23:3f:a2:16:c0';
    
    for i=1:1:4
        temp_=struct2cell(data.rssi_mean.Gateway.value);
        temp=temp_{i};
        tempgw=temp.sum(5,1) / temp.count(5,1);
        if strcmp(temp.Mac,Mac59)
            gw59=tempgw;
        elseif strcmp(temp.Mac,Mac93)
            gw93=tempgw;
        elseif strcmp(temp.Mac,MacC2)
            gwc2=tempgw;
        elseif strcmp(temp.Mac,MacC0)
            gwc0=tempgw;
        end
        
        temp_=struct2cell(data.rssi_mean.Tag.value);
        temp=temp_{i};
        temptg=temp.Last_kal;
        tempdis=temp.distance;
        if strcmp(temp.Mac,Mac59)
            tg59=temptg;%+3.1251703178650487;%+2;
            dis59=tempdis;
        elseif strcmp(temp.Mac,Mac93)
            tg93=temptg;%-1.3577211252097143;
            dis93=tempdis;
        elseif strcmp(temp.Mac,MacC2)
            tgc2=temptg;%-0.47533575755330304;%-3;
            disc2=tempdis;
        elseif strcmp(temp.Mac,MacC0)
            tgc0=temptg;%+1.1714324033986117;%+1;
            disc0=tempdis;
        end
        
        temp_=struct2cell(data.rssi_mean.Pathloss.value);
        temp=temp_{i};
        temppl=temp.Last_kal;
        if strcmp(temp.Mac,Mac59)
            pl59=temppl;
        elseif strcmp(temp.Mac,Mac93)
            pl93=temppl;
        elseif strcmp(temp.Mac,MacC2)
            plc2=temppl;
        elseif strcmp(temp.Mac,MacC0)
            plc0=temppl;
        end
    end
    gateway=[gw59 gw93 gwc2 gwc0];
    tag=[tg59 tg93 tgc2 tgc0];
    pathloss=[pl59 pl93 plc2 plc0];
    dis=[dis59 dis93 disc2 disc2];
end

