load('data.mat');
[set,set_name]=reorderset(database,database_name);
[train_set, test_set,ind,test_data,test_data_name,train_data,train_data_name]= partition_LM(set,set_name, .8);
x=train_data{1,1};
for t=1:length(x)
    shift(t) = exp(-1j*2*pi*10^4*10^-6*t);
    xdft(t) = x(t)*shift(t);
end
count=0;
for i=1:10
    sub(i,:)=xdft(count+1:count+10);
    count=count+10;
end
for m=1:10
    other_dat(:,m)=abs(fft(sub(:,m)));
end
figure
colormap 'jet'
imagesc(other_dat);
colorbar