% Create rectangle graphics object for ONE snake body segment
% Input: n - index of snake body block; Snake - snake struct
% Output: snake_rec - handle of rectangle graphic
function snake_rec = InitABody(n, Snake)
    % Draw a square block for snake part n
    snake_rec = rectangle( ...
        "FaceColor", [1 1 1], ...    % Fill color white
        "EdgeColor", 'none', ...     % No border line
        % Position: [x_left y_bottom width height]
        % Offset -0.5 to center square on grid coordinate
        'Position', [Snake.Body(n,1)-0.5 Snake.Body(n,2)-0.5 1 1], ...
        "Parent",fig);               % Attach figure to window fig
                                     % First index n: row number → the n-th segment of snake body
                                     % Second index 1: column 1 → X coordinate
end
