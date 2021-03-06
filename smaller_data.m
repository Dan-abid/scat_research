clear all;
sig_name = 'mod_BPSK_snr_10';
idx = 1:1000;
%1M samples/second 128 micro seconds i.e 128 samples
load('RML2016.10a.matlab.mat',sig_name);
s = eval(sig_name);
for m=1:length(s)
    s_cmplx(m,:) = double(squeeze(s(idx(m),1,:))+1i*squeeze(s(idx(m),2,:)))';
end
[train_set, test_set] = partition(s_cmplx, .8);
x=train_set(10,:);
for t=1:length(x)
    shift(t) = exp(-1j*2*pi*10^4*10^-6*t);
    xdft(t) = x(t)*shift(t);
end
count=0;
x=10;
for i=1:x
    sub(i,:)=xdft(count+1:count+x);
    count=count+x;
end
for m=1:x
    other_dat(:,m)=abs(fft(sub(:,m)));
end
figure
colormap 'jet'
imagesc(other_dat);
colorbar