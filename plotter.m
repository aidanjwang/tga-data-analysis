function plotter(file1,file2,file3,titlename,legend1,legend2,legend3)

% extract csv data
A = csvread(file1,1,0);
B = csvread(file2,1,0);
C = csvread(file3,1,0);

% assign variables
Atemp = A(:,5);
Aweight = 100*A(:,2)/A(1,2);
Atime = A(:,1);
Aderivative = diff(Aweight)./diff(Atime);
Btemp = B(:,5);
Bweight = 100*B(:,2)/B(1,2);
Btime = B(:,1);
Bderivative = diff(Bweight)./diff(Btime);
Ctemp = C(:,5);
Cweight = 100*C(:,2)/C(1,2);
Ctime = C(:,1);
Cderivative = diff(Cweight)./diff(Ctime);
Aderivative = mySmoothing(Aderivative);
Bderivative = mySmoothing(Bderivative);
Cderivative = mySmoothing(Cderivative);

% plot functions
figure
yyaxis left
plot(Atemp,Aweight,'-r',Btemp,Bweight,'-b',Ctemp,Cweight,'-g','LineWidth',1.25)
ylabel(['Weight % (',char(177),'0.02%)'])
ax = gca;
ax.YColor = 'k';
ax.YLim = [-45 105];
yyaxis right
plot(Atemp(1:end-1),Aderivative,'-r',Btemp(1:end-1),Bderivative,'-b',Ctemp(1:end-1),Cderivative,'-g','LineWidth',1.25)
ylabel(['Derivative of Weight % (%/min, ',char(177),'0.02%/min)'])
ax = gca;
ax.YLim = [-45 105];
ax.YColor = 'k';
title(titlename)
xlabel(['Temperature (',char(0176),'C, ',char(177),'0.4',char(0176),'C)'])
if nargin==7 %add legend
    legend(legend1,legend2,legend3,'Location','southwest') 
end
x1=[0.5,0.5];
y1=[0.8,0.85];
annotation('textarrow',x1,y1,'String','Weight %');
x2=[0.5,0.5];
y2=[0.45,0.4];
annotation('textarrow',x2,y2,'String','Derivative of Weight %')
end

function [ysmooth] = mySmoothing(y)
n=4;
ysmooth=y;
for i=1+n:length(y)-n
    ysmooth(i)=mean(y(i-n:i+n));
end
end