function [ wave_out, weights_out ] = Synthesis_weighted( wave_in, fs, in_marks, out_marks, match, mu, gamma )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

wave_out = zeros(out_marks(end) + floor(0.2*fs),1);
weights_out = zeros(size(wave_out));

dpos1 = [diff(in_marks(match)) 0];
dpos1(end) = dpos1(end-1);

dpos2 = [0 diff(in_marks(match))];
dpos2(1) = dpos1(2);

dpos = 0.5*(dpos1+dpos2);
%dpos = max(dpos1,dpos2);

dpos = floor(mu * dpos);

for i=1:1:length(match)
    
    %possiblement inutile
    previous_match = max(1, match(i)-1);
    
    apos = in_marks(match(i));
    spos = out_marks(i);
    dp = dpos(i);
    dpl = min([dp, apos-1, spos-1, in_marks(previous_match)]);
    dpr = min([dp, length(wave_in)-apos, length(wave_out)-spos]);
  
    out_range = (spos-dpl):(spos+dpr);
    
    [frame1, window1] = get_frame(wave_in, in_marks(previous_match), dp, dpl, dpr);
    [frame2, window2] = get_frame(wave_in, in_marks(match(i)), dp, dpl, dpr);
    
    alpha = 1.0*(out_marks(i)/gamma - in_marks(previous_match))/(in_marks(match(i)) - in_marks(previous_match));
    
    wave_out(out_range) = wave_out(out_range) + (1-alpha)*frame1+alpha*frame2;
    weights_out(out_range) = weights_out(out_range) + (1-alpha)*window1+alpha*window2;
end
wave_out = wave_out ./ weights_out;

end
