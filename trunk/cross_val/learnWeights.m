function W = learnWeights(X,F, method, lambda)

%calc
N = size(X,1);
d = size(X,2);


if(method==1)
    %formula for regular type
    W=  inv(X'*X + lambda*eye(d))*X'*F;
end

if(method==2)
    %ridge regression
    W = X'*inv(X*X' + lambda*eye(N))*F;
end