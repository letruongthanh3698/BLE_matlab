####****************************Request library****************************####
from estimate_dis import estimate_dis
####***********************************************************************####

#import lib
from scipy.io import loadmat 
import requests
import matplotlib.pyplot as plt
import math

####**********************get data from json/mat file**********************####
def processdata(mat):
    
    gateway = []
    tag = []
    pathloss = []
    
    data=mat['data']['data']
    
    for i in range(0,len(data)-1,1):
        cell=data[i,0]
        if cell['name'][0,0][0] == 'gateway':
            for j in range(0,len(cell['data1'][0,0]['value'][0,0])-1,1):
                gateway.append(cell['data1'][0,0]['value'][0,0][j][0])
        elif cell['name'][0,0][0] == 'tag':
            for j in range(0,len(cell['data1'][0,0]['value'][0,0])-1,1):
                tag.append(cell['data1'][0,0]['value'][0,0][j][0])
        elif cell['name'][0,0][0] == 'pathloss':
            for j in range(0,len(cell['data1'][0,0]['value'][0,0])-1,1):
                pathloss.append(cell['data1'][0,0]['value'][0,0][j][0])

    return gateway, tag, pathloss
####************************************************************************####

####**********************************main**********************************####


#get json data
#URL = "http://68.183.235.97:8080/rtlsbletest/getall"
#r = requests.get(url=URL)
#data = r.json()

#load .mat
data=loadmat('23d_12m_11h_49m.mat')

#init variable
cnt=0
R_sum=0
R_mean=[]
R_tag_kal=[]
R_path_kal=[]
distance=[]
x=[]
last_est_tag=0
last_est_path=0
dis_pathloss=9

#get data
gateway, tag, pathloss = processdata(data)

#***init***# 
est=estimate_dis(0.00075,0,0.00075,20)
#***end - init***#

#calculate
for i in range(0,len(gateway)-1,1):
    R_sum=R_sum+gateway[i]
    R_mean.append(R_sum/(cnt+1))
 
    if i==0:
        initiate=1
    else:
        initiate=0
    #***get estimate tag***#
    last_est_tag= est.kalman(R_mean[cnt], gateway[i], tag[i], last_est_tag, initiate)
    #***end - get estimate tag***#
    
    #***get estimate pathloss***#
    last_est_path= est.kalman(R_mean[cnt], gateway[i], pathloss[i], last_est_path, initiate)
    #***end - get estimate pathloss***#

    #***calculate distance***#
    dis=est.calculate(last_est_tag, last_est_path, dis_pathloss)
    #***end - calculate distance***#
    
    #append to array to plot figure
    R_tag_kal.append(last_est_tag)
    R_path_kal.append(last_est_path)
    cnt=cnt+1;
    x.append(cnt)
    distance.append(dis)

#plot figure


plt.figure(1)
plt.plot(x,R_tag_kal,label='TAG')
plt.plot(x,R_path_kal,label='PATHLOSS')

plt.figure(2)
plt.plot(x,distance,label='DISTANCE')

plt.legend()
plt.grid()
plt.show()
####************************************************************************####
                     
