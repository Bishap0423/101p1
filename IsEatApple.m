% Check if snake's next head position hits apple
% Output: true if eat apple, false otherwise
function result = EatCheck()
    % Default state: not eating apple
    result = false;
    % Calculate next head coordinate and compare with apple position
    if Snake.Body(1,:) + Snake.Dir == Snake.Apple 
        result = true;
    end
end
