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
config.fileIn               = '../base_kawa_psola/rl001.wav';		%input file full path and name
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