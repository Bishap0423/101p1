%% ====================== GAME WINDOW & UI TEXT INITIALIZATION ======================
% Call playground init function to create game canvas, bind keyboard callback
[ax, fig] = InitPlayground(@onKeyPress);

% Draw static score display text on left white sidebar
% X=-6.5 keeps text fully inside wide white panel, avoid black background overlap
Score_text = text(ax, -6.5, 19.5, 'Score: 0', ...
        'Color', 'k', ...       % Font color: black
        'FontSize', 14);        % Font size setting

% Draw single-player control hint text, split to vertical short lines to prevent horizontal overflow
Game_text = text(ax, -6.5, 15.5, {
      'W - Up'
      'S - Down'
      'A - Left'
      'D - Right'
  }, ...        
        'Color', 'k', ...
        'FontSize', 14);

%% ====================== LEADERBOARD FILE LOADING SYSTEM ======================
% Open PlayerData.txt file in read-only mode
fid = fopen('PlayerData.txt','r');

% Check if file opened successfully (fid = -1 means file not found / cannot read)
if fid ~= -1
    % Read file content: format = string(player name) + unsigned integer(score)
    data = textscan(fid, '%s %u');
    fclose(fid); % Close file handle after reading to release resource
    Name = data{1};  % Extract all player names from file
    Score = data{2}; % Extract matching player scores from file
else
    % Fallback default data when PlayerData.txt does not exist
    Name = {"Empty","Empty","Empty"};
    Score = [0,0,0];
end