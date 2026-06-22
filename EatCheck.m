% Check if snake will eat apple in next move
% Input: Snake struct contains Body, Dir, Apple
% Output: true if eat apple, false otherwise
function result = EatCheck(Snake)
    % Initialize flag as not eating apple
    result = false;
    % Get current head pos + direction offset = next head pos, compare with apple pos
    if Snake.Body(1,:) + Snake.Dir == Snake.Apple 
        result = true;
    end
end
