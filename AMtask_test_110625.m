clear;
close all;

%add path where BCI tools functions exist on INMAN Lab Box
addpath(genpath('/Users/martinahollearn/Library/CloudStorage/Box-Box/InmanLab/BCI2000/BCI2000Tools'));

%load a single dat file
[~, states, parameters] = load_bcidat('/Users/martinahollearn/Library/CloudStorage/Box-Box/InmanLab/BLAES_task_codes/AM_task/temp_data/BCI000/practice.dat');

%stimulus codes listed in the order shown at the sampling rate (i.e. a stim code will
%be listed 2000 times per second because our sampling rate is 2K)
StimCode = states.StimulusCode;

%filter the key presses to keys pressed and remove any zeros/instances
%where no key is being pressed
KD = states.KeyDown;
KDCopy = KD;
KDCopy(KDCopy==0) = [];


%Create a matrix (keyPresses) with the first column  being the key pressed
%and the second column being the stimulus code/image ID at the same stimulus
%code/time as the key press, and the third column is the timestamp/sample at which the key was pressed. 
% (The "cnt" is to avoid getting any events during the 0s of
%the sampling rate (it is the index of the key press. When count = 1 it is
%the first key press, etc.))
cnt = 1;
keyPresses = zeros(length(KDCopy), 3);
for i = 1:length(KD)
    if(KD(i) ~= 0)
        keyPresses(cnt,1) = KD(i);
        keyPresses(cnt,2) = StimCode(i);
        keyPresses(cnt,3) = i;
        cnt = cnt + 1;
    end
end


%list of stimulus codes shown in the order they were shown (not at the
%sampling rate)
SEQ = parameters.Sequence.NumericValue;

% Filter SEQ to only include stimulus codes associated with image stimuli
% (not fixation cross periods, etc.)
SEQ(SEQ>500) = [];
%SEQ(SEQ>800) = [];

%Create a list of images shown (stimulus codes) and also list the
%type of image that was shown (item or scene).
iter = 1;
for i = 1:length(SEQ)
    collectImageInfo{iter,1} = SEQ(i);% stimulus code for image
    collectImageInfo{iter,2} = parameters.Stimuli.Value{2,SEQ(i)};% identity of image: item or scene
    iter = iter + 1;
end



%% WHAT TO DO AFTER YOU'VE RUN THIS CODE:

% #1 VERIFY THE KEYS PRESSED IN keyPresses VARIABLE MATCH THE KEYS YOU
% PRESSED IN THE ORDER YOU PRESSED THEM (column #1 in keyPresses lists the
% identity of the key you pressed -- see this website to translate the key code numbers to keyboard key names: https://boostrobotics.eu/windows-key-codes/)
    % A. Also verify the key you pressed matches up with the image that was
    % onscreen when you pressed that key (column #2 in keyPresses lists the
    % stimulus code/image ID that was present when you pressed the key in column #1. You can also match that stimulus code up with the image shown from the variable collectImageInfo)

% #2 VERIFY THE STIMULUS CODES MATCH UP WITH THE IDENTITY OF IMAGES THAT
% YOU SAW IN THE ORDER YOU SAW THEM WHEN YOU TEST RAN THE TASK
    % A. The collectImageInfo variable lists the stimulus codes for images in
    %column #1 in the order they were presented onscreen (filtered to only include images and not fixation cross or
    %ITI periods)
    % B. The collectImageInfo variable column #2 lists the identity of the
    % images (item or scene) in the order they were presented onscreen

% #3 VERIFY THE GENERAL PROGRESSION/ORDER OF STIMULUS CODES IN
% parameters.Sequence.NumericValue MATCHES HOW YOU THINK THE TASK SHOULD
% PROGRESS (i.e. do the stimulus code numbers match up with how you think
% the task should progress. For example, instructions screen --> fixation
% cross --> image --> ITI ---> image....etc.)



