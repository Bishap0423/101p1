%% Initial the game     

[ax, fig] = InitPlayground(@onKeyPress);
Score_text = text(ax, -6.5, 19.5, 'Score: 0', ...
        'Color', 'k', ...
        'FontSize', 14);
Game_text = text(ax, -6.5, 15.5, {
      'W - Up'
      'S - Down'
      'A - Left'
      'D - Right'
  }, ...        
        'Color', 'k', ...
        'FontSize', 14);

%% LeaderBoard Sys

fid = fopen('PlayerData.txt', 'r');
data = textscan(fid, '%s %u');
fclose(fid);

Name = data{1};
Score = data{2};

LeaderBoardText = {
    sprintf('1st %s %d points', Name{1}, Score(1))
    sprintf('2nd %s %d points', Name{2}, Score(2))
    sprintf('3rd %s %d points', Name{3}, Score(3))
};

LeaderBoard = text(ax, -6.5, 11.5, LeaderBoardText, ...
    'Color', 'k', ...
    'FontSize', 14);
