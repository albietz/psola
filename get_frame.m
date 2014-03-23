function [ frame, window] = get_frame( x, pos, dpos, dpl, dpr)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

window = hanning(2*dpos+1);

% ranx = max(pos-dpos,linf):min(pos+dpos, lsup);
% 
% if (pos-dpos < linf)
%     window = window(end-length(ranx)+1:end);
% elseif (pos+dpos > lsup)
%     window = window(1:length(ranx));
% end

ranx = (pos+1-dpl):(pos+1+dpr);
ranw = (dpos+1-dpl):(dpos+1+dpr);

window = window(ranw);
frame = window .* x(ranx);

end

