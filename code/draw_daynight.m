function draw_daynight( point,value,time,sp)
%DRAW_DAYNIGHT Summary of this function goes here
%   Detailed explanation goes here
    
    hold on
    
    y=[max(ylim), max(ylim), min(ylim), min(ylim)];
    for i=1:1:length(point)-1
        x=[time(point(i)), time(point(i+1)), time(point(i+1)), time(point(i))];
        if value(i)==1
            c='y';
        else
            c='k';
        end
        
        fill(x,y,c,'facealpha',0.1)
    end
    hold off
    grid on
end

