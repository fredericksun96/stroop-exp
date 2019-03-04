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
%part a) store trials into matrix
trialInfo = fullfact([2 6]);
% FOR EC--MAKE IT SO INCONGRUENT CASES ONLY SHOW ONCE
colors_vars2 = {'red', 'green', 'blue', 'yellow', 'orange', 'white'};
% part b) present each word, congruent or incongruent, for 2 seconds each

win = Screen('OpenWindow',0, gray);
Screen('Flip',win);
Screen('TextSize', win, 24);
try
  for ii = 1:length(trialInfo)
    trialColor = trialInfo(ii, 2); % store this for later. It'll be the number corresponding to color
    if trialInfo(ii, 1) == 1  % 1 is the congruent case
      DrawFormattedText(win,upper(colors_strings{trialColor}), 'center', 'center', colors_vars{trialColor});
      Screen('Flip', win);
      WaitSecs(2);      
    else
      
      tempColorsStr = colors_strings;  %make a temp array which will delete the color that was originally inside
      tempColorsStr(trialColor) = [];
      thisColor = randi(5);
    
      % display a random word with the color. The word will not be the color 
      DrawFormattedText(win, upper(tempColorsStr{thisColor}), 'center', 'center', colors_vars{trialColor});
      Screen('Flip', win);
      WaitSecs(2);
    end 
    
  end
  sca;
catch
    sca;
    psychrethrow(psychlasterror);
end