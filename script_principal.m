clear all;
close all;
clc;
%--------------------------------------------------------------------------
% main script to do pitch and time scale modification of speech signal
%--------------------------------------------------------------------------
% config contain all parameter of this program
global config;
config.pitchScale           = 1.5;	%pitch scale ratio
config.timeScale            = 1;	%time scale ratio
config.cutOffFreq           = 900;	%cut of frequency for lowpass filter
config.fileIn               = '../base_kawa_psola/rl004.wav';		%input file full path and name
config.fileOut              = '../plus_aigu_psola.wav';		%output file full path and name

%data contain analysis results
global data;
data.pitchMarks = [];	%pitch marks of input signal
data.Candidates = [];	%pitch marks candidates


[WaveIn, fs] = wavread(config.fileIn);	%read input signal from file
WaveIn = WaveIn - mean(WaveIn); 				%normalize input wave

[LowPass] = LowPassFilter(WaveIn, fs, config.cutOffFreq); %low-pass filter for pre-processing
PitchContour = PitchEstimation(LowPass, fs);							%pitch contour estimation
PitchMarking(WaveIn, PitchContour, fs);	%do pitch marking
PlotPitchMarks(WaveIn, data.candidates, data.pitchMarks, PitchContour); %show the pitch marks

%% Add unvoiced marks

marks = AddUnvoicedMarks(data.pitchMarks, PitchContour, fs);
PlotPitchMarks(WaveIn, data.candidates, marks(1,:), PitchContour);

%% synth test #1

beta = 1;
gamma = 1.5;
mu = 2;

in_marks = marks(1,:);
%in_marks = [in_marks, (in_marks(end) + 200*(1:1))];

% % out_marks = zeros(1,2*length(marks));
% % out_marks(1:2:end) = in_marks;
% % out_marks(2:2:end) = in_marks + [floor(diff(in_marks)/2) 100];
% % out_marks = floor(2*out_marks);
% % match = kron(1:length(in_marks), [1 1]);
% % 
% % out_marks = zeros(1,length(marks));
% % out_marks = in_marks(1:2:end);
% % out_marks = floor(0.5*out_marks);
% % match = 1:2:length(in_marks);

[out_marks, match] = computeSMarks_simple(in_marks, beta, gamma);
[wave_out,weight_out] = Synthesis(WaveIn, fs, marks(1,:), out_marks, match, mu);
PlotPitchMarks(wave_out,ones(1,3), out_marks, PitchContour);
soundsc(WaveIn,fs);
soundsc(wave_out, fs);


%% synth test #2

[out_marks, match] = computeSMarks_weighted(in_marks, beta, gamma);
[wave_out,weight_out] = Synthesis_weighted(WaveIn, fs, marks(1,:), out_marks, match, mu, gamma);
PlotPitchMarks(wave_out,ones(1,3), out_marks, PitchContour);
%soundsc(WaveIn,fs);
soundsc(wave_out, fs);

%% synth test #3
close all;

%D = 1*in_marks;
D = zeros(1,length(in_marks))+150;
D = cumsum(D);
%D = arrayfun(@(x) x+2000*sin(x/3500.),in_marks);
%D = arrayfun(@(x) x-0.00001*x*x,in_marks);

%beta = ones(length(in_marks));
%beta = arrayfun(@(x) 1+0.2*sin(x/3500.),in_marks);

beta = mean(diff(in_marks)) * ones(1,length(in_marks)-1).*diff(in_marks);
beta = [beta beta(end)]/mean(beta);

[out_marks, match] = computeSMarks_general(in_marks, beta, D);
[wave_out,weight_out] = Synthesis_general(WaveIn, fs, marks(1,:), out_marks, match, mu);
PlotPitchMarks(wave_out,ones(1,3), out_marks, PitchContour);
%soundsc(WaveIn,fs);
soundsc(wave_out, fs);
