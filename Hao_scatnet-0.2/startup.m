%%2016-11-30 by Hao Chen
%This is a pipeline leaking detection program

clear
clc
close all

%RESULT = input('input 1 or 2 dimention : ');
global Global_N
Global_N=2;
% proportion of training example
prop = 0.5;                                                                                           
% dimension of the affine pca classifier
train_opt.dim = 1;

%% Strategy 1 Using 2D walelet but 1D signal as [1,100] - err 0.12
src = uiuc_src('C:\Users\HaoChris\Documents\MATLAB\scatnet-0.2\haomix');
filt_opt.Q = 1; %number of scale per octave

filt_opt.J = 2; % J in the paper
filt_opt.L = 1; % K in the paper for the rotation
scat_opt.M = 2; % m layers

%hao how many layers and filter parameters, filter size and type
% Wop = wavelet_factory_2d([480, 640], filt_opt, scat_opt);
Wop = wavelet_factory_2d([4,Global_N], filt_opt, scat_opt);
features{1} = @(x)(sum(sum(format_scat(scat(x,Wop)),2),3));

%1 is doing parallel, 0 is not parallel computing
options.parallel = 0;

db = haoprepare_database2d(src, features, options);




% split between training and testing
[train_set, test_set] = create_partition(src, prop);

% training
model = affine_train(db, train_set, train_opt);
% testing
labels = affine_test(db, model, test_set);
% compute the error
error2layers = classif_err(labels, test_set, src);

%     %one layer
%     clear db train_set features model labels test_set train_set
%     Wop{3}=[];
%     id = cellfun('length',Wop);
%     Wop(id==0)=[];
%     features{1} = @(x)(sum(sum(format_scat(scat(x,Wop)),2),3));
%     db = haoprepare_database2d(src, features, options);
%     [train_set, test_set] = create_partition(src, prop);
%     
%     model = affine_train(db, train_set, train_opt);
%     labels = affine_test(db, model, test_set);
%     error1layer = classif_err(labels, test_set, src);
% 
% %just the signal
% clear db train_set features model labels test_set train_set
% Wop{2}=[];
% id = cellfun('length',Wop);
% Wop(id==0)=[];
% features{1} = @(x)(sum(sum(format_scat(scat(x,Wop)),2),3));
% db = haoprepare_database2d(src, features, options);
% [train_set, test_set] = create_partition(src, prop);
% 
% model = affine_train(db, train_set, train_opt);
% labels = affine_test(db, model, test_set);
% errorSignal = classif_err(labels, test_set, src);

    load handel
    sound(y,Fs)

figure
for ii=1:25:500
    hold on
    plot(db.features(:,ii))
end