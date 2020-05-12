function save_fig( name,save )
%SAVE_FIG Summary of this function goes here
%   Detailed explanation goes here
    if save==1
        saveas(gcf,name,'fig')
        saveas(gcf,name,'jpg')
    end
end

