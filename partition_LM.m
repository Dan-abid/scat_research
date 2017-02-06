function [train_set, test_set,ind,test_data,test_data_name,train_data,train_data_name] = partition_LM(src,set_name, ratio)
rng(5);
train_set = [];
test_set = [];
ind=1:length(set_name);
ind=ind(randperm(length(ind)));
n_train = round(ratio(1)*length(ind));
n_test = length(ind)-n_train;
train_set = [train_set ind(1:n_train)];
test_set = [test_set ind(n_train+1:n_train+n_test)];
for i=1:length(train_set)
    train_data_name(i)=set_name(train_set(i));
    train_data(i)=src(train_set(i));
end
for i=1:length(test_set)
    test_data_name(i)=set_name(test_set(i));
    test_data(i)=src(test_set(i));
end