clc
clear

% comparing all Alternatives with respect to on specific Criteria
A_eco=[1.00	3.00	5.00
0.33	1.00	2.00
0.20	0.50	1.00];

A_env=[1.00	2.00	7.00
0.50	1.00	5.00
0.14	0.20	1.00];

A_ns=[1.00	2.00	3.00
0.50	1.00	2.00
0.33	0.50	1.00];

% comparing Criteria together
C=[1.0000	5.0000	3.0000
0.2000	1.0000	0.6000
0.3333	1.6667	1.0000];

norm_A_eco=normalize(A_eco);
norm_A_env=normalize(A_env);
norm_A_ns=normalize(A_ns);

row_av_norm_A_eco=mean(norm_A_eco,2);
row_av_norm_A_env=mean(norm_A_env,2);
row_av_norm_A_ns=mean(norm_A_ns,2);

DM=[row_av_norm_A_eco,row_av_norm_A_env,row_av_norm_A_ns];
W=overall_wight(C);
Final_Weights=DM*W;

a=show_cr(A_eco);
b=show_cr(A_env);
c=show_cr(A_ns);
d=show_cr(C);

function normalized=normalize(PW)
    [i,j]=size(PW);
    normalized=zeros(i,j);
    for x=1:j
        s=sum(PW(:,x));
        for y=1:i
            normalized(y,x)=PW(y,x)/s;
        end
    end
end


function CR=show_cr(m)
   RI=[0,0,0.58,0.9,1.12,1.24,1.32,1.41,1.49];
   n=size(m);
   n=n(1);
   [W,lambda]=eig(m);
   lambda_max=max(max(lambda));
   CI=abs(lambda_max-n)/(n-1);
   CR=CI/RI(n);
end

function w=overall_wight(D)
   n=size(D);
   n=n(1);
   [W,lambda]=eig(D);
   lambda_max=max(max(lambda));
   lambda_max=lambda_max*eye(n);
   x=D-lambda_max;
   cl=ones(n,1);
   rw=[ones(1,n),0];
   A=[[x,cl];rw];
   b=inv(A);
   F=[zeros(n,1);1];
   X=b*F;
   n1=size(X);
   u=n1(1);
   w=X(1:u-1);
end