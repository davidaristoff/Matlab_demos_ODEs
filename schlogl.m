%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% SCHLOGL MODEL SIMULATOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%initialize simulation

%define physical constants
p = 1; q = 2; k1 = 3; k2 = 0.6; k3 = 0.25; k4 = 2.95; V = 25;

%define reaction rates
lam1 = @(i) p*k1*i.*(i-1)/V;          %rate A+2S->3S
lam2 = @(i) k2*i.*(i-1).*(i-2)/V^2;   %rate 3S->A+2S
lam3 = @(i) q*k3*V;                   %rate B->S
lam4 = @(i) k4*i;                     %rate S->B

%define simulation parameters
tau = 0.01;            %time step for simulations
N = 10^6;              %number of time steps to simulate

%initialize data vectors
population = zeros(N,1);   %vector of S species populations

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%begin simulation of the Schlogl model (using tau-leaping)

tic

i = 0;   %initial population
for n = 1:N-1

    %display simulation progress
    if floor(n/10^4) == n/10^4
        X = ['percent complete = ...', num2str(n/N)]; disp(X);
    end

    %simulate next time step
    i_inc = poissrnd(tau*(lam1(i) + lam3(i)));
    i_dec = poissrnd(tau*(lam2(i) + lam4(i)));
    i = max(i + i_inc - i_dec, 0); 

    %record current population
    population(n) = i;

end

toc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%plot the Schlogl model simulation results

plot(0:tau:(N-1)*tau,population,'-b')
xlabel('time t'); ylabel('population of species S')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%construct rate matrix, Q, for the Schlogl model

M = 180;   %choose cutoff, or maximum value of population

Q = zeros(M+1,M+1);   %initialize rate matrix
for i=0:M-1
    Q(i+2,i+1) = lam1(i) + lam3(i);   %total rate to increase i
end
for i=1:M
    Q(i,i+1) = lam2(i) + lam4(i);     %total rate to decrease i
end
Q = Q - diag(sum(Q,1));   %diagonal adjustment

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%save data to Matlab workspace

save schlogl_data.mat