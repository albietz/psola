% function [s_marks, matching] = computeSMarks_simple(a_marks, beta,gamma)
%     a_t_max = a_marks(end);
%     s_marks = a_marks(1);
%     matching = [1];
%     t = a_marks(1);
%     P = diff(a_marks);
%     P = [P P(end)];
%     while (t/gamma < a_t_max)
%         match = closer(t,a_marks,matching(end),gamma);
%         t = t+P(match)/beta;
%         s_marks = [s_marks t];
%         matching = [matching match];
%     end
% end

function [s_marks, l] = computeSMarks_simple(a_marks, beta, gamma)
    l = 1;
    s_marks = a_marks(1);
    i = 1;
    P = diff(a_marks);
    P = [P P(end)];
    len = length(a_marks);
    while (l(i) < len)
       i = i+1;
       s_marks = [s_marks floor(s_marks(i-1) + P(l(i-1))/beta)];
       l = [l 0];
       [~, l(i)] = min(abs(a_marks-ones(1,len)*s_marks(i)/gamma));
    end
end


function [k] = closer(s_t, a_marks, a_i, gamma)
    k = a_i;
    while ( (a_marks(k+1)-s_t/gamma) < (a_marks(k)-s_t/gamma) )
        k = k+1;
    end
end