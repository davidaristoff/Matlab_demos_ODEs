%animation of a harmonic oscillator

close all;
k = 1;      %spring constant
m = 1/10;      %mass
A = -1;      %initial displacement
T = 10;     %total time
dt = 0.01;  %time step

f = @(t) A*cos(sqrt(k/m)*t);
xs = linspace(0,10,T/dt);
vec = linspace(-1,0,1000);
figure('Renderer', 'painters', 'Position', [50 100 1400 1000])

for t=1:T/dt
    h0 = line([-4 10], [0,0]);
    x = .05*cos(20*pi*vec)-2;
    y = 1+.05*sin(20*pi*vec)-vec*(f(t*dt)-1);
    h1 = plot(x,y,'.','color','g');
    %h1 = line([-2, -2], [2,f(t*dt)],'color','g','Linewidth',2);
    hold on
    h2 = plot(-2,f(t*dt),'sb','Markersize',20, 'MarkerFaceColor','b');
    h3 = plot(xs,f(xs),'-m');
    h4 = plot(t*dt,f(t*dt),'.b','Markersize',30);
    set(gca,'XTick',[], 'YTick', [])
    ylim([-1.5 1.5])
    xlim([-4 10])
    pause(0.0001)
    if t<T/dt
    delete([h0 h1 h2 h3 h4])
    end
end