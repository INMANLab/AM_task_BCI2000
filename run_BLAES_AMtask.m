% BCI2000 Stimulus Presentation Demo Script
% 
% StimulusPresentationScript_Demo creates a parameter fragment that can be
% loaded into BCI2000 to create a stimulus presentation experiment.
% 
% This demo script will take the image files located in the BCI2000 prog
% directory and create a stimuli matrix containing these images, variable
% duration fixation cross stimuli, instructions, and a sync pulse. 
% 
% Change the n_rows and total_events variables to store more information with
% the stimuli or add additional stimuli. Best practice is to separate
% stimuli into banks (e.g. 1-25, 101-125, etc) for easy evaluation later. 
% 
% Note that every stimulus needs to have an index for every row desired,
% even if that row label is not meaningful for the stimulus.
% 
% A sequence is created to alternate the fixation cross stimuli with the
% image stimuli.
% 
% The stimuli and meaningful parameters are written into a param
% variable and stored as a *.prm file using the convert_bciprm function.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Author: Martina Hollearn <martina.hollearn@psych.utah.edu>
%%
%% $BEGIN_BCI2000_LICENSE$
%% 
%% This file is part of BCI2000, a platform for real-time bio-signal research.
%% [ Copyright (C) 2000-2021: BCI2000 team and many external contributors ]
%% 
%% BCI2000 is free software: you can redistribute it and/or modify it under the
%% terms of the GNU General Public License as published by the Free Software
%% Foundation, either version 3 of the License, or (at your option) any later
%% version.
%% 
%% BCI2000 is distributed in the hope that it will be useful, but
%%                         WITHOUT ANY WARRANTY
%% - without even the implied warranty of MERCHANTABILITY or FITNESS FOR
%% A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
%% 
%% You should have received a copy of the GNU General Public License along with
%% this program.  If not, see <http://www.gnu.org/licenses/>.
%% 
%% $END_BCI2000_LICENSE$
%% http://www.bci2000.org 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rng('shuffle'); %randomize stim/image sequence (Seed to clock time)

clear;
close all;

if isunix
    slash = '/';
else
    slash = '\';
end

%% Set the path of the BCI2000 main directory here
%% For the below to work, we must be in the Main BCI2000 Folder in this
%% script. With the same folders as tools, python, parms, batch, data, etc.
BCI2000pathparts = regexp(pwd,filesep,'split');
BCI2000path = '';
for i = 1:length(BCI2000pathparts)
    BCI2000path = [BCI2000path BCI2000pathparts{i} filesep];
end
settings.BCI2000path = BCI2000path;
clear BCI2000path BCI2000pathparts i

% Add BCI2000 tools to path
addpath(genpath(fullfile(settings.BCI2000path,'tools')))

%% Settings
settings.SamplingRate          = '2000'; % device sampling rate
settings.SampleBlockSize       = '200';     % number of samples in a block - what's this?
%settings.StimulationDuration   = '1s';
settings.PreRunDuration        = '2s';
settings.PostRunDuration       = '0.5s';
settings.ElaborationDuration   = '17s';
settings.RatingDuration        = '5s';
settings.MaxSearchDuration     = '20s';
settings.DistractorDuration    = '5s';
settings.InstructionDuration   = '64000s';
settings.SyncPulseDuration     = '0s';
settings.BaselineMinDuration   = '0.5s';
settings.BaselineMaxDuration   = '1.5s';
settings.NumberOfSequences     = '1';
settings.StimulusWidth         = '40';
settings.WindowTop             = '0';
settings.WindowLeft            = '0';
settings.WindowWidth           = '640';
settings.WindowHeight          = '480';
settings.BackgroundColor       = '0x000000'; %black
settings.CaptionColor          = '0xFFFFFF'; %white
settings.CaptionSwitch         = '1';
settings.WindowBackgroundColor = '0x000000';
settings.ITI                   = '3s';
settings.beforeISI             = '1s';
settings.betweenISI            = '0.5s';
settings.FixationMin           = '0.5';
settings.FixationMax           = '1.5';
settings.SubjectName           = 'BCI';
settings.DataDirectory         = fullfile('..',slash,',,', slash, 'data');
settings.SubjectSession        = 'auto';
settings.SubjectRun            = '01';
settings.parm_filename         = fullfile(settings.BCI2000path,'parms', slash, 'AM_task', slash); %where the parm file is going and rename it to spec the task name
settings.UserComment           = 'Enter user comment here';
settings.ShadedBoxBlockDuration    = '0.5s';
settings.ShadedBoxStimulusDuration = '0.5s';

settings.instructionpath   = fullfile(settings.BCI2000path, 'prog', 'images','AM_task','instructions');
settings.imagepath    = fullfile(settings.BCI2000path, 'prog', 'images','AM_task');
settings.boxespath     = fullfile(settings.BCI2000path, 'prog', 'images','AM_task','shaded_boxes');
settings.practicepath   = fullfile(settings.BCI2000path,'prog', 'images','AM_task','practice');
% fnames = fieldnames(settings);
% for fidx = 1:length(fnames)
%     settings.(fnames{fidx}) = string(settings.(fnames{fidx}));
% end
%% Main task setup
ALL_IMAGES = dir(fullfile(settings.imagepath,'Word_list', '*.PNG'));

n_breakouts = 4;
n_images_per_breakout = 12; 

% Check total images are sufficient
total_needed = n_breakouts * n_images_per_breakout;
if length(ALL_IMAGES) < total_needed
    error('Not enough images for %d breakouts of %d images each. Found %d images', n_breakouts, n_images_per_breakout, length(ALL_IMAGES));
end

n_breakouts = 4;
n_images_per_breakout = 12;

total_imgs = n_breakouts*n_images_per_breakout;
img_order = randperm(total_imgs);
breakout_cells = mat2cell(img_order, 1, n_images_per_breakout*ones(1, n_breakouts));


%% Practice task setup
PRACTICE_IMAGES = dir(fullfile(settings.practicepath,'Word_list', '*.PNG'));

% Optional: select a fixed number of practice images, e.g., 6
n_practice_images = 6;
if length(PRACTICE_IMAGES) < n_practice_images
    error('Not enough practice images available.');
end

practice_set = PRACTICE_IMAGES(1:n_practice_images);

%% Write out param files
for breakoutnum_iter = 1:n_breakouts
    script_BLAES_AMtask_parameter( ...
        settings, ...
        ALL_IMAGES, ...
        slash, ...
        breakout_cells{breakoutnum_iter}, ...
        breakoutnum_iter, ...
        practice_set ...
    );
end
