function L = get_aal_labels(p)

% For Neurosematic project with SPM2-processed data (60WP and later),
% with 3x3x6 voxels in MNI space
%
% Get AAL labels for an array of N MNI points (mm)
% p - Nx3 array of MNI points 
% L - 1xN cell array of AAL labels
%
% For example,
% for MNI points p = [-32 -42 -18; 16 -54 14; -40 -100 30],
% the AAL labels L = {'Fusiform_L', 'Precuneus_R', 'Not_labelled'}

% atlas location *******modify during the installation*******


load ccbi_aal_atlas.mat;
%atlas = 'ccbi_aal_atlas.mat';
%load(atlas);

% get labels
%label = {};
vinv2 = [0.500000000000000,0,0,46;0,0.500000000000000,0,64;0,0,0.500000000000000,37;0,0,0,1];

for j = 1:size(p,1),
	pv(j,:) = round([p(j,:) 1] * vinv2');
	z(j) = Y(pv(j,1), pv(j,2), pv(j,3));
	L{j} = label{find(id==z(j))};
end
