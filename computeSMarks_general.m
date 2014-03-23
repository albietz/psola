function [s_marks, l] = computeSMarks_general(a_marks, beta, D)
    l = 1;
    s_marks = a_marks(1);
    i = 1;
    P = diff(a_marks);
    P = [P P(end)];
    len = length(a_marks);
    while (l(i) < len)
       i = i+1;
       s_marks = [s_marks floor(s_marks(i-1) + P(l(i-1))/beta(l(i-1)))];
       l = [l 0];
       %[val, ind] = min(abs( arrayfun(@D,a_marks) - ones(1,len)*s_marks(i) ));
       [val, ind] = min(abs( D - ones(1,len)*s_marks(i)));
       disp(ind);
       disp(s_marks(i));
       l(i) = ind(1);
    end
end

% D and beta are two dimensional arrays : initial time and remapping time
function [beta] = localRemapping(D)
    beta = zeros(length(D(:,1))-1,2);
    beta(:,1) = D(1:end-1,1);
    beta(:,2) = diff(D(:,2)) ./ diff(D(:,1));
end

