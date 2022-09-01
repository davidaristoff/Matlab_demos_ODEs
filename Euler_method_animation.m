%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%animation of Euler's method for dy/dt = f(t,y)%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%define function f, time step dt, and number of steps n
f = @(t,y) t*y;    %RHS of dy/dt = f(t,y)
dt = 0.1;          %step size
T = 10;            %total number of steps

%choose initial condition 
ys = zeros(1,T);
ys(1) = 1;    %initial condition (Note: Matlab vector indices start at 1)

%compute numerical solution to ODE using Euler's method

for n=1:T-1    %Euler's method iteration
    ys(n+1) = ys(n) + f((n-1)*dt,ys(n))*dt;
end

%compute "exact" solution to ODE using very small time step, del
del = 0.001;
S = T*dt/del;
xs_exact = 0:del:(S-1)*del;
ys_exact = [1,zeros(1,S-1)];
for n=1:S-1
    ys_exact(n+1) = ys_exact(n) + f((n-1)*del,ys_exact(n))*del;
end

%now create animation of Euler's method!
close all
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(groot,'defaulttextinterpreter','latex');
set(groot,'defaultLegendInterpreter','latex');
figure;
set(gca,'FontSize',16)
hold on
h1 = plot(xs_exact,ys_exact,':','color',[0 .5 0],'linewidth',2);
xlim([0 (T-1)*dt])
labels = {};
for n=1:T
    labels{n} = num2str((n-1)*dt);
end
xticks([0:dt:(T-1)*dt])
xticklabels(labels)
ylim([1.1*min(ys)-0.1*max(ys) 1.1*max(ys)-0.1*min(ys)])
title(['Euler''s Method for $dy/dt=f(t,y)$ when $\Delta t=$ ' num2str(dt)],... 
    'interpreter','latex','fontsize',16)
xlabel('$t$','interpreter','latex','fontsize',16)
ylabel('$y$','interpreter','latex','fontsize',16)

for n=1:T-1
    t = (n-1)*dt;
    y = ys(n);
    h2 = plot(t,y,'.r','markersize',20);
    legend([h1 h2],'exact solution',...
        ['$(t_{' int2str(n-1) '},y_{' int2str(n-1) '})$ from E.M.'],...
        'interpreter','latex','fontsize',16,'location','northwest');
    labels_ = labels;
    labels_{n} = ['$t_{' int2str(n-1) '}$'];
    xticklabels(labels_)
    %set(gcf, 'PaperPositionMode', 'auto')
    %set(gcf, 'InvertHardCopy', 'off');
    %set(gcf, 'Color', [1 1 1]);
    %saveas(gcf,['EM_' int2str(2*n-1) '.pdf'],'pdf')
    pause(1)
    h3 = quiver(t,y,dt,f(t,y)*dt,'linewidth',2,'color','b','MaxHeadSize',1);
    legend([h1 h2 h3],'exact solution',...
        ['$(t_{' int2str(n-1) '},y_{' int2str(n-1) '})$ from E.M.'],...
        ['$f(t_{' num2str(n-1) '},y_{' num2str(n-1) '})$ from E.M.'],... 
        'interpreter','latex','fontsize',16,'location','northwest')
    %set(gcf, 'PaperPositionMode', 'auto')
    %set(gcf, 'InvertHardCopy', 'off');
    %set(gcf, 'Color', [1 1 1]);
    %saveas(gcf,['EM_' int2str(2*k) '.pdf'],'pdf')
    pause(1)
end
