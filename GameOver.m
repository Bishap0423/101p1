function GameOver(ax)
% Function: Draw game-over settlement text and re-sort leaderboard rankings
% Input ax: Target axes handle for drawing UI text

    % Load the leaderboard struct variable "Top" from local file Top.mat
    load('Top.mat', 'Top');

    % Create cell array storing game over display text lines
    GameStateText = {
        sprintf('Congratulation!')  % First line: congratulatory message
        sprintf('%s, You got %d Points!', Top(4).Name, Top(4).Score) % Second line: show current player's name and final score
        };

    % Render the game over text panel on the given axes at coordinate (-6.5, 7.5)
    text(ax, -6.5, 7.5, GameStateText, ...
        'Color', 'k', ...       % Set text color to black
        'FontSize', 14);        % Set text font size to 14

    % Extract all player scores from the Top struct array into a numeric vector
    scores = [Top.Score];

    % Sort scores in descending order (highest score first)
    % ~ discards sorted score values; idx stores the new sorted index order of players
    [~, idx] = sort(scores, 'descend');

    % Rearrange the Top struct array using sorted indices to update rankings
    Top = Top(idx);

    % Save the newly sorted leaderboard back to Top.mat to permanently update rankings
    save('Top.mat', 'Top');
end
