function out = interval(in, lower, upper)
% bounds array to interval(s) <- bounds can be arrays as well as scalars
% if a lower bound is greater than an upper bound, the lower bound is
% returned regardless of the in value.
out = max(min(in, upper), lower);
end