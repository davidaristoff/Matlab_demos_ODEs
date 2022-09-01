ts = 0:1:12; vs = zeros(1,13);    %vectors of times and v values
for t=1:12    %compute numerical solution using Euler's method
    vs(t+1) = vs(t) + (49-vs(t))/5;
end
plot(ts,vs,'x'); vs    %plot solution and display solution values