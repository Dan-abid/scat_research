
%path of scatnet
addpath 'C:\Users\ravem\Documents\MATLAB\scatnet-0.2';
addpath_scatnet
% Prepare file index & class assignments.
dataset = load('RML2016.10a.mat');
classes=dataset.dataset.modulations;
class=cell(1,11);
gammas=cell(1,20);
Cs=cell(1,20);
test_errs=cell(1,20);
errs=cell(1,20);
%for i=1:20
    count=0;
    i=10;
    for j=1:11
        for b=1:200
            %see about using 2d or 1d of signal find wavelet for complex signals
            count=count+1;
            files(:,count)=abs(fft(dataset.dataset.values(:,b,i,j)));
            objects(count).ind=count;
            objects(count).u1=1;
            objects(count).u2=128;
            objects(count).class=j;
        end
    end
    % Sound files will be truncated to 5*2^17 samples by default, so let's define
    % the filters for this length.
    field1 = 'classes';
    field4 = 'class';
    field2 = 'files';
    field3 = 'objects';
    for a=1:11
        class{1,a}={a};
    end
    src=struct(field1,{classes},field4,{class},field2,files,field3,objects);
    N = 128;
    % First-order filter bank with 8 wavelets per octave. Second-order filter bank
    % with 1 wavelet per octave.
    filt_opt.K = [3 1];
    filt_opt.J = T_to_J(128, filt_opt);
    % Only calculate scattering coefficients up to second order.
    scat_opt.M = 2;
    
    % Prepare wavelet transforms to be used for scattering.
    Wop = wavelet_factory_1d(N, filt_opt, scat_opt);
    
    % Define feature function, taking a signal as input and returning a table
    % of feature vectors.
    feature_fun = @(x)(format_scat(log_scat(renorm_scat(scat(x, Wop)))));
    
    % Only store every eighth feature vector (to reduce training complexity
    % later).
    database_options.feature_sampling = 11;
    
    % Calculate feature vectors for all files in src using feature_fun.
    database_2 = pre_database(src, feature_fun, database_options);
    
    % Reset random number generator to ensure getting consisten split.
    % Split files into training and testing sets 80-20.
    [train_set2, test_set_2] = create_partition(src, 0.8);
    rng default
    %get training set's data and labels
    %[train_set,train_lables]=getInfo(files,train_set2)
	%trainedNet = trainNetwork(train_set2,Y,layers,options)
	
%end
name='radioML.mat';
save(name,'Cs','errs','gammas','test_errs');