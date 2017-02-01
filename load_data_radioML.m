%% Adam Schoenwald
%	10/6/2016

python_dict = load('RML2016.10a.matlab.mat')
mod_list = {'BPSK','QPSK','QAM64','8PSK','AM_DSB','PAM4','GFSK','CPFSK','WBFM','AM_SSB','QAM16'};
snr_list = -20:2:18;
record_length = 128;
number_records = 1000;
mod_types = 11;
snr_values = length(snr_list );
data_mat = zeros(record_length ,number_records ,snr_values,mod_types );
for mod_ind = 1 : size(mod_list,2)
    this_mod_str = mod_list{mod_ind};
    mod_field = ['mod_' this_mod_str];
    for snr_ind = 1 : length(snr_list)
        this_snr = snr_list(snr_ind);
        snr_field = ['snr_' num2str(this_snr)];
        snr_field  = strrep(snr_field ,'-','n');
        full_field = [mod_field '_' snr_field ];
        this_data = python_dict().(full_field);
        complex_data = squeeze(this_data(:,1,:) + 1j*this_data(:,2,:)).';
        data_mat(1:record_length,1:number_records,snr_ind ,mod_ind) = complex_data;
    end
end
dataset.modulations = mod_list;
dataset.snr_list = snr_list;
dataset.values = data_mat;
dataset.name = 'RML2016.10a';

save('RML2016.10a.mat','dataset')
