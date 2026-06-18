% Main game entry function for 2-player snake game
% Fully fixed: scope error / window not show / text overlap / syntax quote / score bug / refresh bug
function CreateAGame()
%% ====================== BASIC GAME INIT ======================
% Call playground init & bind keyboard callback
[ax, fig] = InitPlayground(@onKeyPress);
FPS = 8;
hold(ax, 'on');

% Pre-allocate snake graphic objects
snake_rectangle = gobjects(400, 1);
snake2_rectangle = gobjects(400, 1);

% ---------------------- PLAYER 1 (WASD) INIT DATA ----------------------
Snake.Body = [2 20;1 20];
Snake.Dir = [1 0];
Snake.NextDir = [1 0];
Snake.Apple = [5 9];
Snake_Head_Color = [0 1 1];
Snake_Tail_Color = [0 0.3 0.4];

% ---------------------- PLAYER 2 (IJKL) INIT DATA ----------------------
Snake2.Body = [18 20; 19 20];
Snake2.Dir = [-1 0];
Snake2.NextDir = [-1 0];
Snake2_Head_Color = [1 0.5 0];
Snake2_Tail_Color = [0.4 0.1 0];

% Score variables
Scores = 0;
Scores2 = 0;

% Spawn first valid apple (avoid snake body)
Snake = AppleTree(Snake, Snake2);

% Game state flags
GamePaused = false;
RestartFlag = false;

%% ====================== DRAW INITIAL P1 SNAKE ======================
snake_rectangle(1) = rectangle( ...
    'FaceColor', Snake_Head_Color, ...
    'Position', [Snake.Body(1,1)-0.5 Snake.Body(1,2)-0.5 1 1], ...
    'EdgeColor','none', ...
    'Parent',ax);

snake_rectangle(2) = rectangle( ...
    'FaceColor', Snake_Tail_Color, ...
    'Position', [Snake.Body(2,1)-0.5 Snake.Body(2,2)-0.5 1 1], ...
    'EdgeColor','none', ...
    'Parent',ax);

%% ====================== DRAW INITIAL P2 SNAKE ======================
snake2_rectangle(1) = rectangle(...
    'FaceColor', Snake2_Head_Color, ...
    'Position', [Snake2.Body(1,1)-0.5 Snake2.Body(1,2)-0.5 1 1], ...
    'EdgeColor','none', ...
    'Parent',ax);

snake2_rectangle(2) = rectangle(...
    'FaceColor', Snake2_Tail_Color, ...
    'Position', [Snake2.Body(2,1)-0.5 Snake2.Body(2,2)-0.5 1 1], ...
    'EdgeColor','none', ...
    'Parent',ax);

%% ====================== DRAW APPLE & SIDEBAR UI (FULL WHITE AREA, NO BLACK OVERLAP) ======================
apple_rec = rectangle( ...
    'FaceColor', 'r', ...
    'Position', [Snake.Apple(1)-0.5, Snake.Apple(2)-0.5, 1, 1],...
    'Parent',ax);

% Sidebar text placed at x=-6.5 (fully inside white sidebar)
Score_text = text(ax, -6.5, 20, {
    'P1 Score: 0'
    'P2 Score: 0'
}, 'Color', 'k', 'FontSize', 14);

Game_text = text(ax, -6.5, 15.2, {
    'P1 Controls'
    'W Up'
    'S Down'
    'A Left'
    'D Right'
    ''
    'P2 Controls'
    'I Up'
    'K Down'
    'J Left'
    'L Right'
}, 'Color', 'k', 'FontSize', 13);

pause_text = text(ax, -6.5, 11.5, {
    'Pause: P'
    'Restart: R'
}, 'Color','k','FontSize',12);

%% ====================== MAIN GAME LOOP ======================
while isvalid(fig)
    % Pause logic
    if GamePaused
        pause(0.1);
        continue;
    end

    % Restart logic
    if RestartFlag
        close(fig);
        drawnow;
        CreateAGame();
        return;
    end

    EndReason = "Unexpected Quit";

    % Update direction buffer
    Snake.Dir = Snake.NextDir;
    Snake2.Dir = Snake2.NextDir;

    % Collision check (wall + self + enemy snake)
    hit1 = HitCheck(Snake) || ismember(Snake.Body(1,:), Snake2.Body, 'rows');
    hit2 = HitCheck(Snake2) || ismember(Snake2.Body(1,:), Snake.Body, 'rows');

    if hit1 || hit2
        EndReason = "You fail";
        break;
    end

    %% Apple eat logic
    if EatCheck(Snake, Snake.Apple)
        Snake = MoveSnake(Snake, "evt_apple");
        snake_rectangle(size(Snake.Body,1)) = rectangle( ...
            'FaceColor', [1 1 1], ...
            'Position', [Snake.Body(size(Snake.Body,1),1)-0.5 Snake.Body(size(Snake.Body,1),2)-0.5 1 1], ...
            'Parent',ax);

        Snake = AppleTree(Snake, Snake2);

        % Win condition (no duplicate score)
        if Snake.Apple == [0 0]
            EndReason = "You win";
            set(apple_rec, 'FaceColor',[1 1 1]);
            break;
        end
        Scores = Scores + 1;

    elseif EatCheck(Snake2, Snake.Apple)
        Snake2 = MoveSnake(Snake2, "evt_apple");
        snake2_rectangle(size(Snake2.Body,1)) = rectangle( ...
            'FaceColor', [1 1 1], ...
            'Position', [Snake2.Body(size(Snake2.Body,1),1)-0.5 Snake2.Body(size(Snake2.Body,1),2)-0.5 1 1], ...
            'Parent',ax);

        Snake = AppleTree(Snake, Snake2);

        if Snake.Apple == [0 0]
            EndReason = "You win";
            set(apple_rec, 'FaceColor',[1 1 1]);
            break;
        end
        Scores2 = Scores2 + 1;

    else
        Snake = MoveSnake(Snake, "evt_normal");
        Snake2 = MoveSnake(Snake2, "evt_normal");
    end

    %% Redraw P1 gradient snake
    for i = 1:size(Snake.Body,1)
        ratio = (i-1)/(size(Snake.Body,1)-1);
        color = ratio*Snake_Tail_Color + (1-ratio)*Snake_Head_Color;
        set(snake_rectangle(i),...
            'Position',[Snake.Body(i,1)-0.5, Snake.Body(i,2)-0.5,1,1],...
            'FaceColor',color);
    end

    %% Redraw P2 gradient snake
    for i = 1:size(Snake2.Body,1)
        ratio = (i-1)/(size(Snake2.Body,1)-1);
        color = ratio*Snake2_Tail_Color + (1-ratio)*Snake2_Head_Color;
        set(snake2_rectangle(i),...
            'Position',[Snake2.Body(i,1)-0.5, Snake2.Body(i,2)-0.5,1,1],...
            'FaceColor',color);
    end

    %% Update UI
    set(apple_rec,'Position',[Snake.Apple(1)-0.5, Snake.Apple(2)-0.5,1,1]);
    set(Score_text,'String',{
        sprintf('P1 Score: %d',Scores)
        sprintf('P2 Score: %d',Scores2)
    });

    drawnow;
    pause(1/FPS);
end

%% Game Over Output
fprintf("%s, P1: %d points, P2: %d points\n", EndReason, Scores, Scores2);

%% ====================== KEYBOARD CALLBACK (MOVED TO BOTTOM = FIX SCOPE ERROR) ======================
function onKeyPress(~, evt)
    key = upper(evt.Key);

    % P1 WASD
    switch key
        case 'W'
            newDir = [0 1];
            if ~isequal(newDir, -Snake.Dir)
                Snake.NextDir = newDir;
            end
            return;
        case 'A'
            newDir = [-1 0];
            if ~isequal(newDir, -Snake.Dir)
                Snake.NextDir = newDir;
            end
            return;
        case 'S'
            newDir = [0 -1];
            if ~isequal(newDir, -Snake.Dir)
                Snake.NextDir = newDir;
            end
            return;
        case 'D'
            newDir = [1 0];
            if ~isequal(newDir, -Snake.Dir)
                Snake.NextDir = newDir;
            end
            return;
    end

    % P2 IJKL
    switch key
        case 'I'
            newDir2 = [0 1];
            if ~isequal(newDir2, -Snake2.Dir)
                Snake2.NextDir = newDir2;
            end
        case 'K'
            newDir2 = [0 -1];
            if ~isequal(newDir2, -Snake2.Dir)
                Snake2.NextDir = newDir2;
            end
        case 'J'
            newDir2 = [-1 0];
            if ~isequal(newDir2, -Snake2.Dir)
                Snake2.NextDir = newDir2;
            end
        case 'L'
            newDir2 = [1 0];
            if ~isequal(newDir2, -Snake2.Dir)
                Snake2.NextDir = newDir2;
            end
        case 'P'
            GamePaused = ~GamePaused;
        case 'R'
            RestartFlag = true;
    end
end

end