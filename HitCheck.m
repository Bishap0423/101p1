% Check if snake hits wall or itself
% Input: Snake struct with Body, Dir
% Output: true if collision happens, false otherwise
function result = HitCheck(Snake)
    % Default no collision
    result = false;
    % Calculate snake head position after moving (1,:) = first row, all columns
    NextHead = Snake.Body(1,:) + Snake.Dir;
    % Remove tail temporarily to avoid false self-collision
    Snake.Body(end, :) = [0 0];
    % Judge wall collision (game boundary 1~20), NextHead(1) is x position, (2) is y position
    if NextHead(1) > 20 || NextHead(2) > 20 ||...
       NextHead(1) < 1  || NextHead(2) < 1
        result = true;
    % Judge self collision: check if next head overlaps body segments
    elseif ismember(NextHead, Snake.Body, 'rows')
        result = true;
    end
end
