function plotter9(file1,file2,file3,file4,file5,file6,file7,file8,file9,titlename,legend1,legend2,legend3,legend4,legend5,legend6,legend7,legend8,legend9)

% extract csv data
A = csvread(file1,1,0);
B = csvread(file2,1,0);
C = csvread(file3,1,0);
D = csvread(file4,1,0);
H = csvread(file5,1,0);
E = csvread(file6,1,0);
F = csvread(file7,1,0);
G = csvread(file8,1,0);
I = csvread(file9,1.0);
if find(A(:,2)<0)~=0
    A=A(1:find(A(:,2)<0,1),:);
    else
    [~,m]=min(A(1:2432,2));
    A=A(1:m,:);
end

% clean data
if find(E(:,2)<0)~=0
    E=E(1:find(E(:,2)<0,1),:);
    else
    [~,m]=min(E(1:2432,2));
    E=E(1:m,:);
end
if find(F(:,2)<0)~=0
    F=F(1:find(F(:,2)<0,1),:);
    else
    [~,m]=min(F(1:2432,2));
    F=F(1:m,:);
end
if find(G(:,2)<0)~=0
    G=G(1:find(G(:,2)<0,1),:);
    else
    [~,m]=min(G(1:2432,2));
    G=G(1:m,:);
end
if find(I(:,2)<0)~=0
    I=I(1:find(I(:,2)<0,1),:);
    else
    [~,m]=min(I(1:2432,2));
    I=I(1:m,:);
end

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
Dtemp = D(:,5);
Dweight = 100*D(:,2)/D(1,2);
Dtime = D(:,1);
Dderivative = diff(Dweight)./diff(Dtime);
Etemp = E(:,5);
Eweight = 100*E(:,2)/E(1,2);
Etime = E(:,1);
Ederivative = diff(Eweight)./diff(Etime);
Ftemp = F(:,5);
Fweight = 100*F(:,2)/F(1,2);
Ftime = F(:,1);
Fderivative = diff(Fweight)./diff(Ftime);
Gtemp = G(:,5);
Gweight = 100*G(:,2)/G(1,2);
Gtime = G(:,1);
Gderivative = diff(Gweight)./diff(Gtime);
Htemp = H(:,5);
Hweight = 100*H(:,2)/H(1,2);
Htime = H(:,1);
Hderivative = diff(Hweight)./diff(Htime);
Itemp = I(:,5);
Iweight = 100*I(:,2)/I(1,2);
Itime = I(:,1);
Iderivative = diff(Iweight)./diff(Itime);
Aderivative = mySmoothing(Aderivative);
Bderivative = mySmoothing(Bderivative);
Cderivative = mySmoothing(Cderivative);
Dderivative = mySmoothing(Dderivative);
Ederivative = mySmoothing(Ederivative);
Fderivative = mySmoothing(Fderivative);
Gderivative = mySmoothing(Gderivative);
Hderivative = mySmoothing(Hderivative);
Iderivative = mySmoothing(Iderivative);

% plot functions
figure
fig = gcf;
fig.Position = [100 100 1100 500]
box on
hold on
yyaxis left
plot(Atemp,Aweight,'--k',Btemp,Bweight,'-b',Ctemp,Cweight,'-r',Dtemp,Dweight,'-g',Htemp,Hweight,'-m','LineWidth',1.25)
plot(Etemp,Eweight,'Linestyle','-','Color',[0.7 0.7 1],'LineWidth',1.25)
plot(Ftemp,Fweight,'Linestyle','-','Color',[1 0.7 0.7],'LineWidth',1.25)
plot(Gtemp,Gweight,'Linestyle','-','Color',[0.7 1 0.7],'LineWidth',1.25)
plot(Itemp,Iweight,'Linestyle','-','Color',[1 0.7 1],'LineWidth',1.25)
ylabel(['Weight %'])
ax = gca;
ax.YColor = 'k';
ax.YLim = [-45 105];
yyaxis right
plot(Atemp(1:end-1),Aderivative,'--k',Btemp(1:end-1),Bderivative,'-b',Ctemp(1:end-1),Cderivative,'-r',Dtemp(1:end-1),Dderivative,'-g',Htemp(1:end-1),Hderivative,'-m','LineWidth',1.25)
plot(Etemp(1:end-1),Ederivative,'Linestyle','-','Color',[0.7 0.7 1],'LineWidth',1.25)
plot(Ftemp(1:end-1),Fderivative,'Linestyle','-','Color',[1 0.7 0.7],'LineWidth',1.25)
plot(Gtemp(1:end-1),Gderivative,'Linestyle','-','Color',[0.7 1 0.7],'LineWidth',1.25)
plot(Itemp(1:end-1),Iderivative,'Linestyle','-','Color',[1 0.7 1],'LineWidth',1.25)
ylabel(['Derivative of Weight % (%/min)'])
ax = gca;
ax.YLim = [-45 105];
ax.YColor = 'k';
ax.XLim = [-inf 700];
% title(titlename)
xlabel(['Temperature (',char(0176),'C)'])
if nargin==19 %add legend
    legend(legend1,legend2,legend3,legend4,legend5,legend6,legend7,legend8,legend9,'Location','southoutside','Orientation','horizontal') 
end
legend boxoff
x1=[0.4,0.4];
y1=[0.8,0.85];
annotation('textarrow',x1,y1,'String','Weight %');
x2=[0.4,0.4];
y2=[0.55,0.5];
annotation('textarrow',x2,y2,'String','Derivative of Weight %')
print(titlename,'-dpng','-r600')
end

function [ysmooth] = mySmoothing(y)
n=4;
ysmooth=y;
for i=1+n:length(y)-n
    ysmooth(i)=mean(y(i-n:i+n));
end
end