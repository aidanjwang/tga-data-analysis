function plotdata = avgplotter6(file1,file2,file3,file4,file5,file6,file7,file8,file9,file10,file11,file12,titlename,legend1,legend2,legend3,legend4,legend5,legend6)

% extract csv data
files = {file1,file2,file3,file4,file5,file6,file7,file8,file9,file10,file11,file12};
data = cell(1,12);
for i = 1:12
    data{1,i}=csvread(files{1,i},1,0);
    if find(data{1,i}(:,2)<0.005)~=0
        data{1,i}=data{1,i}(1:find(data{1,i}(:,2)<0.009,1)+10,:);
    else
        [~,m]=min(data{1,i}(1:1900,2));
        data{1,i}=data{1,i}(1:m,:);
    end
    data{1,i}(:,2)=100*data{1,i}(:,2)/data{1,i}(1,2); % convert weights to weight%
end

% bin weight% by temp, then get avg weight%
databin = cell(1,12);
for i = 1:12
    databin{1,i}=myBin(data{1,i});
end
datas = cell(1,6);
dataavg = cell(1,6);
for i = 1:6
    datas{1,i}=[databin{1,2*i-1};databin{1,2*i}];
    x=datas{1,i}(:,1);
    for j = 30:0.3:800
        if find(x>=j & x<(j+0.3))~=0
            dataavg{1,i}=[dataavg{1,i}; j,mean(datas{1,i}(find(x>=j & x<(j+0.3)),2))];
        end
    end
end

% bin deriv of weight% by temp, then get avg deriv of weight%
datader = data;
dataderbin = cell(1,12);
for i=1:12
    datader{1,i}(:,2)=[diff(datader{1,i}(:,2))./diff(datader{1,i}(:,1));0];
    datader{1,i}(:,2)=mySmoothing(datader{1,i}(:,2));
    dataderbin{1,i}=myBin(datader{1,i});
end
dataders = cell(1,6);
dataderavg = cell(1,6);
for i = 1:6
    dataders{1,i}=[dataderbin{1,2*i-1};dataderbin{1,2*i}];
    y=dataders{1,i}(:,1);
    for j = 30:0.3:800
        if find(y>=j & y<(j+0.3))~=0
            dataderavg{1,i}=[dataderavg{1,i}; j,mean(dataders{1,i}(find(y>=j & y<(j+0.3)),2))];
        end
    end
end

% assign variables
plotdata = cell(1,24);
for i=1:6
    plotdata{1,4*i-3}=dataavg{1,i}(:,1); % temp
    plotdata{1,4*i-2}=mySmoothing(dataavg{1,i}(:,2)); % weight%
    plotdata{1,4*i-1}=dataderavg{1,i}(:,1); % derivative temp
    plotdata{1,4*i}=mySmoothing(dataderavg{1,i}(:,2)); % derivative
end

% plot data
figure
yyaxis left
plot(plotdata{1,1},plotdata{1,2},'--k',plotdata{1,5},plotdata{1,6},'-b',plotdata{1,9},plotdata{1,10},'-r',plotdata{1,13},plotdata{1,14},'-g',plotdata{1,17},plotdata{1,18},'-m',plotdata{1,21},plotdata{1,22},'-c','LineWidth',1.25)
ylabel(['Weight %'])
ax = gca; ax.YColor = 'k'; ax.YLim = [-45 105];
yyaxis right
plot(plotdata{1,3},plotdata{1,4},'--k',plotdata{1,7},plotdata{1,8},'-b',plotdata{1,11},plotdata{1,12},'-r',plotdata{1,15},plotdata{1,16},'-g',plotdata{1,19},plotdata{1,20},'-m',plotdata{1,23},plotdata{1,24},'-c','LineWidth',1.25)
ylabel(['Derivative of Weight % (%/min)'])
ax = gca; ax.YLim = [-45 105]; ax.YColor = 'k';
title(titlename)
xlabel(['Temperature (',char(0176),'C)'])
legend(legend1,legend2,legend3,legend4,legend5,legend6,'Location','southwest')
x1=[0.5,0.5]; y1=[0.75,0.8];
annotation('textarrow',x1,y1,'String','Weight %');
x2=[0.5,0.5]; y2=[0.45,0.4];
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