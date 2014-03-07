function v = IsPeak(i, min, max, x)
        v = false;
        if i == min || i == max
            return
        end
        if x(i) < x(i-1) || x(i) < x(i+1)
            return
        end
        v = true;
    end