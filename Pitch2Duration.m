function d = Pitch2Duration(p, fs)
%calculate T0
    d = p;
    for i = 1:length(p)
        if p(i)~=0 
            d(i) = fs / p(i);
        end
    end
return