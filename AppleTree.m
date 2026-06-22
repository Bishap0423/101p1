function Snake = AppleTree(Snake)
% Function: Randomly generate a new apple position that does not overlap the snake body
% Input:  Snake - Struct containing snake body coordinates and apple position
% Output: Snake - Updated struct with new valid apple coordinates

    % Create full grid coordinate matrix for game map (range X:1~20, Y:1~20)
    % Column count = how many x points you have
    %Row count = how many y points you have
    [X, Y] = meshgrid(1:20, 1:20);
    
    % Convert grid matrix into N×2 coordinate list, each row = [x, y]
    Map = [X(:), Y(:)]; % Map = 400*2 matrix
    
    % Check which map coordinates are occupied by the snake's body
    % 'rows' compares entire coordinate pairs instead of single values
    Occupied = ismember(Map, Snake.Body, 'rows'); %Treats each entire row as one single unit / coordinate pair

    
    % Filter out occupied rows, choose all columns
    free = Map(~Occupied,:);
    
    % Judge if the entire map is filled with snake body (game full / game over)
    if isempty(free)
        % Set apple to dummy [0,0] when no empty space left
        Snake.Apple = [0 0];
    else
        % Pick a random empty coordinate as the new apple location
        % size(free,1): 1 means returns number of rows in "free"
        % randi(size(free,1)) generates random row index of free position list

        % randi gives 1:size(free,1)
        Snake.Apple = free(randi(size(free,1)),:);
    end
end
