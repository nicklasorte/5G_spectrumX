function x = bs_on_decreasing_f(x, y, f, epsilon)
xstep = x/2;
diff = y - f(x);
while abs(diff) >= epsilon
    if diff > 0
        x = x - xstep;
    else
        x = x + xstep;
    end
    xstep = xstep/2;
    diff = y -f(x);
end
