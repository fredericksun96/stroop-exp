clear; close all;
AssertOpenGL;

Screen('Preference', 'SkipSyncTests', 1);
rand('seed',sum(clock*100)); % for octave
% colors
black = [0 0 0];
white = [255 255 255];
red = [255 0 0];
green = [0 255 0];
blue = [0 0 255];
gray = [128 128 128];
yellow = [255 255 0];
orange = [255 165 0];
colors_strings = {'red', 'green', 'blue', 'yellow', 'orange', 'white'};
colors_vars = {red, green, blue, yellow, orange, white};
%store trials into matrix, and RANDOMIZE TRIALS
trialInfo = fullfact([2 6]);
% MAKE TRIALINFO REPEAT 5 TIMES. 
repTimes = 5;
trialInfo = repmat(trialInfo,repTimes,1);
nTrials = length(trialInfo);
trialInfo = trialInfo(randperm(nTrials),:); %randomized conditions

% a matrix that will store responses--c is 1, i is 2
resp = zeros(nTrials,1);
% a matrix that will store response times
respTimes = zeros(nTrials,1);
% a matrix that says whether they were correct or not--correct is 1, else is 0
correct = zeros(nTrials,1);

%DONE IN OCTAVE, for KbName, there is no 'escape' in octave, it's 'esc'
% present each word, congruent or incongruent, and wait for a response 

win = Screen('OpenWindow',0, gray);
Screen('Flip',win);
Screen('TextSize', win, 24);
try
  for ii = 1:nTrials % 1 test
    trialColor = trialInfo(ii, 2); % store this for later. It'll be the number corresponding to color
    if trialInfo(ii, 1) == 1  % 1 is the congruent case
      DrawFormattedText(win,upper(colors_strings{trialColor}), 'center', 'center', colors_vars{trialColor});
      Screen('Flip', win);
      
      % GET THE KEYPRESS. IF ESC, GET OUT. IF C, resp(ii) = 1, if I, resp(ii) = 2

      exitNow = false;
      validKey = false;
      trialStartTime = GetSecs;
      while ~validKey 
        % get keypress
        [secs, keyCode] = KbStrokeWait;
        keyPressed = KbName(keyCode);
    
        % record what key was pressed
        if strcmpi(keyPressed,'c')
            resp(ii) = 1;
            %noGoodKey = false;
            validKey = true;
        elseif strcmpi(keyPressed,'i')
            resp(ii) = 2;
            validKey = true;
        elseif strcmpi(keyPressed,'esc')
            validKey = true;
            exitNow = true;
        end
      end
      respTimes(ii) = secs - trialStartTime;
      
    % if exit key pressed, stop the trials
      if exitNow 
        break;
      end
       
       % IF THE INCONGRUENT CONDITION 
    else
      
      tempColorsStr = colors_strings;  %make a temp array which will delete the color that was originally inside
      tempColorsStr(trialColor) = [];
      thisColor = randi(5);
    
      % display a random word with the color. The word will not be the color 
      DrawFormattedText(win, upper(tempColorsStr{thisColor}), 'center', 'center', colors_vars{trialColor});
      Screen('Flip', win);
      
      % GET THE KEYPRESS. IF ESC, GET OUT. IF C, resp(ii) = 1, if I, resp(ii) = 2
      exitNow = false;
      validKey = false;
      trialStartTime = GetSecs;
      while ~validKey 
        % get keypress
        [secs, keyCode] = KbStrokeWait;
        keyPressed = KbName(keyCode);
    
        % record what key was pressed
        if strcmpi(keyPressed,'c')
            resp(ii) = 1;
            %noGoodKey = false;
            validKey = true;
        elseif strcmpi(keyPressed,'i')
            resp(ii) = 2;
            validKey = true;
        elseif strcmpi(keyPressed,'esc')
            validKey = true;
            exitNow = true;
        end
      end
      respTimes(ii) = secs - trialStartTime;
    end 
    
    %for exit 
      if exitNow 
        break;
      end   
      
   % STORE IF THE CURRENT TRIAL HAS THE CORRECT ANSWER
   correct(ii) = resp(ii) == trialInfo(ii,1);
   
  end
  sca;
catch
    sca;
    psychrethrow(psychlasterror);
end
% part e) save stuff 
save('StroopData.mat', 'correct', 'resp', 'respTimes', 'trialInfo');

% part f) 
% create meanRT with two rows for incongruent and congruent, 6 columns for each word
meanRT = zeros(2,6); % preallocate. Row 1 will be congruent, row 2 incon
% create meanCR, with two rows similar. Calculates average correct
meanCR = zeros(2,6);

for ii = 1:size(meanRT,1) % this should be 2
  for jj = 1: size(meanRT,2) % and this will be 6
    meanRT(ii,jj) = sum(respTimes(trialInfo(:,1) == ii & trialInfo(:,2) == jj))/repTimes;
    meanCR(ii,jj) = sum(correct(trialInfo(:,1) == ii & trialInfo(:,2) == jj))/repTimes;
  end
end




  