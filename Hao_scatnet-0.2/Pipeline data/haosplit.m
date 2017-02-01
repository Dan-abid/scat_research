clear 
clc
close all

load('closeleak.mat')
load('closenoleak.mat')
load('openleak.mat')
load('opennoleak.mat')
%Matrix length
L=100;
loop=25000/L;

%closeleak
for k=1:loop
    a=closeleak(1+(k-1)*L :L+(k-1)*L);
    fname = strcat('closeleak',num2str(k));
    save(fname,'a');
end
%closenoleak
for k=1:loop
    a=closenoleak(1+(k-1)*L :L+(k-1)*L);
    fname = strcat('closenoleak',num2str(k));
    save(fname,'a');
end
%openleak
for k=1:loop
    a=openleak(1+(k-1)*L :L+(k-1)*L);
    fname = strcat('openleak',num2str(k));
    save(fname,'a');
end
%opennoleak
for k=1:loop
    a=opennoleak(1+(k-1)*L :L+(k-1)*L);
    fname = strcat('opennoleak',num2str(k));
    save(fname,'a');
end


% not working because of lost info
% for k=1:300
%     a{k}=closeleak(1:8,:);
% end
% 
% imwrite(a{1},'myGray.jpg')