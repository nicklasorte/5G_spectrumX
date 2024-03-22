function l = fspl(d, f)
% FSPL (d in km, f in Ghz)
l = 20 * log10(d .* f) + 92.44778322188337;
% 10log10((4pi * 1km * 1Ghz/c)^2) ~ 92.44778322188337
% closest double to true value
end