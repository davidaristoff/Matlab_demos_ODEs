%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Analysis of Schlogl simulation data %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load schlogl_data.mat
close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%define loss function, L

L = @(x) -k1*p*x.^3/3 - k3*q*x + k2*x.^4/4 + k4*x.^2/2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%compute and sort eigenvalues and eigenvectors (descending order)

[Xi,r] = eig(Q,'vector');        %compute eigenvectors and eigenvalues
[r,index] = sort(r,'descend');   %sort eigenvalues
Xi = Xi(:,index);                %sort corresponding eigenvectors

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%compare principal eigenvector to histogram of populations

figure                                                       %open figure
histogram(population,0:1:M,'normalization','probability');   %histogram
hold on; plot(Xi(:,1)/sum(Xi(:,1)),'-r')                     %eigenvector

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot eigenvectors and eigenvalues of Q

figure;                                             %open new figure
plot(r(1:10),'ob'); title('eigenvalues')            %first 10 eigenvalues
xlabel('eigenvalue number'); ylabel('numerical value')   %label axes

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%compare exact solution to estimate from top two eigenvectors/eigenvalues

t = 10; x0 = [1;zeros(M,1)];   %time and initial condition
c = Xi\x0;                     %coefficients of solution
xt_exact = sum(c'.*Xi.*exp(r*t)',2);   %this sums over all the eigenvectors              
xt_approx = c(1)*Xi(:,1)*exp(r(1)*t) + c(2)*Xi(:,2)*exp(r(2)*t);

%Note: it looks like to get c(1) and c(2) we need to have all the 
%eigenvectors. However, this is not the case. We can get c(1) and c(2)
%by using the following sequence, which only uses the top two eigenvectors.
%In general, c(1), c(2), ..., c(k) can be obtained from top k eigenvectors.

%xi = Xi(:,1);
%c(1) = (Xi(:,1)./xi)'*x0/sum(Xi(:,1).^2./xi); 
%c(2) = (Xi(:,2)./xi)'*x0/sum(Xi(:,2).^2./xi);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%coarse grain the first two eigenvectors:

i_c = 26;                                       %state boundary 
Xi1 = [sum(Xi(1:i_c,1)); sum(Xi(i_c+1:end,1))];   %coarsen 1st eigenvector
Xi2 = [sum(Xi(1:i_c,2)); sum(Xi(i_c+1:end,2))];   %coarsen 2nd eigenvector

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%create 2-state approximation of the Schlogl model

T = [Xi1 Xi2];          %matrix of eigenvectors
B = [r(1) 0; 0 r(2)];   %diagonal matrix of eigenvalues
A = T*B*inv(T);         %rate matrix built from top two eigenvectors/values

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%