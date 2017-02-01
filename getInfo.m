function[data,lables]=getInfo(src,data_set)
data=zeros(1,1);
lables=zeros(1,1);
for i=1:length(data_set)
    data(i)=src.files(data_set(:,i));
    lables(i)=src.objects(data_set(i)).class;
end
end