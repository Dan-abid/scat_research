function [train_set, test_set] = partition(src, ratio)
rng(5);
train_set = [];
test_set = [];
ind = src(randperm(length(src)),:);
n_train = round(ratio(1)*length(ind));
n_test = length(ind)-n_train;
train_set = [train_set ind(1:n_train,:)];
test_set = [test_set ind(n_train+1:n_train+n_test,:)];
end