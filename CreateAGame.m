function CreateAGame()
    [ax, fig] = InitPlayground(@onKeyPress);
    FPS = 8;
    hold(ax, 'on');

    snake_rectangle = gobjects(400, 1);
    Snake.Body = [2 20;1 20];
    Snake.Dir = [1 0];
    Snake.NextDir = [1 0];
    Snake.Apple = [5 9];
    Snake = AppleTree(Snake);
    Scores = 0;

    % DashBoard

    Snake_Head_Color = [0 1 1];
    Snake_Tail_Color = [0 0.3 0.4];

    %main loop
    snake_rectangle(1) = rectangle( ...
        "FaceColor", Snake_Head_Color, ... % head Color
        'Position', [Snake.Body(1,1)-0.5 Snake.Body(1,2)-0.5 1 1], ...
        'EdgeColor','none', ...
        "Parent",ax);
    snake_rectangle(2) = rectangle( ...
        "FaceColor", Snake_Tail_Color, ... %Tail color
        'Position', [Snake.Body(2,1)-0.5 Snake.Body(2,2)-0.5 1 1], ...
        'EdgeColor','none', ...
        "Parent",ax);
    apple_rec = rectangle( ...
        'FaceColor', 'r', ...
        'Position', [Snake.Apple(1)-0.5, Snake.Apple(2)-0.5, 1, 1]);
    Score_text = text(ax, -4, 19.5, 'Score: 0', ...
        'Color', 'k', ...
        'FontSize', 14);
    Game_text = text(ax, -4, 15.5, {
      'W - Up'
      'S - Down'
      'A - Left'
      'D - Right'
  }, ...        
        'Color', 'k', ...
        'FontSize', 14);
        

    while isvalid(fig) && true

        EndReason = "Unexcept Quit";

        Snake.Dir = Snake.NextDir;

        if HitCheck(Snake)
            EndReason = "You fail";
            break
        elseif EatCheck(Snake)
            Snake = MoveSnake(Snake, "evt_apple");
            snake_rectangle(size(Snake.Body,1)) = rectangle( ...
                "FaceColor", [1 1 1], ...
                'Position', [Snake.Body(size(Snake.Body,1),1)-0.5 Snake.Body(size(Snake.Body,1),2)-0.5 1 1], ...
                "Parent",ax);
            Snake = AppleTree(Snake);
            if Snake.Apple == [0 0] % win
                Scores = Scores + 1;
                EndReason = "You win";
                set(apple_rec, 'FaceColor',[1 1 1]);
                break
            end
            Scores = Scores + 1;
            set(Score_text, 'String', sprintf('Score: %d', Scores));
        else
            Snake = MoveSnake(Snake, "evt_normal");
        end

        %% Draw Snake
        for i = 1: size(Snake.Body,1)
        ratio = (i -1 )/(size(Snake.Body,1)-1);
        color = (ratio * Snake_Tail_Color) + ((1- ratio) * Snake_Head_Color);
        set(snake_rectangle(i), ...
            'Position',[Snake.Body(i,1) - 0.5 Snake.Body(i,2) - 0.5 1 1], ...
            'FaceColor', color)
        end

        %% Draw apple
        set(apple_rec,'Position',[Snake.Apple-0.5 1 1]);

        pause(1/FPS);
    end

    fprintf("%s, but at least you get %d points\n", EndReason, Scores);

    %callback function
    function onKeyPress(~, evt)
        key = upper(evt.Key);

        switch key
            case 'W'
                newDir = [0 1];
            case 'A'
                newDir = [-1 0];
            case 'S'
                newDir = [0 -1];
            case 'D'
                newDir = [1 0];
            otherwise
                return;
        end

        if ~isequal(newDir, -Snake.Dir)
            Snake.NextDir = newDir;
        end
    end
end


    

