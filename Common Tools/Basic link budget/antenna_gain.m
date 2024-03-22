function G = antenna_gain(f_GHz, dia, efficiency)
G = 20 * log10(dia .* f_GHz .* efficiency * pi * 1e9 / 299792458);
end