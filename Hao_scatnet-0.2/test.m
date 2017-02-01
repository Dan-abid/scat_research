%%2016-1-11 by Hao Chen
%This is a pipeline leaking detection program
addpath_scatnet
clear
clc
close all

%RESULT = input('input 1 or 2 dimention : ');
global Global_N
Global_N=100; % the length L
% proportion of training example
prop = 0.5;                                                                                           

src = uiuc_src1d('C:\Users\HaoChris\Documents\MATLAB\scatnet-0.2\haomix');
filt_opt.Q = 1; %number of scale per octave

filt_opt.J = 3; % J in the paper
filt_opt.L = 1; % K in the paper for rotation
scat_opt.M = 2; % m layers

%hao how many layers and filter parameters, filter size and type
% Wop = wavelet_factory_2d([480, 640], filt_opt, scat_opt);
Wop = wavelet_factory_2d([1,Global_N], filt_opt, scat_opt);
features{1} = @(x)(sum(sum(format_scat(scat(x,Wop)),2),3));

%1 is doing parallel, 0 is not parallel computing
options.parallel = 0;

db = haoprepare_database1d(src, features, options, 1);
for ii=3:2:8
    db0 = haoprepare_database1d(src, features, options,ii);
    db.features =[db.features; db0.features];
end
%% energy detection if needed
% N=200;
% for k=1:500
%     load('openleak.mat');%hao load data
%     load('opennoleak.mat');%hao load data
%     start=randi([1,20000],1);
%     if k<251
%         x(:,k)=[sum(opennoleak(start:start+N-1,1).^2);sum(opennoleak(start:start+N-1,2).^2);...
%             sum(opennoleak(start:start+N-1,3).^2);sum(opennoleak(start:start+N-1,4).^2);];%hao        
%     else
%         x(:,k)=[sum(openleak(start:start+N-1,1).^2);sum(openleak(start:start+N-1,2).^2);...
%             sum(openleak(start:start+N-1,3).^2);sum(openleak(start:start+N-1,4).^2);];%hao
%     end 
% end
% db.features=x;

%% PCA classifier
% dimension of the affine pca classifier
train_opt.dim = 3;

% split between training and testing
[train_set, test_set] = create_partition(src, prop);

% training 
model = affine_train(db, train_set, train_opt);
% testing
labels = affine_test(db, model, test_set);
% compute the error
error2layers = classif_err(labels, test_set, src);

%% SVM classifying

% when it is done, playing a song
load handel
sound(y,Fs)

figure
for ii=1:25:500
    hold on
    plot(db.features(:,ii))
end
