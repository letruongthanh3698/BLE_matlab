classdef KMF < handle
    %KMF Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        last_est
        Q
        R
        P
        K

    end
    
    methods
        function obj=init(obj,P,K,Q,R,last_est)
                obj.Q=Q;
                obj.R=R;
                obj.k=K;
                obj.last_est=last_est;
                obj.P=P;
        end
        function obj=estimate(obj,mea)
                x_=obj.last_est;
                P_=obj.P+obj.Q;
                obj.K=P_/(P_+obj.R);
                obj.last_est=x_+obj.K*(mea-x_);
                obj.P=(1-obj.K)*P_;
        end
    end
    
end

