function [gateway, tag, pathloss,t_gateway, t_tag, t_pathloss] = processdata( data )
%PROCESSDATA Summary of this function goes here
%   Detailed explanation goes here
cnt1=int32(0);
cnt2=int32(0);
cnt3=int32(0);

cnt1_=int32(0);
cnt2_=int32(0);
cnt3_=int32(0);

gateway=[];
tag=[];
pathloss=[];
t_gateway=[];
t_tag=[];
t_pathloss=[];
for i=1:1:length(data)
    if strcmp(data(i).data.name,'gateway')
        for j=1:1:length(data(i).data.data1.value)
            cnt1=cnt1+1;
            gateway(cnt1)=data(i).data.data1.value(j);
        end
        cnt1_=cnt1_+1;
        t_gateway(cnt1_)=int16(str2num(data(i).createtime(18:19)));
    elseif strcmp(data(i).data.name,'tag')
        for j=1:1:length(data(i).data.data1.value)
            cnt2=cnt2+1;
            tag(cnt2)=data(i).data.data1.value(j);
        end
        cnt2_=cnt2_+1;
        t_tag(cnt2_)=int16(str2num(data(i).createtime(18:19)));
    elseif strcmp(data(i).data.name,'pathloss')
        for j=1:1:length(data(i).data.data1.value)
            cnt3=cnt3+1;
            pathloss(cnt3)=data(i).data.data1.value(j);
        end
        cnt3_=cnt3_+1;
        t_pathloss(cnt3_)=int16(str2num(data(i).createtime(18:19)));
    end
end
end

