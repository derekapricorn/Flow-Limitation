function [r,p] = plot4report(x,y,ax,ay,N)
%plot 2-D graph used in the report format, with N degress of interpolation,
%assuming normal distribution
%inputs: x,y,x-axis name,y-axis name,order of interpolation
X = x*100;
Y = y*100;
[r,p] = corr(X.^N,Y);
figure
set(plot(X,Y,'o'),'Markersize',7,'Linewidth',3,'Color','r','MarkerFaceColor','r')%plot the original scatterplot
hold on

margin = 0.1 * (max(X) - min(X));%plot the interpolating curve
xx = min(X)-margin:margin/50:max(X)+margin;
t = polyfit(X,Y,N);
set(plot(xx,polyval(t,xx),'b'),'Linewidth',3)

hold off
set(gca,'Fontsize',16,'Fontweight','Bold')
set(xlabel(ax),'Fontsize',16,'Fontweight','Bold')
set(ylabel(ay),'Fontsize',16,'Fontweight','Bold')
axis tight
set(text(0,32.5,sprintf('r = %1.2f \np = %1.3f',r,p)),'Fontsize',16,'Fontweight','Bold')
%set(gca,'XLim',[xx(1),xx(end)],'YLim',[min(Y),max(Y)])  % use this line
%only when necessary

%saveas(gcf,'UAXSA-Flatten-Per','tif')
%title('Second-Order Correlation')

end

%some sample code for NC, NFV and XSA
% [r,p] = plot4report(dNC,flatten_nrem2,'\DeltaNC, %','Flow-limited Inspirations, %',1)
% [r,p] = plot4report(dXSA(3:end),flatten_nrem2(3:end),'\DeltaUA-XSA, %','Flow-limited Inspirations, %',1)
% [r,p] = plot4report(dNFV,flatten_nrem2,'\DeltaNFV, %','Flow-limited Inspirations, %',1)
% [r,p] = plot4report(PreXSA(3:end),flatten(3:end),'Baseline UA-XSA, mm^{2}','Flow-limited Inspirations, %',1)

%output annotation results
% xx = type_cell_dzn_tp_2;
% counter = 0;
% for ii = 1:length(xx)
%     if strcmp(xx{ii},'Intermediate')
% %     if ~(strcmp(xx{ii},'Unknown')||strcmp(xx{ii},'Low signal'))
%         counter = counter + 1;
%     end
% end
% counter 
