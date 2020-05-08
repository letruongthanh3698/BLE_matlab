function slider(count, point, radius, loc, time)
FigH = figure('Name','Simualtion','units','normalized','outerposition',[0 0 1 1]);
hold on
rad   = linspace(0, 2*pi, 360);
axis([-20 30 -20 30]);

set(gca,'xtick',[-20:1:30])
set(gca,'ytick',[-20:1:30])
%axis manual
x={};
y={};
for i=1:1:4
    x{i}=radius(i,1)*sin(rad)+point(i,1);
    y{i}=radius(i,1)*cos(rad)+point(i,2);
end
FillH = fill(x{1},y{1},'r',x{2},y{2},'g',x{3},y{3},'b',x{4},y{4},'y','facealpha',0.3);
plot(point(:,1),point(:,2),'r.','MarkerSize',15);
text(point(1,1),point(1,2),'59','HorizontalAlignment','center');
text(point(2,1),point(2,2),'93','HorizontalAlignment','center');
text(point(3,1),point(3,2),'C2','HorizontalAlignment','center');
text(point(4,1),point(4,2),'C0','HorizontalAlignment','center');
text(point(5,1),point(5,2),'target','HorizontalAlignment','center');
PointH = plot(loc{1}(1),loc{1}(2),'b*','MarkerSize',15);
txt=text(0.5,1.01,datestr(time(1)),'HorizontalAlignment','center','units','normalized');
grid on

SliderH = uicontrol('style','slider','value',1,'SliderStep',[1/count 1],...
    'min', 1, 'max', uint32(count),'units','normalized');

SliderH.Position(3)=FigH.Position(3)-0.1;
addlistener(SliderH, 'Value', 'PostSet', @callbackfn);
movegui(FigH, 'center')
    function callbackfn(source, eventdata)
    num          = round(get(eventdata.AffectedObject, 'Value'));
    for j=1:1:4
        FillH(j).XData=radius(j,num)*cos(rad)+point(j,1);
        FillH(j).YData=radius(j,num)*sin(rad)+point(j,2);
    end
    PointH.XData=loc{num}(1);
    PointH.YData=loc{num}(2);
    txt.String=datestr(time(num));
    end
  end