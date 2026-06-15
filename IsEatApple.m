function result = EatCheck()
    result = false;
    if Snake.Body(1,:) + Snake.Dir == Snake.Apple 
        result = true;
    end
end