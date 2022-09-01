video = input('Show video? Type yea or nay: ','s');

%initialize variables for simulations
L = 1; dt = 0.001;   %interval length and time step
close all; figure('DefaultAxesFontSize',14);
plot([0 1],[0 0],'-k'); hold on;
xlabel('$x$','interpreter','latex'); 

if video == 'yea'
    N = 3; k = 1;      %number of particles; smoothing parameter
    xs0 = linspace(0.5/N,1-0.5/N,N);
    plot(xs0,zeros(1,N),'-ok','markersize',10);
    ylabel('time','interpreter','latex');
else 
    disp('you may have to wait a moment for computations...')
    N = 10^4; k = 100;   %number of particles; smoothing parameter
    xs0 = linspace(0.5/N,1-0.5/N,N);
end
survivors = ones(1,N); times = zeros(1,N);   %initialize survivor list
labels = 1:1:N; t = 0; xs_ = xs0;            %initial time/particles

while N > 0

    %run simulations for time dt; check for exits from 0 <= x <= L
    xs = xs_; t = t + dt;                %advance time
    survivors = (xs > 0 & xs < L);       %update survivors list
    times(survivors) = t;                %update total survival times
    N = nnz(survivors);                  %update total number of survivors
    xs_(survivors) = xs(survivors) ...   %advance particles using
        + sqrt(dt)*normrnd(0,1,[1 N]);   %Brownian motion dynamics
    absorbed0 = labels(xs_ <= 0);        %list of particles exiting via 0
    absorbedL = labels(xs_ >= L);        %list of particles exiting via L

    if video == 'yea'   %run the animation
        plot([xs(survivors);xs_(survivors)], ...
            [(t-dt)*ones(1,N); t*ones(1,N)],'-','color',[0 .5 0])
        plot([0 0],[t-dt t],'-k'); plot([1 1],[t-dt t],'-k');
        plot(xs0(absorbed0),zeros(1,length(absorbed0)),'.b','markersize',25)
        plot(xs0(absorbedL),zeros(1,length(absorbedL)),'.r','markersize',25)
        xlim([-0.1 L+0.1]); c = 1/20; ylim([-c*t/(1-c) t]); 
        pause(0.02)   %pause for a short time
    end

end

%plot bar graph estimate of solution
times = movmean(times,k); 
h1 = bar(xs0,times,'FaceColor',[0,0.7,0.7]); h1.FaceAlpha = 0.2;
if video == 'nay'
    h2 = plot(xs0,xs0.*(L-xs0),'-k');
    legend([h1,h2],'sampling estimate','exact solution', ...
        'interpreter','latex');
    ylabel('$u(x)$','interpreter','latex')
end


