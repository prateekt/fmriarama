function [vals,inds] = getTopM(vect,M)

L = length(vect);

%create temp mat
matr = zeros(L,2);
matr(:,1) = vect;
matr(:,2) = 1:L;

%sort
matr = sortrows(matr,-1);
vals = matr(1:M,1);
inds = matr(1:M,2);

