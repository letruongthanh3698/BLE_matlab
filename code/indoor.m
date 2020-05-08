close all

gateway=table2array(readtable('gateway.csv'));
tag=table2array(readtable('tag.csv'));
pathloss=table2array(readtable('pathloss.csv'));

R_mean=0;
R_tag_kal=0;
R_pathloss_kal=0;

Q=0.001;
R=10;

P_tag=5;
K_tag=0;
last_est_tag=0;

P_path=5;
K_path=0;
last_est_path=0;

Kal_tag=KMF;
Kal_pathloss=KMF;

R_tag_kal=[];
R_pathloss_kal=[];
x=[];
cnt=1;

for i=1:1:length(gateway)
    if i==1
        R_mean=gateway(i,1);
        R_tag_kal(cnt)=tag(i,1);
        R_pathloss_kal(cnt)=pathloss(i,1);
        last_est_tag=tag(i,1);
        last_est_path=pathloss(i,1);
    else
        R_mean=R_mean+gateway(i,1);
        
        R_tag_correct=tag(i,1)-(gateway(i,1)-R_mean/cnt);
        [P_tag,K_tag,last_est_tag]=estimate(R_tag_correct,P_tag,K_tag,Q,R,last_est_tag);
        R_tag_kal(cnt)=last_est_tag;
        
        R_pathloss_correct=pathloss(i,1)-(gateway(i,1)-R_mean/cnt);
        [P_path,K_path,last_est_path]=estimate(R_pathloss_correct,P_path,K_path,Q,R,last_est_path);
        R_pathloss_kal(cnt)=last_est_path;
    end
    x(cnt)=(cnt-1)*5;
    cnt=cnt+1;
end

pathloss=-(R_pathloss_kal+59)./(10*log10(4.38));
distance=10.^((-59-R_tag_kal)./(10*pathloss));

figure(1)
plot(x,R_tag_kal,'r',x,R_pathloss_kal,'b');
grid on

figure(2);
plot(x,distance,'r');
grid on
