function mix = mix(A)
rand('state',sum(100*clock));
mix = A(randperm(length(A)));
return