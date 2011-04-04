function F = predictF(X,W)
F = X*W;

%normalize rows of F
for i=1:size(F,1)
    F(i,:) = F(i,:)/sqrt(sum(F(i,:).^2));    
end