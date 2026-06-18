% Collision detection function: Check if snake will crash in next frame
% Input: Snake - Snake struct containing body coordinates and movement direction
% Output: result - Boolean true/false, true = collision occurs (game over)
function result = HitCheck(Snake)
    % Set default state: no collision
    result = false;

    % Calculate the position the snake head will move to in the next frame
    NextHead = Snake.Body(1,:) + Snake.Dir;

    % First collision rule: Wall boundary crash
    % Grid range is 1 ~ 20 for both X and Y axes
    % If head X/Y is outside this range, hit wall
    if NextHead(1) > 20 || NextHead(2) > 20 || NextHead(1) < 1 || NextHead(2) < 1
        result = true;
    % Second collision rule: Hit own body
    % Snake.Body(1:end-1,:) = all body segments EXCEPT the last tail
    % Avoid false collision when snake only has head + 1 tail block
    elseif ismember(NextHead, Snake.Body(1:end-1,:), 'rows')
        result = true;
    end
end