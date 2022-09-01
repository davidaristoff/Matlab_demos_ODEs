%define time step, dt, total number of steps, T, and vector of times, ts
dt = 0.001; T = 10^4; ts = 0:dt:(T-1)*dt;

%define parameters g and L and close current figures
m = 1; g = 9.8; L = 1; close all

%define initial conditions: theta(0) = 0.5 and theta'(0) = -0.5        
theta0 = 0.5; v0 = -0.5;   %v represents the derivative of theta

%compute solution vector, thetas, using "leapfrog" numerical integration
thetas = zeros(T,1); vs = zeros(T,1); theta = theta0; v = v0;
for t=1:T
    thetas(t) = theta; vs(t) = v;
    v = v - 0.5*(g/L)*sin(theta)*dt;   %half step in velocity
    theta = theta + v*dt;              %full step in position
    v = v - 0.5*(g/L)*sin(theta)*dt;   %half step in velocity
end

%compute reference solution, which uses the approximation sin(theta)~theta
thetas_ref = theta0*cos(sqrt(g/L)*ts)+(v0/sqrt(g/L))*sin(sqrt(g/L)*ts);

%plot numerical solution against reference solution
plot(ts,thetas,'-',ts,thetas_ref,'-.'); xlabel('t'); ylabel('theta(t)'); 
legend('numerical solution to (0.2)','reference solution from (0.3)')

KEs = 0.5*m*L^2*vs.^2; PEs = -m*g*L*cos(thetas); figure; plot(ts,KEs+PEs,'-ob')