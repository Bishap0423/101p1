% Update snake body position every frame
% Input 1: Snake - Snake struct storing body matrix & moving direction vector
% Input 2: evt - Event type string, two modes: "evt_normal" / "evt_apple"
% Output: Snake - Updated snake struct with new body coordinates
function Snake= MoveSnake(Snake, evt)
    % Judge movement mode by event string
    switch evt 
        case "evt_normal"
            % Normal movement (no apple eaten): snake length stays the same
            % Loop from last body segment backward to the 2nd segment
            for i = size(Snake.Body,1): -1 : 2
                % Each body block follows the position of the block in front of it
                Snake.Body(i,:) = Snake.Body(i-1,:);
            end
            % Update head to new forward position based on direction vector
            Snake.Body(1,:) = Snake.Body(1,:) + Snake.Dir;

        case "evt_apple"
            % Eat apple movement: snake grows longer by 1 block
            % Calculate new head coordinate after moving forward
            newHead = Snake.Body(1,:) + Snake.Dir;
            % Stack new head on top of original body matrix, tail remains unchanged
            Snake.Body = [newHead; Snake.Body];
    end
end