function [mat] = matching(a_marks, s_marks)
    n = length(s_marks);
    l = 1;
    mat = zeros(1,n);
    for m=1:n
        l = closer(s_marks(m),a_marks,l);
        mat(m) = l;
    end

end

function [k] = closer(s_t, a_marks, a_i)
    k = a_i;
    while ( (a_marks(k+1)-s_t) < (a_marks(k)-s_t) )
        k = k+1;
    end
end