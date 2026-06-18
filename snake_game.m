%% Login sys
LoginFigure();

%% Initial the game     

[ax, fig] = InitPlayground(@(~, ~) []);
hold(ax, 'on');
Game_text = text(ax, -6.5, 15.5, {
      'W - Up'
      'S - Down'
      'A - Left'
      'D - Right'
  }, ...        
        'Color', 'k', ...
        'FontSize', 14);


%% LeaderBoard Sys

load("Top.mat")

LeaderBoardText = {
    sprintf('1st %s %d points', Top(1).Name, Top(1).Score)
    sprintf('2nd %s %d points', Top(2).Name, Top(2).Score)
    sprintf('3rd %s %d points', Top(3).Name, Top(3).Score)
};

LeaderBoard = text(ax, -6.5, 11.5, LeaderBoardText, ...
    'Color', 'k', ...
    'FontSize', 14);


%% Main game loop

Top(4).Score = CreateAGame(ax, fig);
save('Top.mat', 'Top');

%% EndTheGame 

GameOver(ax);

%% LeaderBoard Sys

load("Top.mat")

LeaderBoardText = {
    sprintf('1st %s %d points', Top(1).Name, Top(1).Score)
    sprintf('2nd %s %d points', Top(2).Name, Top(2).Score)
    sprintf('3rd %s %d points', Top(3).Name, Top(3).Score)
};

set(LeaderBoard, 'String', LeaderBoardText);

%% 
