function result = EatCheck(Snake)
    result = false;
    if Snake.Body(1,:) + Snake.Dir == Snake.Apple 
        result = true;
    end
end