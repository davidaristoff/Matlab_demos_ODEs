%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% simulation of molecules reacting inside of a unit square (2D) box %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%set parameters for simulation

%decide whether or not to show video
video = input('Show video? Type yea or nay: ','s');
close all

%define total time and time step (more resolution for video)
if video == 'yea'
    Q0 = 50;      %Q0 = initial concentration
else
    disp('you may have to wait a moment for computations...')
    Q0 = 500;     %Q0 = initial concentration
end

%define other parameters for simulation
dt = 0.01;         %dt = time step
T = 10;            %T = total time
N = T/dt+1;        %N = total number of steps (must be integer)
del = 0.01;        %del = small distance associated with reaction
Qs = zeros(N,1);   %Qs = vector of time-dependent concentrations 
Q = Q0;            %Q = current concentration of molecules
X = rand([Q 2]);   %X = matrix of position of molecules

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%run simulation of molecules reacting

for n=1:N

    %record current total population
    Qs(n) = Q;

    %move molecules using Brownian motion rule
    X = X + sqrt(dt)*normrnd(0,1,[Q 2]);

    %force molecules to stay in unit square box
    X = abs(X); X = 1-abs(1-X);

    %plot video of molecules, if requested
    if video == 'yea'
        scatter(X(:,1),X(:,2),40,'filled')   %plot molecules
        axis([0 1 0 1])                      %set axis limits
        pause(.01)                         %pause briefly to view
    end

    %remove particles that reacted
    delete = [];   %vector of deleted molecules
    for i=1:Q
        for j=1:Q
            %delete molecules i and j if they react with one another
            if i~=j && norm(X(i,:)-X(j,:)) < del   %check for reaction
                delete = [delete,i,j];             %schedule for deletion
            end
        end
    end
    delete = unique(delete);   %remove repeat entries
    X(delete,:) = [];          %delete reacting molecules
    Q = Q - length(delete);    %reduce molecule vector size

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%compare results to a reference solution

%compute ''reference'' concentration from solution to ODE 
k = 0.10;                        %reaction rate constant
ts = 0:dt:T;                     %vector of discrete times
Qref = 1./(k*ts + 1/Q0);         %reference solution

if video == 'nay'
    %open figure and set font size and interpreter
    set(groot,'defaultTextInterpreter','latex');
    figure('DefaultAxesFontSize',14)

    %plot the solution against reference in log-log scale
    h1 = loglog(ts,Qs,'-ob'); hold on; 
    h2 = loglog(ts,Qref,'-xr');

    %add t and Q labels, legend, and title
    legend([h1; h2],'simulation','reference','interpreter','latex')
    xlabel('$\log t$'); ylabel('$\log Q(t)$')
    title('Plot of concentration $Q(t)$ over time')
end
