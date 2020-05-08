function [ data_kal ] = kalman( P,K,Q,R, data )
%KALMAN Summary of this function goes here
%   Detailed explanation goes here
    data_kal=[];
    data_kal(1)=data(1);
    for i=2:1:length(data)
        [P,K,data_kal(i)]=estimate(data(i),P,K,Q,R,data_kal(i-1));
    end

end

