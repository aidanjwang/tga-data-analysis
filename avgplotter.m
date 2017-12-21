function avgplotter(file1,file2,file3,titlename)

% extract csv data
A = csvread(file1,1,0);
B = csvread(file2,1,0);
C = csvread(file3,1,0);
A=A(1:find(A(:,2)<0.005,1)+5,:);
B=B(1:find(B(:,2)<0.005,1)+5,:);
C=C(1:find(C(:,2)<0.005,1)+5,:);
A(:,2)=100*A(:,2)/A(1,2); % convert weights to weight%
B(:,2)=100*B(:,2)/B(1,2);
C(:,2)=100*C(:,2)/C(1,2);

% bin weight% by temp, then get avg weight%
Abin=myBin(A);
Bbin=myBin(B);
Cbin=myBin(C);
D=[Abin;Bbin;Cbin];
Dbin = [];
x = D(:,1);
for i = 30:0.3:800
    if find(x>=i & x<(i+0.3))~=0
        Dbin = [Dbin; i,mean(D(find(x>=i & x<(i+0.3)),2))];
    end
end

% bin deriv of weight% by temp, then get avg deriv of weight%
Ader = A;
Ader(:,2)=[diff(A(:,2))./diff(A(:,1));0];
Bder = B;
Bder(:,2)=[diff(B(:,2))./diff(B(:,1));0];
Cder = C;
Cder(:,2)=[diff(C(:,2))./diff(C(:,1));0];
Ader(:,2) = mySmoothing(Ader(:,2));
Bder(:,2) = mySmoothing(Bder(:,2));
Cder(:,2) = mySmoothing(Cder(:,2));
Aderbin=myBin(Ader);
Bderbin=myBin(Bder);
Cderbin=myBin(Cder);
Dder=[Aderbin;Bderbin;Cderbin];
Dderbin = [];
y = Dder(:,1);
for i = 30:0.3:800
    if find(y>=i & y<(i+0.3))~=0
        Dderbin = [Dderbin; i,mean(Dder(find(x>=i & x<(i+0.3)),2))];
    end
end

% assign variables
Dtemp=Dbin(:,1);
Dweight=Dbin(:,2);
Ddertemp=Dderbin(:,1);
Dderweight=Dderbin(:,2);
Dweight=mySmoothing(Dweight);
Dderweight=mySmoothing(Dderweight);

% plot functions
figure
yyaxis left
plot(Dtemp,Dweight,'b','LineWidth',1.25)
ylabel('Weight %')
ax = gca;
ax.YColor = 'k';
ax.YLim = [-45 105];
yyaxis right
plot(Ddertemp,Dderweight,'b','LineWidth',1.25)
ylabel('Derivative of Weight % (%/min)')
ax = gca;
ax.YLim = [-45 105];
ax.YColor = 'k';
title(titlename)
xlabel(['Temperature (',char(0176),'C)'])
x1=[0.5,0.5];
y1=[0.8,0.85];
annotation('textarrow',x1,y1,'String','Weight %');
x2=[0.5,0.5];
y2=[0.4,0.35];
annotation('textarrow',x2,y2,'String','Derivative of Weight %')
end

% subfunctions
function [ysmooth] = mySmoothing(y)
n=4;
ysmooth=y;
for i=1+n:length(y)-n
    ysmooth(i)=mean(y(i-n:i+n));
end
end

function [Abin] = myBin(A)
Abin = [];
x = A(:,5);
for i = 30:0.3:800
    if find(x>=i & x<(i+0.3))~=0
        Abin = [Abin; i,mean(A(find(x>=i & x<(i+0.3)),2))];
    end
end
end