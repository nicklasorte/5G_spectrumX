function Q = standard_normal_tail(x)
Q = erfc(x/sqrt(2))/2;
% workaround for the tail of the normal distribution Q(x) = 1 - normcdf(x).
% identical up to floating point arithmetic error.
% The matlab normcdf function requires the stat toolbox
end