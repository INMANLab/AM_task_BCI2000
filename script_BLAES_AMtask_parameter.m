function param = script_BLAES_AMtask_parameter(settings,ALL_IMAGES,slash,breakout_seq,breakoutnum_iter,practice_set)
%% Set up the different stimuli so they are represented by unique stimulus codes, separated into banks for easy evaluation later
total_events = 7000; % Total events
n_rows    = 7;

% break down into blocks for easier analysis later
% 1-500:     AM search w/ word display
% 501-1000:  AM elaboration (w/ word display?)
% 1001-1500: Reliving rating (w/ word display)
% 1501-2000: Valence rating (w/ word display)
% 2001-2500: boxes
% 2501-2510: instructions
% 2601:      sync pulse
% 5200:      3s ITI w fixation cross
% 5201:      1s ISI w fixation cross before arrows
% 5202:      0.5s ISI w fixation cross between arrows
% 5203:      3s AM end (fixation cross display)
% 5501-5570: Practice test


% Set up Stimuli
param.Stimuli.Section         = 'Application';
param.Stimuli.Type            = 'matrix';
param.Stimuli.DefaultValue    = '';
param.Stimuli.LowRange        = '';
param.Stimuli.HighRange       = '';
param.Stimuli.Comment         = 'captions and icons to be displayed, sounds to be played for different stimuli';
param.Stimuli.Value           = cell(n_rows,total_events);
param.Stimuli.Value(:)        = {''};
param.Stimuli.RowLabels       = cell(n_rows,1);
param.Stimuli.RowLabels(:)    = {''};
param.Stimuli.ColumnLabels    = cell(1,total_events);
param.Stimuli.ColumnLabels(:) = {''};

param.Stimuli.RowLabels{1}  = 'caption';
param.Stimuli.RowLabels{2}  = 'icon'; %what is on the screen
param.Stimuli.RowLabels{3}  = 'audio';
param.Stimuli.RowLabels{4}  = 'StimulusDuration';
param.Stimuli.RowLabels{5}  = 'AudioVolume';
param.Stimuli.RowLabels{6}  = 'Category';
param.Stimuli.RowLabels{7}  = 'EarlyOffsetExpression'; %advances to the next trial


%% 3s ITI w fixation cross
idx = 5200;
param.Stimuli.ColumnLabels{idx} = sprintf('%d',idx);
param.Stimuli.Value{1,idx}      = '+';
param.Stimuli.Value{2,idx}      = '';
param.Stimuli.Value{3,idx}      = '';
param.Stimuli.Value{4,idx}      = settings.ITI;
param.Stimuli.Value{5,idx}      = '0';      
param.Stimuli.Value{6,idx}      = 'ITI'; 
param.Stimuli.Value{7,idx}      = '';     

%% 1s ISI w fixation cross before arrows
idx = 5201;
param.Stimuli.ColumnLabels{idx} = sprintf('%d',idx);
param.Stimuli.Value{1,idx}      = '+';
param.Stimuli.Value{2,idx}      = '';
param.Stimuli.Value{3,idx}      = '';
param.Stimuli.Value{4,idx}      = settings.beforeISI;
param.Stimuli.Value{5,idx}      = '0';      
param.Stimuli.Value{6,idx}      = 'ISI'; 
param.Stimuli.Value{7,idx}      = '';     

%% 0.5s ISI w fixation cross before arrows
idx = 5202;
param.Stimuli.ColumnLabels{idx} = sprintf('%d',idx);
param.Stimuli.Value{1,idx}      = '+';
param.Stimuli.Value{2,idx}      = '';
param.Stimuli.Value{3,idx}      = '';
param.Stimuli.Value{4,idx}      = settings.betweenISI;
param.Stimuli.Value{5,idx}      = '0';      
param.Stimuli.Value{6,idx}      = 'ISI'; 
param.Stimuli.Value{7,idx}      = '';     

%% AM elaboration end (w fixation cross)
idx = 5203;
param.Stimuli.ColumnLabels{idx} = sprintf('%d',idx);
param.Stimuli.Value{1,idx}      = '+';
param.Stimuli.Value{2,idx}      = '';
param.Stimuli.Value{3,idx}      = '';
param.Stimuli.Value{4,idx}      = settings.ITI; % 3s
param.Stimuli.Value{5,idx}      = '0';      
param.Stimuli.Value{6,idx}      = 'AM_elaboration_ending'; 
param.Stimuli.Value{7,idx}      = '';      

%% AM search 1-500
num_images = length(ALL_IMAGES);

for idx_iter = 1:num_images
    idx = idx_iter;  % index from 1 to num_images
    param.Stimuli.ColumnLabels{idx_iter} = sprintf('%d',idx_iter);
    param.Stimuli.Value{1,idx}      = '';
    param.Stimuli.Value{2,idx}      = fullfile(settings.imagepath, 'Word_list', ALL_IMAGES(idx_iter).name);
    param.Stimuli.Value{3,idx}      = '';
    param.Stimuli.Value{4,idx}      = settings.MaxSearchDuration; % max 17s
    param.Stimuli.Value{5,idx}      = '0';    
    param.Stimuli.Value{6,idx}      = 'AM_search'; 
    param.Stimuli.Value{7,idx}      = 'KeyDown == 32'; % space key
    
    idx_iter = idx_iter + 1;
end 
%% AM elaboration 501-1000
idx_iter = 1;

for idx = 501:500+num_images
    param.Stimuli.ColumnLabels{idx} = sprintf('%d',idx);
    param.Stimuli.Value{1,idx}      = '';
    param.Stimuli.Value{2,idx}      = fullfile(settings.imagepath, 'Word_list', ALL_IMAGES(idx_iter).name);
    param.Stimuli.Value{3,idx}      = '';
    param.Stimuli.Value{4,idx}      = settings.ElaborationDuration; % max 20s
    param.Stimuli.Value{5,idx}      = '0';    
    param.Stimuli.Value{6,idx}      = 'AM_search'; 
    param.Stimuli.Value{7,idx}      = 'KeyDown == 32'; % space key
    
    idx_iter = idx_iter + 1;
end 
%% AM Reliving rating 1001-1500

idx_iter = 1;
for idx = 1001:1000+num_images
    param.Stimuli.ColumnLabels{idx} = sprintf('%d',idx);
    param.Stimuli.Value{1,idx}      = '';
    param.Stimuli.Value{2,idx}      = fullfile(settings.imagepath, 'Reliving_rating', ALL_IMAGES(idx_iter).name);
    param.Stimuli.Value{3,idx}      = '';
    param.Stimuli.Value{4,idx}      = settings.RatingDuration; %5s
    param.Stimuli.Value{5,idx}      = '0';    
    param.Stimuli.Value{6,idx}      = 'Reliving_rating'; 
    param.Stimuli.Value{7,idx}      = ''; %none, image on the screen for 5s 
    
    idx_iter = idx_iter + 1;

end 
 %answer keys KeyDown == 49', 'KeyDown == 50', 'KeyDown == 51', 'KeyDown ==
%  52'};---> answers 1-4

%% AM Valence rating 1501-2000

idx_iter = 1;
for idx = 1501:1500+num_images
    param.Stimuli.ColumnLabels{idx} = sprintf('%d',idx);
    param.Stimuli.Value{1,idx}      = '';
    param.Stimuli.Value{2,idx}      = fullfile(settings.imagepath,'Valence_rating', ALL_IMAGES(idx_iter).name);
    param.Stimuli.Value{3,idx}      = '';
    param.Stimuli.Value{4,idx}      = settings.RatingDuration; %5s
    param.Stimuli.Value{5,idx}      = '0';    
    param.Stimuli.Value{6,idx}      = 'Valence_rating'; 
    param.Stimuli.Value{7,idx}      = ''; %none, image on the screen for 5s 
    
    idx_iter = idx_iter + 1;
end 
%answer keys KeyDown == 49', 'KeyDown == 50', 'KeyDown == 51', 'KeyDown ==
%52'}; ---> answers 1-4

%% Instructions 2501-2510 - no instructions on screen for this task
InstructionsFilenames = {'task_instructions.png','end_instructions.png'};

start_idx = 2501;

for i = 1:length(InstructionsFilenames)
    idx = start_idx + (i - 1);
    param.Stimuli.ColumnLabels{idx} = sprintf('%d',idx);
    param.Stimuli.Value{1,idx}      = '';
    param.Stimuli.Value{2,idx}      = strcat(settings.instructionpath,slash,InstructionsFilenames{i});
    param.Stimuli.Value{3,idx}      = '';
    param.Stimuli.Value{4,idx}      = settings.InstructionDuration;
    param.Stimuli.Value{5,idx}      = '0';    
    param.Stimuli.Value{6,idx}      = 'instruction'; 
    param.Stimuli.Value{7,idx}      = 'KeyDown == 32'; % space key
    
    idx_iter = idx_iter + 1;
end 

%% Shaded boxes main task 2001-2100
num_boxes = 14;

idx_iter = 1;

for idx = 2001:2000+num_boxes(idx_iter)
    param.Stimuli.ColumnLabels{idx} = sprintf('%d',idx);
    param.Stimuli.Value{1,idx}      = '';
    param.Stimuli.Value{2,idx}      = fullfile(settings.boxespath, ['box' num2str(idx_iter) '.png']);
    param.Stimuli.Value{3,idx}      = '';
    param.Stimuli.Value{4,idx}      = settings.DistractorDuration; %5s
    param.Stimuli.Value{5,idx}      = '0';    
    param.Stimuli.Value{6,idx}      = 'shaded_boxes'; 
    param.Stimuli.Value{7,idx}      = 'KeyDown == 37 || KeyDown == 39'; % left or right arrow key
    
    idx_iter = idx_iter + 1;
end


%% Shaded boxes practice task 6001-6100
num_boxes = 14;

idx_iter = 1;

for idx = 6001:6000+num_boxes(idx_iter)
    param.Stimuli.ColumnLabels{idx} = sprintf('%d',idx);
    param.Stimuli.Value{1,idx}      = '';
    param.Stimuli.Value{2,idx}      = fullfile(settings.boxespath, ['box' num2str(idx_iter) '.png']);
    param.Stimuli.Value{3,idx}      = '';
    param.Stimuli.Value{4,idx}      = settings.DistractorDuration; %5s
    param.Stimuli.Value{5,idx}      = '0';    
    param.Stimuli.Value{6,idx}      = 'shaded_boxes'; 
    param.Stimuli.Value{7,idx}      = 'KeyDown == 37 || KeyDown == 39' ; %  left and right arrow key
    
    idx_iter = idx_iter + 1;
end


%% PRACTICE: Set up
num_practice = size(practice_set, 1);  % Number of practice images
shuffled_practice_idx = randperm(num_practice);  % consistent order across phases

% Practice AM Search 5501–5520
for i = 1:num_practice
    idx = 5500 + i;
    img_idx = shuffled_practice_idx(i);
    
    param.Stimuli.ColumnLabels{idx} = sprintf('%d', idx);
    param.Stimuli.Value{1,idx}      = '';
    param.Stimuli.Value{2,idx}      = fullfile(settings.practicepath,'Word_list',practice_set(img_idx).name);
    param.Stimuli.Value{3,idx}      = '';
    param.Stimuli.Value{4,idx}      = settings.ElaborationDuration;
    param.Stimuli.Value{5,idx}      = '0';
    param.Stimuli.Value{6,idx}      = 'practice_AM_search';
    param.Stimuli.Value{7,idx}      = 'KeyDown == 32'; % space
end

% Practice Elaboration 5521–5540
for i = 1:num_practice
    idx = 5520 + i;
    img_idx = shuffled_practice_idx(i);
    
    param.Stimuli.ColumnLabels{idx} = sprintf('%d', idx);
    param.Stimuli.Value{1,idx}      = '';
    param.Stimuli.Value{2,idx}      = fullfile(settings.practicepath, 'Word_list', practice_set(img_idx).name);
    param.Stimuli.Value{3,idx}      = '';
    param.Stimuli.Value{4,idx}      = settings.MaxSearchDuration;
    param.Stimuli.Value{5,idx}      = '0';
    param.Stimuli.Value{6,idx}      = 'practice_AM_elaboration';
    param.Stimuli.Value{7,idx}      = 'KeyDown == 32'; % space
end

% Practice Reliving Rating 5541–5560
for i = 1:num_practice
    idx = 5540 + i;
    img_idx = shuffled_practice_idx(i);
    
    param.Stimuli.ColumnLabels{idx} = sprintf('%d', idx);
    param.Stimuli.Value{1,idx}      = '';
    param.Stimuli.Value{2,idx}      = fullfile(settings.practicepath, 'Reliving_rating', practice_set(img_idx).name);
    param.Stimuli.Value{3,idx}      = '';
    param.Stimuli.Value{4,idx}      = settings.RatingDuration;
    param.Stimuli.Value{5,idx}      = '0';
    param.Stimuli.Value{6,idx}      = 'practice_Reliving_rating';
    param.Stimuli.Value{7,idx}      = '';
end

% Practice Valence Rating 5561–5580
for i = 1:num_practice
    idx = 5560 + i;
    img_idx = shuffled_practice_idx(i);
    
    param.Stimuli.ColumnLabels{idx} = sprintf('%d', idx);
    param.Stimuli.Value{1,idx}      = '';
    param.Stimuli.Value{2,idx}      = fullfile(settings.practicepath, 'Valence_rating', practice_set(img_idx).name);
    param.Stimuli.Value{3,idx}      = '';
    param.Stimuli.Value{4,idx}      = settings.RatingDuration;
    param.Stimuli.Value{5,idx}      = '0';
    param.Stimuli.Value{6,idx}      = 'practice_Valence_rating';
    param.Stimuli.Value{7,idx}      = ''; 
end

%% Sync pulse 2601
idx = 2601;
param.Stimuli.ColumnLabels{idx} = sprintf('%d',idx);
param.Stimuli.Value{1,idx}      = '';
param.Stimuli.Value{2,idx}      = '';
param.Stimuli.Value{3,idx}      = '';
param.Stimuli.Value{4,idx}      = settings.SyncPulseDuration;
param.Stimuli.Value{5,idx}      = '0';      
param.Stimuli.Value{6,idx}      = 'sync'; 
param.Stimuli.Value{7,idx}      = '';     
% param.Stimuli.Value{8,idx}      = ''; 
% param.Stimuli.Value{9,idx}      = ''; 


param.Stimuli.Value(8,:)      = repmat({''},1,total_events); 
param.Stimuli.Value(9,:)      = repmat({''},1,total_events); 

%% Build Practice Sequence
prac_seq = [5201];  % Start with ITI
num_practice_trials = 6;

for i = 1:num_practice_trials
    % shaded boxes
    box_seq = [6001, 6002, 6003, 6004, 6005, 6006, 6007, 6008, 6009, 6010, 6011, 6012, 6013, 6014];
    box_seq = box_seq(randperm(length(box_seq)));

    for j=1:length(box_seq)
        prac_seq = [prac_seq, box_seq(j), 5202];
    end

    % --- Stimulus indices ---
    search_idx      = 5500 + i;
    elaboration_idx = 5520 + i;
    reliving_idx    = 5540 + i;
    valence_idx     = 5560 + i;

    % --- Build trial block ---
    prac_seq = [prac_seq, ...
        search_idx, ...
        elaboration_idx, ...
        reliving_idx, ...
        valence_idx, ...
        5203];  % ITI between trials
end
prac_seq = prac_seq'; %transpose martix!


%% Build Main Task Sequence


task_seq = [5201];

for i=1:length(breakout_seq)

% shaded boxes
    box_seq = [2001:2014];
    box_seq = box_seq(randperm(length(box_seq)));

        for j=1:length(box_seq)
         task_seq = [task_seq, box_seq(j), 5202];
        end

    % --- Stimulus indices ---
    search_idx      = breakout_seq(i);
    elaboration_idx = 500 + search_idx;
    reliving_idx    = 1000 + search_idx;
    valence_idx     = 1500 + search_idx;

    % --- Build trial block ---
    task_seq = [task_seq, ...
        search_idx, ...
        elaboration_idx, ...
        reliving_idx, ...
        valence_idx, ...
        5203];  % ITI between trials
end

task_seq = task_seq';

% Assign to parameter
param.Sequence.Section      = 'Application';
param.Sequence.Type         = 'intlist';
param.Sequence.DefaultValue = '1';
param.Sequence.LowRange     = '1';
param.Sequence.HighRange    = '';
param.Sequence.Comment      = 'Full trial sequence including practice and main task';
param.Sequence.Value        = cellfun(@num2str, num2cell(task_seq), 'un', 0);
param.Sequence.NumericValue = task_seq;

%% UserComment
param.UserComment.Section         = 'Application';
param.UserComment.Type            = 'string';
param.UserComment.DefaultValue    = '';
param.UserComment.LowRange        = '';
param.UserComment.HighRange       = '';
param.UserComment.Comment         = 'User comments for a specific run';
param.UserComment.Value           = {settings.UserComment};

%%
param.SamplingRate.Section         = 'Source';
param.SamplingRate.Type            = 'int';
param.SamplingRate.DefaultValue    = '256Hz';
param.SamplingRate.LowRange        = '1';
param.SamplingRate.HighRange       = '';
param.SamplingRate.Comment         = 'sample rate';
param.SamplingRate.Value           = {settings.SamplingRate};

%%
param.SampleBlockSize.Section         = 'Source';
param.SampleBlockSize.Type            = 'int';
param.SampleBlockSize.DefaultValue    = '8';
param.SampleBlockSize.LowRange        = '1';
param.SampleBlockSize.HighRange       = '';
param.SampleBlockSize.Comment         = 'number of samples transmitted at a time';
param.SampleBlockSize.Value           = {settings.SampleBlockSize};

%%
param.NumberOfSequences.Section         = 'Application';
param.NumberOfSequences.Type            = 'int';
param.NumberOfSequences.DefaultValue    = '1';
param.NumberOfSequences.LowRange        = '0';
param.NumberOfSequences.HighRange       = '';
param.NumberOfSequences.Comment         = 'number of sequence repetitions in a run';
param.NumberOfSequences.Value           = {settings.NumberOfSequences};

%%
param.StimulusWidth.Section         = 'Application';
param.StimulusWidth.Type            = 'int';
param.StimulusWidth.DefaultValue    = '0';
param.StimulusWidth.LowRange        = '';
param.StimulusWidth.HighRange       = '';
param.StimulusWidth.Comment         = 'StimulusWidth in percent of screen width (zero for original pixel size)';
param.StimulusWidth.Value           = {settings.StimulusWidth};

%%
param.SequenceType.Section              = 'Application';
param.SequenceType.Type                 = 'int';
param.SequenceType.DefaultValue         = '0';
param.SequenceType.LowRange             = '0';
param.SequenceType.HighRange            = '1';
param.SequenceType.Comment              = 'Sequence of stimuli is 0 deterministic, 1 random (enumeration)';
param.SequenceType.Value                = {'0'};

%%
param.StimulusDuration.Section           = 'Application';
param.StimulusDuration.Type              = 'float';
param.StimulusDuration.DefaultValue      = '40ms';
param.StimulusDuration.LowRange          = '0';
param.StimulusDuration.HighRange         = '';
param.StimulusDuration.Comment           = 'stimulus duration';
param.StimulusDuration.Value             = {};

%%
param.ISIMaxDuration.Section       = 'Application';
param.ISIMaxDuration.Type          = 'float';
param.ISIMaxDuration.DefaultValue  = '80ms';
param.ISIMaxDuration.LowRange      = '0';
param.ISIMaxDuration.HighRange     = '';
param.ISIMaxDuration.Comment       = 'maximum duration of inter-stimulus interval';
param.ISIMaxDuration.Value         = {'0ms'};

%%
param.ISIMinDuration.Section       = 'Application';
param.ISIMinDuration.Type          = 'float';
param.ISIMinDuration.DefaultValue  = '80ms';
param.ISIMinDuration.LowRange      = '0';
param.ISIMinDuration.HighRange     = '';
param.ISIMinDuration.Comment       = 'minimum duration of inter-stimulus interval';
param.ISIMinDuration.Value         = {'0ms'};

%%
param.PreSequenceDuration.Section       = 'Application';
param.PreSequenceDuration.Type          = 'float';
param.PreSequenceDuration.DefaultValue  = '2s';
param.PreSequenceDuration.LowRange      = '0';
param.PreSequenceDuration.HighRange     = '';
param.PreSequenceDuration.Comment       = 'pause preceding sequences/sets of intensifications';
param.PreSequenceDuration.Value         = {'0s'};

%%
param.PostSequenceDuration.Section       = 'Application';
param.PostSequenceDuration.Type          = 'float';
param.PostSequenceDuration.DefaultValue  = '2s';
param.PostSequenceDuration.LowRange      = '0';
param.PostSequenceDuration.HighRange     = '';
param.PostSequenceDuration.Comment       = 'pause following sequences/sets of intensifications';
param.PostSequenceDuration.Value         = {'0s'};

%%
param.PreRunDuration.Section       = 'Application';
param.PreRunDuration.Type          = 'float';
param.PreRunDuration.DefaultValue  = '2000ms';
param.PreRunDuration.LowRange      = '0';
param.PreRunDuration.HighRange     = '';
param.PreRunDuration.Comment       = 'pause preceding first sequence';
param.PreRunDuration.Value         = {settings.PreRunDuration};

%%
param.PostRunDuration.Section       = 'Application';
param.PostRunDuration.Type          = 'float';
param.PostRunDuration.DefaultValue  = '2000ms';
param.PostRunDuration.LowRange      = '0';
param.PostRunDuration.HighRange     = '';
param.PostRunDuration.Comment       = 'pause following last squence';
param.PostRunDuration.Value         = {settings.PostRunDuration};


%%
param.BackgroundColor.Section      = 'Application';
param.BackgroundColor.Type         = 'string';
param.BackgroundColor.DefaultValue = '0x00FFFF00';
param.BackgroundColor.LowRange     = '0x00000000';
param.BackgroundColor.HighRange    = '0x00000000';
param.BackgroundColor.Comment      = 'Color of stimulus background (color)';
param.BackgroundColor.Value        = {settings.BackgroundColor};

%%
param.CaptionColor.Section      = 'Application';
param.CaptionColor.Type         = 'string';
param.CaptionColor.DefaultValue = '0x00FFFF00';
param.CaptionColor.LowRange     = '0x00000000';
param.CaptionColor.HighRange    = '0x00000000';
param.CaptionColor.Comment      = 'Color of stimulus caption text (color)';
param.CaptionColor.Value        = {settings.CaptionColor};

%%
param.WindowBackgroundColor.Section      = 'Application';
param.WindowBackgroundColor.Type         = 'string';
param.WindowBackgroundColor.DefaultValue = '0x00FFFF00';
param.WindowBackgroundColor.LowRange     = '0x00000000';
param.WindowBackgroundColor.HighRange    = '0x00000000';
param.WindowBackgroundColor.Comment      = 'background color (color)';
param.WindowBackgroundColor.Value        = {settings.WindowBackgroundColor};

%%
param.IconSwitch.Section          = 'Application';
param.IconSwitch.Type             = 'int';
param.IconSwitch.DefaultValue     = '1';
param.IconSwitch.LowRange         = '0';
param.IconSwitch.HighRange        = '1';
param.IconSwitch.Comment          = 'Present icon files (boolean)';
param.IconSwitch.Value            = {'1'};

%%
param.AudioSwitch.Section         = 'Application';
param.AudioSwitch.Type            = 'int';
param.AudioSwitch.DefaultValue    = '1';
param.AudioSwitch.LowRange        = '0';
param.AudioSwitch.HighRange       = '1';
param.AudioSwitch.Comment         = 'Present audio files (boolean)';
param.AudioSwitch.Value           = {'0'};

%%
param.CaptionSwitch.Section       = 'Application';
param.CaptionSwitch.Type          = 'int';
param.CaptionSwitch.DefaultValue  = '1';
param.CaptionSwitch.LowRange      = '0';
param.CaptionSwitch.HighRange     = '1';
param.CaptionSwitch.Comment       = 'Present captions (boolean)';
param.CaptionSwitch.Value         = {settings.CaptionSwitch};

%%
param.WindowHeight.Section        = 'Application';
param.WindowHeight.Type           = 'int';
param.WindowHeight.DefaultValue   = '480';
param.WindowHeight.LowRange       = '0';
param.WindowHeight.HighRange      = '';
param.WindowHeight.Comment        = 'height of application window';
param.WindowHeight.Value          = {settings.WindowHeight};

%%
param.WindowWidth.Section        = 'Application';
param.WindowWidth.Type           = 'int';
param.WindowWidth.DefaultValue   = '480';
param.WindowWidth.LowRange       = '0';
param.WindowWidth.HighRange      = '';
param.WindowWidth.Comment        = 'width of application window';
param.WindowWidth.Value          = {settings.WindowWidth};

%%
param.WindowLeft.Section        = 'Application';
param.WindowLeft.Type           = 'int';
param.WindowLeft.DefaultValue   = '0';
param.WindowLeft.LowRange       = '';
param.WindowLeft.HighRange      = '';
param.WindowLeft.Comment        = 'screen coordinate of application window''s left edge';
param.WindowLeft.Value          = {settings.WindowLeft};

%%
param.WindowTop.Section        = 'Application';
param.WindowTop.Type           = 'int';
param.WindowTop.DefaultValue   = '0';
param.WindowTop.LowRange       = '';
param.WindowTop.HighRange      = '';
param.WindowTop.Comment        = 'screen coordinate of application window''s top edge';
param.WindowTop.Value          = {settings.WindowTop};

%%
param.CaptionHeight.Section      = 'Application';
param.CaptionHeight.Type         = 'int';
param.CaptionHeight.DefaultValue = '0';
param.CaptionHeight.LowRange     = '0';
param.CaptionHeight.HighRange    = '100';
param.CaptionHeight.Comment      = 'Height of stimulus caption text in percent of screen height';
param.CaptionHeight.Value        = {'5'};

%%
param.WarningExpression.Section      = 'Filtering';
param.WarningExpression.Type         = 'string';
param.WarningExpression.DefaultValue = '';
param.WarningExpression.LowRange     = '';
param.WarningExpression.HighRange    = '';
param.WarningExpression.Comment      = 'expression that results in a warning when it evaluates to true';
param.WarningExpression.Value        = {''};

%%
param.Expressions.Section      = 'Filtering';
param.Expressions.Type         = 'matrix';
param.Expressions.DefaultValue = '';
param.Expressions.LowRange     = '';
param.Expressions.HighRange    = '';
param.Expressions.Comment      = 'expressions used to compute the output of the ExpressionFilter';
param.Expressions.Value        = {''};

%%
param.SubjectName.Section      = 'Storage';
param.SubjectName.Type         = 'string';
param.SubjectName.DefaultValue = 'Name';
param.SubjectName.LowRange     = '';
param.SubjectName.HighRange    = '';
param.SubjectName.Comment      = 'subject alias';
param.SubjectName.Value        = {settings.SubjectName};

%%
param.DataDirectory.Section      = 'Storage';
param.DataDirectory.Type         = 'string';
param.DataDirectory.DefaultValue = strcat('..',slash,',,', slash, 'data');
param.DataDirectory.LowRange     = '';
param.DataDirectory.HighRange    = '';
param.DataDirectory.Comment      = 'path to top level data directory (directory)';
param.DataDirectory.Value        = {settings.DataDirectory};

%%
param.SubjectRun.Section      = 'Storage';
param.SubjectRun.Type         = 'string';
param.SubjectRun.DefaultValue = '00';
param.SubjectRun.LowRange     = '';
param.SubjectRun.HighRange    = '';
param.SubjectRun.Comment      = 'two-digit run number';
param.SubjectRun.Value        = {settings.SubjectRun};

%%
param.SubjectSession.Section      = 'Storage';
param.SubjectSession.Type         = 'string';
param.SubjectSession.DefaultValue = '00';
param.SubjectSession.LowRange     = '';
param.SubjectSession.HighRange    = '';
param.SubjectSession.Comment      = 'three-digit session number';
param.SubjectSession.Value        = {settings.SubjectSession};

%% save param.stimuli.value AND save the sequence (seq variable) to .mat files
%param_value = param.Stimuli.Value;
%save(['study_param_value', num2str(breakoutnum_iter),'.mat'], 'param_value')
%save(['study_task_sequence', num2str(breakoutnum_iter), '.mat'], 'taskseq')

%% write the param struct to a bci2000 parameter file
parameter_lines = convert_bciprm( param );
fid = fopen(strcat(settings.parm_filename, 'breakout_', num2str(breakoutnum_iter), '.prm'), 'w');

for i=1:length(parameter_lines)
    fprintf( fid, '%s', parameter_lines{i} );
    fprintf( fid, '\r\n' );
end
fclose(fid);

%% Write study practice parameter file 
param.Sequence.Value        = cellfun(@num2str, num2cell(prac_seq), 'un',0);
param.Sequence.NumericValue = prac_seq;
parameter_lines = convert_bciprm( param );
fid = fopen(strcat(settings.parm_filename, 'practice_', num2str(breakoutnum_iter), '.prm'), 'w');

for i=1:length(parameter_lines)
    fprintf( fid, '%s', parameter_lines{i} );
    fprintf( fid, '\r\n' );
end
fclose(fid);
