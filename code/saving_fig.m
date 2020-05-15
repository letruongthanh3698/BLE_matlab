function saving_fig( name,saving )
%SAVE_FIG Summary of this function goes here
%   Detailed explanation goes here
    if saving==1
        saveas(gcf,name,'fig')
        saveas(gcf,name,'jpg')
    end
end

