%plot what a 2x2 matrix does to the unit square at the origin

while true

A=input('Input a 2x2 matrix: \n');
A

close all
figure('Renderer', 'painters', 'Position', [50 50 900 500])
subplot(1,2,1)
hold on
line([0 0],[0 1],'linewidth',2,'color','r')
line([0 1],[0 0],'linewidth',2,'color','b')
line([0 1],[1 1],'linewidth',2,'color',[.5 0 .5])
line([1 1],[0 1],'linewidth',2,'color',[0 .5 0])
plot(0,0,'s','linewidth',4)
plot(1,0,'d','linewidth',4)
plot(0,1,'>','linewidth',4)
plot(1,1,'h','linewidth',4)
axis([-1 2 -1 2])
axis square
title('Original square, $S$','interpreter','latex','fontsize',14)
set(gca,'FontSize',14)

subplot(1,2,2)
hold on
v1 = A*[1;0];
v2 = A*[0;1];
line([0 v1(1)],[0 v1(2)],'linewidth',2,'color','b')
line([0 v2(1)],[0 v2(2)],'linewidth',2,'color','r')
line([v1(1) v1(1)+v2(1)],[v1(2) v1(2)+v2(2)],'linewidth',2,'color',[0 .5 0])
line([v2(1) v2(1)+v1(1)],[v2(2) v2(2)+v1(2)],'linewidth',2,'color',[.5 0 .5])
plot(0,0,'s','linewidth',4)
plot(v1(1),v1(2),'d','linewidth',4)
plot(v2(1),v2(2),'>','linewidth',4)
plot(v1(1)+v2(1),v1(2)+v2(2),'h','linewidth',4)
a = min([v1(1)-1,v2(1)-1,v1(1)+v2(1)-1,-1]);
b = max([v1(1)+1,v2(1)+1,v1(1)+v2(1)+1,1]);
c = min([v1(2)-1,v2(2)-1,v1(2)+v2(2)-1,-1]);
d = max([v1(2)+1,v2(2)+1,v1(2)+v2(2)+1,1]);
axis([a b c d])
axis square
title('Mapped square, $A(S)$','interpreter','latex','fontsize',14)
set(gca,'FontSize',14)

end