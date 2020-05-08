#declare library
import numpy as np
import random
import math

#class definition
class Particles:
    def __init__(self,Radius,ref_pos):
        dis = random.uniform(0,Radius)
        angle = random.uniform(0,360)
        x_rand = ref_pos[0] + dis*math.sin(angle)
        y_rand = ref_pos[1] + dis*math.cos(angle)
    #format [[x, y], fitness, [[pbestx, pbesty], fitbest], [Vx, Vy], w]
        self.pos=np.array([x_rand,y_rand])
        self.fitness=0
        self.pbest_pos=np.array([0,0])
        self.pbest_fit=10000000
        self.V=np.array([[0], [0]])
        self.w=0

#define Parameter
PATH_LOSS_PARAMETER_OPEN_SPACE = 2
PATH_LOSS_PARAMETER_INDOOR = 1.7
PATH_LOSS_PARAMETER_OFFICE_HARD_PARTITION = 3

CALIBRATED_RSSI_AT_ONE_METER = -59
SIGNAL_LOSS_AT_ONE_METER = -41

Confined_Area_Radius = 2.0
Number_Of_Swarm = 100
Iteration = 1000

#testing informations
RSSI=[] #format [ToBeacon, RML_mean, RML, RNL]
RSSI.append([0, -70, -68, -78])
RSSI.append([1, -70, -69, -77])
RSSI.append([2, -70, -70, -80])
RSSI.append([3, -70, -71, -82])

node_locations = [] #format [x y beacon]
node_locations.append([0,  0,   0]) #Beacon 0
node_locations.append([20, 0,   1]) #Beacon 1
node_locations.append([0,  20,  2]) #Beacon 2
node_locations.append([20, 20,  3]) #Beacon 3

#path_loss exponent
path_loss = PATH_LOSS_PARAMETER_INDOOR

#parameter
c1=1.2
c2=1.2
r1=-0.5
r2=0.5
wmax=0.8
wmin=0.3

#correct RSSI
def Correct_RSSI():
    global correct_RSSI
    for k in RSSI:
        delta_AL = k[2]-k[1]
        correct = k[3]-delta_AL
        correct_RSSI.append([k[0], correct])z

#calculate the distance between asset tag and beacon according to RSSI
def calculate_distance():
    global distance
    for k in correct_RSSI:
        RSSI=k[1]
        dis = 10**((RSSI_calib-RSSI)/(10*path_loss))
        distance.append([k[0], dis])

#localization by MLE and get confined area of PSO
def MLE():
    global Z_MLE, node_locations
    ref = distance[len(distance)-1]
    num_ref = ref[0]
    A=[]
    b=[]
    for k in range(0,len(distance)-1,1):
        temp = distance[k]
        num = temp[0]
        A1 = 2*(node_locations[num][0] - node_locations[num_ref][0])
        A2 = 2*(node_locations[num][1] - node_locations[num_ref][1])
        A.append([A1, A2])

        b_temp= node_locations[num][0]**2 - node_locations[num_ref][0]**2 \
                + node_locations[num][1]**2 - node_locations[num_ref][1]**2 \
                + temp[1]**2 - ref[1]**2
        b.append([b_temp])


    A_transpose = np.transpose(A)
    temp = np.dot(A_transpose,A)
    temp1 = np.linalg.inv(temp)
    temp2 = np.dot(temp1,A_transpose)
    Z_MLE = np.dot(temp2,b)

    print(Z_MLE)
    

#Evaluate fitness
def eval_fitness(x,y,best):
    global node_locations
    fitness=0
    for k in distance:
        fitness = fitness + (k[1]-((x-node_locations[k[0]][0])**2 \
                                   +(y-node_locations[k[0]][1])**2)**(1/2))**2
        
    if best>fitness:
        best_ = fitness
    else:
        best_=best
    return [fitness, best_]

#validate fitness and update pbest gbest
def validate():
    global swarm, gbest_pos, gbest_fit
    for k in range(0,len(swarm),1):
        particle=swarm[k]
        [fit, fitbest] = eval_fitness(particle.pos[0],particle.pos[1],particle.pbest_fit)
        if fitbest==fit:
            swarm[k].pbest_pos=particle.pos
            swarm[k].pbest_fit=fitbest
            if gbest_fit > fitbest:
                gbest_pos=particle.pos
                gbest_fit=fitbest


#update pos and velo
def update(step):
    global swarm, Z_MLE
    for k in range(1,Number_Of_Swarm-1,1):
        particle=swarm[k]
        Z_curr=particle.pos
        V_curr=particle.V
        pbest_curr=particle.pbest_pos
        w_curr= particle.w
        V_next = w_curr*V_curr + c1*r1*(pbest_curr-Z_curr) \
                 + c2*r2*(gbest_pos-Z_curr)
        
        Z_next = Z_curr +V_next;
        w_curr= wmax- step*(wmax-wmin)/Iteration
        temp=((Z_next[0]-Z_MLE[0])**2 + (Z_next[1]-Z_MLE[1])**2)**(1/2)
        if temp<=Confined_Area_Radius:
            swarm[k].pos=Z_next
        swarm[k].V=V_next
        swarm[k].w=w_curr;
    
            
#main
RSSI_calib=CALIBRATED_RSSI_AT_ONE_METER
correct_RSSI=[]
distance=[]
Z_MLE=[]


Correct_RSSI()
calculate_distance()
MLE()

swarm=[]
gbest_pos=np.array([0, 0])
gbest_fit=10000000
#generate swarm
for k in range(1,Number_Of_Swarm,1):
    particle=Particles(Confined_Area_Radius, Z_MLE)
    swarm.append(particle)

step = 0;
while step < Iteration:
    step = step+1
    validate()
    update(step)
print("global best position:")
print(gbest_pos)
print("global best fitness:")
print(gbest_fit)

        
 

    
    




































                  
