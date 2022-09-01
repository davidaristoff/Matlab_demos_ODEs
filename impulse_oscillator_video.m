%define parameters; close current figures
omega = 1; omega_f = 2*pi/omega; close all

%define solution function
u = @(t) 0 + ... (1/omega)*sin(omega*t) ... 
        + (1/omega)*sin(omega*(t-omega_f)).*heaviside(t-omega_f) ... 
        + (1/omega)*sin(omega*(t-2*omega_f)).*heaviside(t-2*omega_f) ... 
        + (1/omega)*sin(omega*(t-3*omega_f)).*heaviside(t-3*omega_f) ... 
        + (1/omega)*sin(omega*(t-4*omega_f)).*heaviside(t-4*omega_f) ... 
        + (1/omega)*sin(omega*(t-5*omega_f)).*heaviside(t-5*omega_f) ... 
        + (1/omega)*sin(omega*(t-6*omega_f)).*heaviside(t-6*omega_f);

%define discrete solution
dt = 0.02; T = 6*omega_f; ts = 0:dt:T; us = u(ts); N = length(ts); 

%create video
plot(0,0,'sk','markersize',10,'markerfacecolor','k')
axis([-1.2 1.2 -2 1.2])
axis square; ax1 = gca; hold on

axes('Position',[.3 .7 .5 .2]); box on
line([0 T*dt],[0 0],'linestyle','-.','color','b')
xlabel('$t$','interpreter','latex','fontsize',14)
ylabel('$\theta(t)$','interpreter','latex','fontsize',14)
xlim([0 T]); a = 8; ylim([-a a]);
ax2 = gca; hold on

spring = []; mass = []; dot = []; curve = []; 
xs = 0:.01:1; ys = sin(15*pi*xs);
for t=1:N
    delete(curve)
    delete(dot)
    curve = plot(ax2,ts(1:t),us(1:t),'-r');
    dot = plot(ax2,t*dt,us(t),'.b','markersize',15,'color','b');
    delete(spring)
    delete(mass)
    spring = plot(ax1,ys,-xs*(a+us(t))/a,'-b');
    mass = plot(ax1,0,-(a+us(t))/a,'.b','markersize',40);
    pause(0.0001)
end

%plot numerical solution against reference solution
%plot(ts,thetas,'-',ts,thetas_ref,'-.'); xlabel('$t$'); ylabel('$\theta$'); 
%legend('numerical solution to (0.2)','reference solution from (0.3)')