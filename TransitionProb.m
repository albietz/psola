function tc = TransitionProb(i, k, d)
% Transition Probability
    beta = 0.7;
    gamma = 0.6;
    dur = (d(i) + d(k)) / 2; %pitch period
    tc = (1 / (1 - beta * abs(dur - abs(k - i) ) ) )^gamma; 
return
