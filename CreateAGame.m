% Create full snake game loop
% Input: ax - axes handle for drawing; fig - game window figure handle
% Output: Scores - final score after game over/win
function Scores = CreateAGame(ax, fig)
    % Game frame rate
    FPS = 8;
    
    % Preallocate array to store graphic handles of snake body blocks (max 400 segments)
    snake_rectangle = gobjects(400, 1);
    % Initial snake body: 2 segments, first row = head, second = tail
    Snake.Body = [2 20;1 20];
    Snake.Dir = [1 0];         % Current moving direction
    Snake.NextDir = [1 0];     % Next direction updated by keyboard input
    Snake.Apple = [5 9];       % Initial apple coordinate
    Snake = AppleTree(Snake);  % Spawn valid apple
    Scores = 0;                % Initialize score
    % Bind keyboard press callback function to game window
    set(fig, 'KeyPressFcn', @onKeyPress);

    % Color setting: head cyan, tail dark blue
    Snake_Head_Color = [0 1 1];
    Snake_Tail_Color = [0 0.3 0.4];

    % Draw initial snake head rectangle
    snake_rectangle(1) = rectangle( ...
        "FaceColor", Snake_Head_Color, ...
        'Position', [Snake.Body(1,1)-0.5 Snake.Body(1,2)-0.5 1 1], ...
        'EdgeColor','none', ...
        "Parent",ax);
    % Draw initial snake tail rectangle
    snake_rectangle(2) = rectangle( ...
        "FaceColor", Snake_Tail_Color, ...
        'Position', [Snake.Body(2,1)-0.5 Snake.Body(2,2)-0.5 1 1], ...
        'EdgeColor','none', ...
        "Parent",ax);
    % Create apple rounded rectangle graphic
    apple_rec = rectangle( ...
        'FaceColor', 'r', ...
        'Curvature', [0.8 0.8], ... % Round apple corners
        'Position', [Snake.Apple(1)-0.5, Snake.Apple(2)-0.5, 1, 1]);
    % Create score text display on axes
    Score_text = text(ax, -6.5, 19.5, 'Score: 0', ...
        'Color', 'k', ...
        'FontSize', 14);
        
    % Main game loop: run if game window is still valid
    while isvalid(fig) && true
        % Update actual moving direction to buffered next direction
        Snake.Dir = Snake.NextDir;

        % Check wall/self collision, game over if true
        if HitCheck(Snake)
            break
        % Check if snake eats apple
        elseif EatCheck(Snake)
        
            % Move snake with grow body logic
            Snake = MoveSnake(Snake, "evt_apple");
            % Create new rectangle for newly added tail segment
            %size(A, dim) if dim=1, count rows; if dim=2, count column

            snake_rectangle(size(Snake.Body,1)) = rectangle( ...
                "FaceColor", [1 1 1], ...
                'Position', [Snake.Body(size(Snake.Body,1),1)-0.5 Snake.Body(size(Snake.Body,1),2)-0.5 1 1], ...
                "Parent",ax);
            % Generate new apple position
            Snake = AppleTree(Snake);
            % Apple returns [0,0] means full map filled, player wins
            if Snake.Apple == [0 0]
                Scores = Scores + 1;
                set(apple_rec, 'FaceColor',[1 1 1]); % Hide apple
                break
            end
            Scores = Scores + 1;
            % Refresh score text on screen
            set(Score_text, 'String', sprintf('Score: %d', Scores));
        else
            % Normal move, snake length unchanged
            Snake = MoveSnake(Snake, "evt_normal");
        end

        %% Refresh all snake block graphics
        for i = 1: size(Snake.Body,1)
            % Linear gradient color from head to tail
            ratio = (i -1 )/(size(Snake.Body,1)-1);
            color = (ratio * Snake_Tail_Color) + ((1- ratio) * Snake_Head_Color);
            % Update square position and color for each body segment
            set(snake_rectangle(i), ...
                'Position',[Snake.Body(i,1) - 0.5 Snake.Body(i,2) - 0.5 1 1], ...
                'FaceColor', color)
        end

        %% Refresh apple graphic position
        set(apple_rec,'Position',[Snake.Apple(1)-0.5 Snake.Apple(2)-0.5 1 1]);

        % Control game speed by frame pause time
        pause(1/FPS);
    end

    % Keyboard press callback nested function
    % evt.Key : Extracts the name of the pressed key from the event object
    % upper(...) : Converts the letter to uppercase

    function onKeyPress(~, evt)
        key = upper(evt.Key);
   
        % Map WASD to direction vectors
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
                return; % Ignore other keys
        end
        % Prevent snake reverse direction instantly (can't turn back)
        if ~isequal(newDir, -Snake.Dir)
            Snake.NextDir = newDir;
        end
    end
end
