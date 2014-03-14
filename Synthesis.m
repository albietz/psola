function [ wave_out ] = Synthesis( wave_in, fs, in_marks, out_marks, match, mu )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

wave_out = zeros(out_marks(end) + floor(0.1*fs),1);
weights_out = zeros(size(wave_out));

dpos = [diff(in_marks(match)) 0];
dpos(end) = dpos(end-1);
dpos = mu * dpos;

for i=1:length(match)
    dp = dpos(i);
    in_range = out_marks(i)-dp:out_marks(i)+dp;
    [frame, window] = get_frame(wave_in, in_marks(match(i)), dp);
    wave_out(in_range) = wave_out(in_range) + frame;
    weights_out(in_range) = weights_out(in_range) + window;
end

wave_out = wave_out ./ weights_out;

end
