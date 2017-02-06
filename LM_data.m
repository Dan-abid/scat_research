clear all;
load('data.mat');
[set,set_name]=reorderset(database,database_name);
[train_set, test_set,ind,test_data,test_data_name,train_data,train_data_name]= partition_LM(set,set_name, .8);
x=train_data{1,1};
for t=1:length(x)
    shift(t) = exp(-1j*2*pi*10^4*10^-8*t);
    xdft(t) = x(t)*shift(t);
end
count=0;
x=10;
for i=1:x
    sub(i,:)=xdft(count+1:count+x);
    count=count+x;
end
for m=1:x
    other_dat(:,m)=abs(fft(sub(:,m)));
end
figure
colormap 'jet'
imagesc(other_dat);
colorbar