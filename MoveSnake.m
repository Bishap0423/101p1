% Update snake body position for two movement modes
% Input: Snake - snake struct; evt - movement event type
% Output: Updated Snake struct
function Snake= MoveSnake(Snake, evt)
    switch evt 
        % Normal move: no apple eaten, snake length fixed
        % Every body block copies the coordinate of the block in front of it, then head moves forward — tail is discarded automatically.

        case "evt_normal"
            % Shift all body segments backward from tail to head
            % Prepend apple coordinate as new head row to the top of Body matrix, snake gains one segment, tail remains.
            for i = size(Snake.Body,1): -1 : 2
                Snake.Body(i,:) = Snake.Body(i-1,:);
            end
            % Calculate new head position
            Snake.Body(1,:) = Snake.Body(1,:) + Snake.Dir;
        % Ate apple: add new head at apple coordinate, body grows longer
        case "evt_apple"
            Snake.Body = [Snake.Apple; Snake.Body];
    end
end
