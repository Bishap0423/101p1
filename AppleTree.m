% Function to generate a random apple coordinate on 20x20 grid
% Input: Snake (P1 snake struct), Snake2 (P2 snake struct)
% Output: Snake struct with updated .Apple position
function Snake = AppleTree(Snake, Snake2)
    % Create full grid coordinate matrix X (horizontal 1~20), Y (vertical 1~20)
    [X, Y] = meshgrid(1:20, 1:20);
    % Convert all grid points into N×2 matrix format [x, y] for easy comparison
    Map = [X(:), Y(:)];

    % Merge body coordinates of both Player1 and Player2 snake
    % Apple will NOT spawn on any body segment of either snake
    AllOccupiedCells = [Snake.Body; Snake2.Body];

    % Check every grid point: mark true if point overlaps snake body
    Occupied = ismember(Map, AllOccupiedCells, 'rows');

    % Filter grid, only keep coordinates that are NOT occupied by snakes
    free = Map(~Occupied,:);

    % Judge win condition: no empty cells left on entire map
    if isempty(free)
        % Set apple to [0,0] as win signal for main game loop
        Snake.Apple = [0 0];
    else
        % Pick one random empty coordinate as new apple position
        randomIndex = randi(size(free,1));
        Snake.Apple = free(randomIndex,:);
    end
end