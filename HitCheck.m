function result = HitCheck(Snake)
    result = false;
    NextHead = Snake.Body(1,:) + Snake.Dir;
    Snake.Body(end, :) = [0 0];
    if NextHead(1) > 20 || NextHead(2) > 20 ||...
       NextHead(1) < 1  || NextHead(2) < 1
        result = true;
    elseif ismember(NextHead, Snake.Body, 'rows')
        result = true;
    end
end