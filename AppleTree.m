function Snake = AppleTree(Snake)
    [X, Y] = meshgrid(1:20, 1:20);
    Map = [X(:), Y(:)];
    Occupied = ismember(Map, Snake.Body, 'rows');
    free = Map(~Occupied,:);
    if isempty(free)
        Snake.Apple = [0 0];
    else
        Snake.Apple = free(randi(size(free,1)),:);
    end
end
