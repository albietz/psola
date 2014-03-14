function [ frame, window ] = get_frame( x, pos, dpos )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

window = hanning(2*dpos+1);
frame = window .* x(pos-dpos:pos+dpos);

end

