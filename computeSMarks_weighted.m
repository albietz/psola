function [s_marks, l] = computeSMarks_weighted(a_marks, beta, gamma)
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
       ind = find(a_marks > s_marks(i)/gamma);
       l(i) = ind(1);
    end
end