function [ mat ] = AddUnvoicedMarks( marks, freqs, fs )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

Nendmarks = 20;

diff = marks(2:end) - marks(1:end-1);

idx = find(diff > 300);
idx = [1 idx];

delta = floor(0.01*fs);
new_marks = 1:200:marks(1);
for i=2:length(idx)
    num_add = floor(diff(idx(i)) / delta);
    add = delta * (1:num_add);
    new_marks = [new_marks, marks(idx(i-1)+1:(idx(i))), (marks(idx(i)) + add)];
end
new_marks = [new_marks, marks(idx(end)+1:end)];

mat = [new_marks; freqs(new_marks)'];

end

