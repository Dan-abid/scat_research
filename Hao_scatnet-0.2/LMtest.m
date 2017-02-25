% 2017-02-14 by Hao Chen, 
% test data for LM 
run('.\addpath_scatnet.m')
%% Basic set up
global Global_N
Global_N=1e6;
% proportion of training example
prop = 0.5;                                                                                           
% dimension of the affine pca classifier
train_opt.dim = 3;
% Sound files will be truncated to 5*2^17 samples by default, so let's define
% the filters for this length.
N = 5*2^17;
% Calculate coefficients with averaging scale of 8192 samples (~370 ms @
% 22050 Hz sampling rate).
T = 8192;
% First-order filter bank with 8 wavelets per octave. Second-order filter bank
% with 1 wavelet per octave.
filt_opt.Q = [8 1];
% Calculate maximal wavelet scale so that largest wavelet will be of bandwidth 
% T.
filt_opt.J = T_to_J(T, filt_opt);
filt_opt.J = 5; % J in the paper

filt_opt.Q = 6; %number of scale per octave Q<J
filt_opt.L = 1; % K in the paper for the rotation
scat_opt.M = 2; % m layers

%% Processing data

src = gtzan_src('.\haomix');
% Prepare wavelet transforms to be used for scattering.
Wop = wavelet_factory_1d(N, filt_opt, scat_opt);

% Define feature function, taking a signal as input and returning a table
% of feature vectors.
feature_fun = @(x)(format_scat(log_scat(renorm_scat(scat(x, Wop)))));

% Only store every eighth feature vector (to reduce training complexity 
% later).
database_options.feature_sampling = 8;

% Calculate feature vectors for all files in src using feature_fun.
database = haoprepare_database(src, feature_fun, database_options);

%% PCA Classification
%1 is doing parallel, 0 is not parallel computing
options.parallel = 0;

db= database;
% split between training and testing
[train_set, test_set] = create_partition(src, prop);
% dimension of the affine pca classifier
train_opt.dim = 20;
% training
model = affine_train(db, train_set, train_opt);
% testing
labels = affine_test(db, model, test_set);
% compute the error
error = classif_err(labels, test_set, src);


load handel
sound(y,Fs)

%% SVM Classification
