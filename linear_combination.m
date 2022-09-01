
dt = 0.01;

close all
figure('Renderer', 'painters', 'Position', [100 100 1600 1000])
set(gca,'fontsize',18)
axis square
hold on
grid on

        u = input('first vector: ');
        x1 = 0;
        x2 = u(1);
        y1 = 0;
        y2 = u(2);
        line([x1 x2], ... 
                  [y1 y2], ...
                  'linestyle',':','color','b','linewidth',6);
        v = input('second vector: ');
        x1 = 0;
        x2 = v(1);
        y1 = 0;
        y2 = v(2);
        line([x1 x2], ... 
                  [y1 y2], ...
                  'linestyle',':','color','r','linewidth',6);
        c = input('linear combination coefficients: ');
        disp("linear combination (" + c(1) + ")u + (" + c(2) + ")v = ...")
        c(1)*u+c(2)*v
        
        mx = min([0,u(1),v(1),c(1)*u(1),c(2)*v(1),c(1)*u(1)+c(2)*v(1)]);
        Mx = max([0,u(1),v(1),c(1)*u(1),c(2)*v(1),c(1)*u(1)+c(2)*v(1)]);
        my = min([0,u(2),v(2),c(1)*u(2),c(2)*v(2),c(1)*u(2)+c(2)*v(2)]);
        My = max([0,u(2),v(2),c(1)*u(2),c(2)*v(2),c(1)*u(2)+c(2)*v(2)]);
        axis([mx-1 Mx+1 my-1 My+1])
        legend('$u$','$v$','interpreter','latex','autoupdate','off')
        title("linear combination (" + c(1) + ")$u + $(" + c(2) + ")$v$", ...
            'interpreter','latex')
        pause(6)
        for t=0:abs(c(1))/dt-1
            x1 = t*dt*u(1)*sign(c(1));
            x2 = (t+1)*dt*u(1)*sign(c(1));
            y1 = t*dt*u(2)*sign(c(1));
            y2 = (t+1)*dt*u(2)*sign(c(1));
        line([x1 x2], ... 
                  [y1 y2], ...
                 'color','b','linewidth',2)
            pause(0.00001)
        end
        for t=0:abs(c(2))/dt-1
            x1 = c(1)*u(1)+t*dt*v(1)*sign(c(2));
            x2 = c(1)*u(1)+(t+1)*dt*v(1)*sign(c(2));
            y1 = c(1)*u(2)+t*dt*v(2)*sign(c(2));
            y2 = c(1)*u(2)+(t+1)*dt*v(2)*sign(c(2));
        line([x1 x2], ... 
                  [y1 y2], ...
                 'color','r','linewidth',2);
            pause(0.00001)
        end
        clf
        x1 = 0;
        x2 = u(1);
        y1 = 0;
        y2 = u(2);
        line([x1 x2], ... 
                  [y1 y2], ...
                  'linestyle',':','color','b','linewidth',6);
        x1 = 0;
        x2 = v(1);
        y1 = 0;
        y2 = v(2);
        line([x1 x2], ... 
                  [y1 y2], ...
                  'linestyle',':','color','r','linewidth',6);
        x1 = 0;
        x2 = c(1)*u(1)+c(2)*v(1);
        y1 = 0; 
        y2 = c(1)*u(2)+c(2)*v(2);
        line([x1 x2], ... 
                  [y1 y2], ...
                  'linestyle','-','color',[0 .5 0],'linewidth',2);
        legend("$u$","$v$",...
            "linear combination (" + c(1) + ")$u + $(" + c(2) + ")$v$", ...
            'interpreter','latex','autoupdate','off')
        title("linear combination (" + c(1) + ")$u + $(" + c(2) + ")$v$", ...
            'interpreter','latex')
        x1 = 0; 
        x2 = c(1)*u(1);
        y1 = 0; 
        y2 = c(1)*u(2);
        line([x1 x2], ... 
                  [y1 y2], ...
               'linestyle','-','color','b','linewidth',2);
        x1 = c(1)*u(1);
        x2 = c(1)*u(1)+c(2)*v(1);
        y1 = c(1)*u(2);
        y2 = c(1)*u(2)+c(2)*v(2);
        line([x1 x2], ... 
                  [y1 y2], ...
               'linestyle','-','color','r','linewidth',2);
        x1 = 0;
        x2 = c(1)*u(1)+c(2)*v(1);
        y1 = 0; 
        y2 = c(1)*u(2)+c(2)*v(2);
         line([x1 x2], ... 
                  [y1 y2], ...
                  'linestyle','-','color',[0 .5 0],'linewidth',2);
        axis([mx-1 Mx+1 my-1 My+1])
        set(gca,'fontsize',18)
        axis square
        grid on

        