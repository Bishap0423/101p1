function result = HitCheck(Snake)
    result = false;
    NextHead = Snake.Body(1,:) + Snake.Dir;
    % Wall boundary collision
    if NextHead(1) > 20 || NextHead(2) > 20 || NextHead(1) < 1 || NextHead(2) < 1
        result = true;
    % Hit own body
    elseif ismember(NextHead, Snake.Body(1:end-1,:), 'rows')
        result = true;
    end
end