from KMF import KMF
import math

class estimate_dis:
    def __init__(this,P,K,Q,R):
        this.P=P
        this.K=K
        this.Q=Q
        this.R=R

    def estimate(this,R_correct, R_kal_last_est):
        kmf=KMF()
        this.P, this.K, last_est = kmf.estimate(R_correct, this.P, this.K, this.Q, this.R, R_kal_last_est)
        return last_est

    def kalman(this, R_gateway_mean, R_gateway_last, R_last, last_est, initiate):
        delta=R_gateway_last-R_gateway_mean
        if initiate==1:
            last_est=R_last-delta
        else:
            R_correct=R_last-delta
            last_est=this.estimate(R_correct, last_est)
        return last_est

    def calculate(this, R_tag, R_pathloss, dis_pathloss):
        pathloss=-(R_pathloss+59)/(10*math.log10(dis_pathloss))
        distance=10**((-59-R_tag)/(10*pathloss))
        return distance
