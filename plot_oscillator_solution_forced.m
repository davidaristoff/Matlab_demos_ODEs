%define time step, dt, total number of steps, N, and vector of times, ts
N = 6*10^4; dt = 0.001; ts = 0:dt:(N-1)*dt;

%define parameters and initial conditions
m = 1; gam = 0; k = 1; bta = 1; u0 = 0; v0 = 0; close all

%use ''phase space representation'' to reduce system to first order
du = @(u,v) v;
dv = @(u,v,t) -(gam/m)*v - (k/m)*u + 0.5*cos(bta*t);

%use Runge-Kutta method to numerically solve the system
us = zeros(N,1); vs = zeros(N,1); u = u0; v = v0; 
for n=1:N
    us(n) = u; vs(n) = v; t = (n-1)*dt;
    ku1 = dt*du(u,v); kv1 = dt*dv(u,v,t);
    ku2 = dt*du(u+0.5*ku1,v+0.5*kv1); kv2 = dt*dv(u+0.5*ku1,v+0.5*kv1,t);
    ku3 = dt*du(u+0.5*ku2,v+0.5*kv2); kv3 = dt*dv(u+0.5*ku2,v+0.5*kv2,t);
    ku4 = dt*du(u+ku3,v+kv3); kv4 = dt*dv(u+ku3,v+kv3,t);
    u = u+(ku1+2*ku2+2*ku3+ku4)/6;
    v = v+(kv1+2*kv2+2*kv3+kv4)/6;
end

close all; set(groot,'defaultTextInterpreter','latex');
figure('DefaultAxesFontSize',18);
plot(ts,us,'-b'); hold on; plot([0 N*dt],[0 0],'-.r'); 
xlabel('$t$'); ylabel('$u(t)$');