class KMF:
    def __init__(this):
        pass
    
    def estimate(this,mea,P,K,Q,R,last_est):
        x_=last_est
        P_=P+Q
        K=P_/(P_+R)
        last_est=x_+K*(mea-x_)
        P=(1-K)*P_

        return P, K, last_est
    
