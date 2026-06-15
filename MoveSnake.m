function Snake= MoveSnake(Snake, evt)
    switch evt 
        case "evt_normal"
            for i = size(Snake.Body,1): -1 : 2
                Snake.Body(i,:) = Snake.Body(i-1,:);
            end
            Snake.Body(1,:) = Snake.Body(1,:) + Snake.Dir;
        case "evt_apple"
            Snake.Body = [Snake.Apple; Snake.Body];
    end
end

           
    