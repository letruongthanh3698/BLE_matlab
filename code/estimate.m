function [P,K,last_est]=estimate(mea,P,K,Q,R,last_est)
    x_=last_est;
    P_=P+Q;
    K=P_/(P_+R);
    last_est=x_+K*(mea-x_);
    P=(1-K)*P_;
end

