% Check if snake's next head position hits the apple
% Input: Snake - Snake struct (Body + Dir), ApplePos - coordinate of apple [x,y]
% Output: result = true / false, true means snake eats apple
function result = IsEatApple(Snake, ApplePos)
    % Default status: not hitting apple
    result = false;
    
    % Calculate the coordinate the snake head will move to next frame
    NextHeadPos = Snake.Body(1,:) + Snake.Dir;
    
    % Judge if next head position overlaps apple position
    if isequal(NextHeadPos, ApplePos)
        result = true;
    end
end