function [count_gw,gw_kal,count_tag,tag_kal,count_pathloss,pathloss_kal] = combine_km(data,P,K,Q,R)
    gw=[];
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
    for i=1:1:length(data)
        if strcmp(data(i).data.name,'gateway_wb')
            sum=0;
            for j=1:1:5
                cnt_gw=cnt_gw+1;
                value=data(i).data.data.data5.value(j);
                if (gw_kal_last == 0)
                    gw_kal_last = value;
                else
                    [P,K,gw_kal_last]=estimate(value,P,K,Q,R,gw_kal_last);
                end
                gw(cnt_gw)=value;
                gw_kal(cnt_gw)=gw_kal_last;
                count_gw(cnt_gw)=cnt_gw;
            end

        elseif strcmp(data(i).data.name,'tag_wb')
            for j=1:1:5
                value=data(i).data.data.data5.value(j);
                if (tag_kal_last == 0)
                    tag_kal_last = value;
                else
                    [P,K,tag_kal_last]=estimate(value,P,K,Q,R,tag_kal_last);
                end
                cnt_tag=cnt_tag+1;
                tag(cnt_tag)=value;
                tag_kal(cnt_tag)=tag_kal_last;
                count_tag(cnt_tag)=cnt_tag;
            end
        elseif strcmp(data(i).data.name,'pathloss_wb')
            for j=1:1:5
                value=data(i).data.data.data5.value(j);
                if (pathloss_kal_last == 0)
                    pathloss_kal_last = value;
                else
                    [P,K,pathloss_kal_last]=estimate(value,P,K,Q,R,pathloss_kal_last);
                end
                cnt_pathloss=cnt_pathloss+1;
                pathloss(cnt_pathloss)=value;
                pathloss_kal(cnt_pathloss)=pathloss_kal_last;
                count_pathloss(cnt_pathloss)=cnt_pathloss;
            end
        end
    end
end

