L = 2;
G = @(x,z) (1-heaviside(x-z)).*((z-L)/L).*x + heaviside(x-z).*(z/L).*(x-L);
xs = 0:0.02:L;

close all; set(groot,'defaultTextInterpreter','latex');
figure('DefaultAxesFontSize',18); h = []; subplot(1,3,1)
h(1) = plot(xs,G(xs,0.5),'-b','linewidth',2); hold on
h(2) = line([0 L],[0 0],'linestyle','-.','color','r','linewidth',2);
plot(0,0,'sk','markersize',10,'markerfacecolor','k'); 
plot(L,0,'sk','markersize',10,'markerfacecolor','k');
quiver(0.5,-1,0,0.3,'maxheadsize',1,'color','k');
xlabel('$x$'); ylabel('$u(x)$'); axis([0 L -1 1]);
legend(h,'deformed position','at rest position','interpreter','latex')

subplot(1,3,2); h = [];
h(1) = plot(xs,G(xs,0.5),'-b','linewidth',2); hold on
h(2) = plot(xs,G(xs,1.2),'-','color',[0 .5 0],'linewidth',2);
h(3) = line([0 L],[0 0],'linestyle','-.','color','r','linewidth',2);
plot(0,0,'sk','markersize',10,'markerfacecolor','k'); 
plot(L,0,'sk','markersize',10,'markerfacecolor','k');
quiver(0.5,-1,0,0.3,'maxheadsize',1,'color','k');
quiver(1.2,-1,0,0.3,'maxheadsize',1,'color','k');
xlabel('$x$'); ylabel('$u(x)$'); axis([0 L -1 1]);
legend(h,'deformed position 1','deformed position 2',...
    'at rest position','interpreter','latex')

subplot(1,3,3); h = [];
h(1) = plot(xs,G(xs,0.5)+G(xs,1.2),'-m','linewidth',2); hold on
h(2) = line([0 L],[0 0],'linestyle','-.','color','r','linewidth',2);
plot(0,0,'sk','markersize',10,'markerfacecolor','k'); 
plot(L,0,'sk','markersize',10,'markerfacecolor','k');
quiver(0.5,-1,0,0.3,'maxheadsize',1,'color','k');
quiver(1.2,-1,0,0.3,'maxheadsize',1,'color','k');
xlabel('$x$'); ylabel('$u(x)$'); axis([0 L -1 1]);
legend(h,{['deformed position 3' newline '= deformed position 1' ... 
     newline '+ deformed position 2'],...
    'at rest position'},'interpreter','latex')