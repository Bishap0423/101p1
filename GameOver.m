function GameOver(ax)
    load('Top.mat', 'Top');

    GameStateText = {
        sprintf('Congratulation!')
        sprintf('%s, You got %d Points!', Top(4).Name, Top(4).Score)
        };

    text(ax, -6.5, 7.5, GameStateText, ...
        'Color', 'k', ...
        'FontSize', 14);

    scores = [Top.Score];
    [~, idx] = sort(scores, 'descend');
    Top = Top(idx);

    save('Top.mat', 'Top');

    