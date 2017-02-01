clear
clc

load('closeleak.mat');%hao load data
load('closenoleak.mat');%hao load data
load('openleak.mat');%hao load data
load('opennoleak.mat');%hao load data

N=100;

for k=1:500
    start=randi([1,20000],1);
      if k<251
        x(:,k)=opennoleak(start:start+N-1,1);%hao
    else
        x(:,k)=openleak(start:start+N-1,1);%hao   
      end 
end
Ener=1/N*(x.*x);


function mu = sig_mean(x)
	% Calculate mean along second dimension.

    C = size(x,2);
    
    mu = x*ones(C,1)/C;
end

function [u,s] = sig_pca(x,M)
	% Calculate the principal components of x along the second dimension.

	if nargin > 1 && M > 0
		% If M is non-zero, calculate the first M principal components.
	    [u,s,v] = svds(x-sig_mean(x)*ones(1,size(x,2)),M);
	    s = abs(diag(s)/sqrt(size(x,2)-1)).^2;
	else
		% Otherwise, calculate all the principal components.
		[u,d] = eig(cov(x'));
		[s,ind] = sort(diag(d),'descend');
		u = u(:,ind);
    end
    save('u.mat')
end