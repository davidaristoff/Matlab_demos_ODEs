%define time step, dt, total number of steps, T, and vector of times, ts
dt = 0.005; T = 10^3; ts = 0:dt:(T-1)*dt;

%define parameters g and L and close current figures
g = 9.8; L = 1; damp = 5; close all

%define initial conditions: theta(0) = pi/2 and theta'(0) = 0         
theta0 = 0; v0 = 2;   %v represents the derivative of theta

%create video
plot(0,0,'sk','markersize',10,'markerfacecolor','k')
line([0 0],[-1.2 0],'linestyle','-.','color','b')
axis([-1.2 1.2 -1.2 1.2])
axis square; ax1 = gca; hold on

axes('Position',[.3 .62 .5 .25]); box on
line([0 T*dt],[0 0],'linestyle','-.','color','b')
xlabel('$t$','interpreter','latex','fontsize',14)
ylabel('$\theta(t)$','interpreter','latex','fontsize',14)
xlim([0 T*dt]); ylim([-2 2]);
ax2 = gca; hold on

f = @(theta) -(g/L)*sin(theta);
f1 = @(x1,x2) x2;
f2 = @(x1,x2) -(damp)*x2 - (g/L)*sin(x1);

thetas = zeros(T,1); theta = theta0; v = v0; 
rod = []; ball = []; dot = []; curve = []; 
for t=1:T
    thetas(t) = theta;
    if damp == 0   %do Leapfrog method
        v = v + 0.5*f(theta)*dt;   %half step in velocity
        theta = theta + v*dt;              %full step in position
        v = v + 0.5*f(theta)*dt;   %half step in velocity
    else   %do 4th order Runge-Kutta on equivalent 1st order system
        x1 = theta;
        x2 = v;
        k11 = dt*f1(x1,x2);
        k21 = dt*f2(x1,x2);
        k12 = dt*f1(x1+0.5*k11,x2+0.5*k21);
        k22 = dt*f2(x1+0.5*k11,x2+0.5*k21);
        k13 = dt*f1(x1+0.5*k12,x2+0.5*k22);
        k23 = dt*f2(x1+0.5*k12,x2+0.5*k22);
        k14 = dt*f1(x1+k13,x2+k23);
        k24 = dt*f2(x1+k13,x2+k23);
        theta = x1+(k11+2*k12+2*k13+k14)/6;
        v = x2+(k21+2*k22+2*k23+k24)/6;
    end
    ts_ = 0:dt:(t-1)*dt;
    delete(curve)
    delete(dot)
    curve = plot(ax2,ts_,thetas(1:t),'-r');
    dot = plot(ax2,t*dt,theta,'.b','markersize',15,'color','b');
    delete(rod)
    delete(ball)
    rod = line(ax1,[0 sin(theta)],[0 -cos(theta)],'color','r','linewidth',2);
    ball = plot(ax1,sin(theta),-cos(theta),'.b','markersize',40);
    pause(0.001)
end

%plot numerical solution against reference solution
%plot(ts,thetas,'-',ts,thetas_ref,'-.'); xlabel('$t$'); ylabel('$\theta$'); 
%legend('numerical solution to (0.2)','reference solution from (0.3)')