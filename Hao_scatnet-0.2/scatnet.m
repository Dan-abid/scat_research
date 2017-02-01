close all
clear 
clc

%%
% Fundamentals
% This section describes how to compute the scattering transform of an image
% with as few lines of MATLAB as possible.
% Load an image of reasonable size (e.g. 640x480).
x = uiuc_sample;
imagesc(x);
colormap gray;
% Before computing the scattering coefficients of x, we need to precompute 
%the wavelet transform operators that will be applied to the image. Those 
%operators are built by specific built-in factories adapted to different 
%types of signal. For translation-invariant representation of images, we use wavelet_factory_2d.
Wop = wavelet_factory_2d(size(x));

% Now we call the scat function to compute the scattering of x using those Wop operators.
Sx = scat(x, Wop);

% The variable S is a cell of structure. It is not suited for direct numeric 
%manipulation. You can reformat it in a 3D array using format_scat :
S_mat = format_scat(Sx);

%S_mat is a 417x60x80 matrix. The first dimension in S_mat is the path index, while the second 
% and third dimensions correspond to subsampled spatial coordinates of the original image.
%wavelet_factory_2d_pyramid() may be used instead of wavelet_factory_2d(size(x)). It will use a similar
%yet faster algorithm to compute the scattering coefficients at different scales.

% % the p-th at the m-th layer: 
% Sx{m+1}.signal{p};
% % the sequence of j for p-th coefficient at the m-th order : 
% Sx{m+1}.meta.j(:,p)
% % the sequence of theta for p-th coefficient at the m-th order : 
% Sx{m+1}.meta.theta(:,p)

j1 = 0;
j2 = 2;
theta1 = 1;
theta2 = 5;
p = find( Sx{3}.meta.j(1,:) == j1 & ...
    Sx{3}.meta.j(2,:) == j2 & ...
    Sx{3}.meta.theta(1,:) == theta1 & ...
    Sx{3}.meta.theta(2,:) == theta2 );
figure
imagesc(Sx{3}.signal{p});


%%
% compute scattering with 5 scales, 6 orientations
% and an oversampling factor of 2^2
x = uiuc_sample;
filt_opt.J = 5;
filt_opt.L = 6;
scat_opt.oversampling = 2;
Wop = wavelet_factory_2d(size(x), filt_opt, scat_opt);
Sx = scat(x, Wop);
% display scattering coefficients
colormap gray;
image_scat(Sx)
colormap gray;
%%
image_scat(Sx, false, false);
%%
% compute the filters with 5 scales and 6 orientations
filt_opt.J = 5;
filt_opt.L = 6;
[Wop, filters] = wavelet_factory_2d([512, 512], filt_opt);
% display all the filters
figure
colormap gray;
display_filter_bank_2d(filters);

%% Classifier

src = uiuc_src('C:\Users\HaoChris\Documents\MATLAB\scatnet-0.2\closemat');
filt_opt.J = 5;
scat_opt.oversampling = 0;
% Wop = wavelet_factory_2d([480, 640], filt_opt, scat_opt);
Wop = wavelet_factory_2d([8,8], filt_opt, scat_opt);%hao
features{1} = @(x)(sum(sum(format_scat(scat(x,Wop)),2),3));

options.parallel = 0;
db = prepare_database(src, features, options);

% proportion of training example
prop = 0.5;
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

