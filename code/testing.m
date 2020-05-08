clear all
close all

a=[];
a1=zeros(10000,1);
a2=zeros(10000,1);

for i=1:1:10000
    a(i)=-55+randi([-6,6],1);
end

a1(1)=a(1);
a2(1)=a(1);
cnt(1)=1;

P1=0.00075;
K1=0;
Q1=0.00075;
R1=12;

for i=2:1:10000
    [P1,K1,a1(i)]=estimate(a(i),P1,K1,Q1,R1,a1(i-1));
    cnt(i)=i;
end

P2=0.005;
K2=0;
Q2=0.005;
R2=5;

for i=2:1:10000
    [P2,K2,a2(i)]=estimate(a1(i),P2,K2,Q2,R2,a2(i-1));
end

figure(1)
plot(cnt,a1,cnt,a2);
grid on

figure(2)
plot(cnt,a)
grid on