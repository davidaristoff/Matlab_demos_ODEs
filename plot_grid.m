figure
axis square
line([-4 4],[0 0],'color','b','linewidth',2)
line([0 0],[-4 4],'color','b','linewidth',2)
grid on
set(gca,'fontsize',12)
xlabel('$u$','interpreter','latex')
ylabel('$v$','interpreter','latex')
ax = gca;
ax.GridLineStyle = '-';
ax.GridColor = 'k';
ax.GridAlpha = 1; % maximum line opacity