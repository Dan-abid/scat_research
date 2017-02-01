%{
%sig_name = 'mod_AM_DSB_snr_18';
%sig_name = 'mod_AM_SSB_snr_18';
%sig_name = 'mod_PAM4_snr_18';
%sig_name = 'mod_CPFSK_snr_18';
%sig_name = 'mod_GFSK_snr_18';
%sig_name = 'mod_QPSK_snr_18';
%sig_name = 'mod_8PSK_snr_18';
%sig_name = 'mod_QAM16_snr_18';
%sig_name = 'mod_QAM64_snr_18';
%sig_name = 'mod_WBFM_snr_18';
%}
sig_name = 'mod_BPSK_snr_n20';
idx = 1:1000;
%1M samples/second 128 micro seconds i.e 128 samples
load('RML2016.10a.matlab.mat',sig_name);
s = eval(sig_name);
for m=1:length(s)
    s_cmplx(m,:) = double(squeeze(s(idx(m),1,:))+1i*squeeze(s(idx(m),2,:)))';
end
[train_set, test_set] = partition(s_cmplx, .8);
for m=1:20
    %for m=1:10
    x=train_set(m,:);
    %x=[train_set(m,:),train_set(m+1,:)];
    for t=1:length(x)
        shift = exp(-1j*2*pi*10^5*10^-6*t);
        xdft(t) = x(t)*shift;
    end
    shifted(m,:)=xdft;
end
for m=1:128
    input(:,m)=abs(fft(shifted(:,m)));
end
for m=1:20
    input(m,:)=abs(fft(shifted(m,:)));
end
figure
colormap 'jet'
imagesc(input);
colorbar
%{
figure
plot(x(1:100),'k'); hold on;
plot(new_set(m,1:100),'b'); grid on;
legend('Original Signal','Delayed Signal');
%}
%fft each column instead of stft
%for m=1:256

%%time shift
%{
d=2;
y=[ones(1,d)*nan x(1:end-d)];
figure
plot(x,'b');hold on;
plot(y,'r');hold on;
legend('signal',['delayed signal by ' num2str(d) ' units'])
%}