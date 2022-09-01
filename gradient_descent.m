
%compute energy landscape
[X,Y] = meshgrid(-1:0.01:1);
Z = zeros(size(X));

ws = [0.3272
    0.8175
    0.1736
    0.6761
    0.8756
    0.7572
    0.2296
    0.3589
    0.3632
    0.2674
    0.3373
    0.0870
    0.4516
    0.4547
    0.0290
    0.6371
    0.0595
    0.1692
    0.6847
    0.5546
    0.0060
    0.2881
    0.3766
    0.1465
    0.0745
    0.4607
    0.3704
    0.8246
    0.5375
    0.8175
    0.4604
    0.0140
    0.0050
    0.1662
    0.3659
    0.7182
    0.1594
    0.2788
    0.6449
    0.2872
    0.3219
    0.1554
    0.3877
    0.8957
    0.8878
    0.3936
    0.6755
    0.2522
    0.9500
    0.6247];
for i=1:length(ws)
    w = 2*pi*ws(i); Z = Z + sin(w*X).*sin(w*Y);
end
close all; figure('DefaultAxesFontSize',18,'Position',[100 100 1400 600])
subplot(1,2,1); surf(X,Y,Z); axis([-1 1 -1 1 -40 40]); hold on
title('loss function $L$','interpreter','latex')

%run gradient descent
steps = 100; dt = 0.001; x = 0.43; y = 0.35; vec = zeros(2,steps);
for step = 1:steps
    gradx = 0; grady = 0; z = 0;
    for i=1:length(ws)
        w = 2*pi*ws(i);
        gradx = gradx + w*cos(w*x)*sin(w*y);
        grady = grady + w*sin(w*x)*cos(w*y);
        z = z + sin(w*x)*sin(w*y);
    end
    vec(:,step) = [x;y];
    z = z  + 1.2;
    plot3(x,y,z,'.r','markersize',20)
    x = x - dt*gradx; y = y - dt*grady;
end


subplot(1,2,2); 
[X_,Y_] = meshgrid(-1:0.1:1); 
gradX = zeros(size(X_)); gradY = zeros(size(X_)); Z_ = zeros(size(X_));
for i=1:length(ws)
    w = 2*pi*ws(i); 
    gradX = gradX + w*cos(w*X_).*sin(w*Y_);
    gradY = gradY + w*sin(w*X_).*cos(w*Y_);
    Z_ = Z_ + sin(w*X_).*sin(w*Y_);
end
gradX = -gradX; gradY = -gradY;

contour(X,Y,Z,-40:2+pi/4:40); colorbar; hold on
quiver(X_,Y_,gradX,gradY)
plot(vec(1,:),vec(2,:),'.r','markersize',20)
title('direction field of $-\nabla L$','interpreter','latex')

