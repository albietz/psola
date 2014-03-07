%--------------------------------------------------------------------------
% detect pitch value of a frame using autocorrelation method
%--------------------------------------------------------------------------
function pitch = PitchDetection(x, fs)
% Detect pitch in a speech segment
% pitch = 0 for unvoiced segment

MinLag = round( fs / 500);
MaxLag = round( fs / 70);

cc = CenterClipping(x, 0.3); 								% Center Cliping for pre-processing
AutoCorr = xcorr(cc, MaxLag, 'coeff'); 			% normalized ACF (AutoCorrelation Function)
AutoCorr = AutoCorr(MaxLag + 1 : 2*MaxLag); %take half of ACF


[MaxValue, MaxIndex] = max(AutoCorr(MinLag : MaxLag)); %search max value of ACF in search region
MaxIndex = MaxIndex + MinLag - 1;

HalfIndex = round(MaxIndex/2);
HalfValue = AutoCorr(HalfIndex);

[MinValue, MinIndex] = min(AutoCorr(1 : MaxIndex));

MeanValue = mean(AutoCorr);

if MaxValue > 0.35 && MinValue < 0 && IsPeak(MaxIndex, MinLag, MaxLag, AutoCorr)
    pitch = fs / (MaxIndex);
    else pitch = 0;
end
end
