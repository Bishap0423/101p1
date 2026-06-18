% Collision detection function: Check if snake's next moving head will hit the apple
% Input 1: Snake - Snake struct storing body coordinates & moving direction
% Input 2: ApplePos - 1×2 vector storing current apple grid position [x,y]
% Output: result - Boolean true/false, true = snake eats apple in this frame
function result = EatCheck(Snake, ApplePos)
    % Initialize default return value: snake does NOT hit apple
    result = false;

    % Calculate the coordinate of snake head after one frame movement
    % Snake.Body(1,:) = current head position; Snake.Dir = movement vector
    NextHead = Snake.Body(1,:) + Snake.Dir;

    % Judge: if next head position exactly matches apple position
    if isequal(NextHead, ApplePos)
        % Set flag to true, inform main game code the snake ate the apple
        result = true;
    end
end