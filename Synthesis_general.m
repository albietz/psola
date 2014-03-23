function [ wave_out, weights_out ] = Synthesis_general( wave_in, fs, in_marks, out_marks, match, mu )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

wave_out = zeros(out_marks(end) + floor(0.1*fs),1);
weights_out = zeros(size(wave_out));

dpos1 = [diff(in_marks(match)) 0];
dpos1(end) = dpos1(end-1);

dpos2 = [0 diff(in_marks(match))];
dpos2(1) = dpos1(2);

dpos = 0.5*(dpos1+dpos2);
%dpos = max(dpos1,dpos2);

dpos = floor(mu * dpos);

for i=1:1:length(match)
    apos = in_marks(match(i));
    spos = out_marks(i);
    dp = dpos(i);
    dpl = min([dp, apos-1, spos-1]);
    dpr = min([dp, length(wave_in)-apos, length(wave_out)-spos]);

    out_range = (spos-dpl):(spos+dpr);
    
    [frame, window] = get_frame(wave_in, apos, dp, dpl, dpr);

    wave_out(out_range) = wave_out(out_range) + frame;
    weights_out(out_range) = weights_out(out_range) + window;
end
%wave_out = wave_out ./ weights_out;
plot(weights_out);

end
