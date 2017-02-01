close all
	load('closeleak.mat');%hao load data
    load('closenoleak.mat');%hao load data
    load('openleak.mat');%hao load data
    load('opennoleak.mat');%hao load data
figure
for ii=1:25:250
    ii
    hold on
    plot(db.features(:,ii))
end
figure
for ii=251:25:500
    ii
    hold on
    plot(db.features(:,ii))
end