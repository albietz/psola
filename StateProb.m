function sc = StateProb(h, min, max)
% State Probability
    alpha = 1;
%     disp(sprintf('%d %d %d', h, min, max));
    if min == max %the first pitch mark
        sc = 1;
        return;
    end
    sc = ((h - min) / (max - min))^alpha;
return