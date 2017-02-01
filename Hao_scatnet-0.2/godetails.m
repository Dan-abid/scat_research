clear
clc

load('ff.mat')
load('layercoefficient.mat')	
clear U V S

% (filters.psi.meta.j >= U.meta.j(end,p) + filters.meta.Q);
% [U.meta.j(:,p);filters.psi.meta.j(p_psi)]

U{1}.signal{1} = x;
	U{1}.meta.j = zeros(0,1);
	U{1}.meta.q = zeros(0,1);
    U{1}.meta.resolution=0;

	% Apply scattering, order per order
	for m = 1:numel(Wop)

		if (m < numel(Wop))
			[S{m}, V] = Wop{m}(U{m});
			U{m+1} = modulus_layer(V);
        else
			S{m} = Wop{m}(U{m});
        end
    end