clear all
close all

url = 'http://localhost:5000/newalg/getall';
options = weboptions('RequestMethod','get','Timeout',6000);
data = webread(url,options);

err=[];
cnt=[];
for i=1:1:length(data)
    err(i)=sqrt((2.43-data(i).lon)^2+(4.53-data(i).lat));
    cnt(i)=i;
end

figure('Name','ERROR NEW ALGORITHM')
plot(cnt,err)
grid on