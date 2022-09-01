set(groot,'defaultTextInterpreter','latex')
set(groot,'defaultAxesTickLabelInterpreter','latex');  
set(groot,'defaultLegendInterpreter','latex');
set(groot,'defaultAxesFontSize',22)
figure
line([0 3], [0 0],'color','blue','linewidth',2)
line([0 0], [0 3],'color','blue','linewidth',2)
hold on

for t=1:20
    line([1.9+t/100 2],[0,2.5],'color','r','linewidth',1)
end

xticks([2]); xticklabels({'$c$'}); xlim([0 3]);
yticks([2.5]); yticklabels({'$\infty$'}); ylim([0 3])
xlabel('$t$'); ylabel('$\delta(t-c)$')