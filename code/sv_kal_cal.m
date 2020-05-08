function [ ref, delta, dis, dis_kal ] = sv_kal_cal( pathloss, tag, dis_pathloss, dis_ref, R1 )
pathloss_exp=-(pathloss-R1)./(10*log10(dis_pathloss));
%pl_exp=2.5;
%for i=1:1:length(pathloss_exp)
%    pathloss_exp(i)=pl_exp;
%end
ref=[];
delta=[];
for i=1:1:length(tag)
    if tag(i)<pathloss(i)
        temp=1;
    else
        temp=0;
    end
    dis(i)=10.^((R1-(tag(i)+temp*0))./(10*pathloss_exp(i)));
    %if dis(i)>15 
    %    dis(i)=15;
    %end
    ref(i)=dis_ref;
    delta(i)=abs(dis(i)-ref(i));
end

P=0.00075;
K=0;
Q=0.00075;
R=100;
dis_kal=[];
dis_kal(1)=dis(1);

for i=2:1:length(dis);
    [P,K,dis_kal(i)]=estimate(dis(i),P,K,Q,R,dis_kal(i-1));
end

end

