%% Login sys
% Call login window function to pop up login UI for player username input
LoginFigure();

%% Initial the game  
% Initialize game canvas, returns plotting axis ax and main figure window fig
% @(~, ~) [] is an empty anonymous callback reserved for mouse interaction, unused currently
[ax, fig] = InitPlayground(@(~, ~) []);

% Loop control flag: whether to restart the game, initialized true to run at least one round
playAgain = true;

% Main game loop: repeat full game flow if player chooses to replay
while playAgain == true
    % Clear all graphics on axis ax to erase leftover visuals from last round
    cla(ax);
    % Enable hold on axis to draw multiple texts/shapes without overwriting each other
    hold(ax, 'on');

    % Draw white background panel on left side to hold control instructions and leaderboard text
    % Position format: [bottom-left x, bottom-left y, width, height]
    rectangle(ax, ...
        'Position', [-7, 0.5, 7.5, 20], ...
        'FaceColor', 'white', ...     % Fill rectangle with solid white
        'EdgeColor', 'none');         % Hide rectangle border outline

    % Render WASD movement control guide text at fixed coordinate (-6.5, 15.5)
    Game_text = text(ax, -6.5, 15.5, {
          'W - Up'    % W key: move character upward
          'S - Down'  % S key: move character downward
          'A - Left'  % A key: move character leftward
          'D - Right' % D key: move character rightward
      }, ...        
        'Color', 'k', ...    % Set text color to black
        'FontSize', 14);     % Set text font size to 14


%% LeaderBoard Sys - Load leaderboard before starting each game round
% Load local save file Top.mat which stores leaderboard struct array Top
% Top(1) = 1st place, Top(2) = 2nd place, Top(3) = 3rd place, Top(4) = current player record
load("Top.mat")

% Format text strings containing rank, player name and score using sprintf
LeaderBoardText = {
    sprintf('1st %s %d points', Top(1).Name, Top(1).Score)
    sprintf('2nd %s %d points', Top(2).Name, Top(2).Score)
    sprintf('3rd %s %d points', Top(3).Name, Top(3).Score)
};

% Create leaderboard text object on canvas, store handle to LeaderBoard for later refresh
LeaderBoard = text(ax, -6.5, 11.5, LeaderBoardText, ...
    'Color', 'k', ...
    'FontSize', 14);


%% Main game loop - Execute one full game session
% Launch core game logic function with canvas and window handles, returns final score of this round
% Save current round score into the 4th leaderboard entry for active player
Top(4).Score = CreateAGame(ax, fig);

% Safety check: if player manually closes game window or axis, exit main loop immediately
if ~isvalid(fig) || ~isvalid(ax)
    break
end

% Overwrite local save file with updated leaderboard struct to persist new score data
save('Top.mat', 'Top');

%% EndTheGame - Render game over screen UI
% Call game over render function to draw game over banner and score settlement panel
GameOver(ax);

%% LeaderBoard Sys - Refresh leaderboard after game finishes
% Reload leaderboard save file to fetch updated ranking data
load("Top.mat")

% Regenerate formatted top 3 leaderboard text strings
LeaderBoardText = {
    sprintf('1st %s %d points', Top(1).Name, Top(1).Score)
    sprintf('2nd %s %d points', Top(2).Name, Top(2).Score)
    sprintf('3rd %s %d points', Top(3).Name, Top(3).Score)
};

% Update existing leaderboard text object to display latest rankings (no new text object created)
set(LeaderBoard, 'String', LeaderBoardText);

% Draw replay prompt text at coordinate (-6.5, 4.5)
text(ax, -6.5, 4.5, { ...
    "Press Enter try again!"}, ...        
    'Color', 'k', ...
    'FontSize', 14);

% Blocking function: wait for player to press Enter key, return boolean replay flag
% true = Enter pressed, restart game loop; false = window closed / quit, terminate loop
playAgain = WaitForReturn(fig);

% End of while loop, jump back to loop condition check for another game round
end
