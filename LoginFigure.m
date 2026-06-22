% Pop up login window to input player username
function LoginFigure()
    % Load leaderboard data file Top.mat, read variable Top
    load('Top.mat', 'Top');
    % Clear default name of the 4th leaderboard entry
    Top(4).Name = "";

    % Create login figure window
    fig = figure( ...
        'Name', 'Login', ...
        'NumberTitle', 'off', ...
        'MenuBar', 'none', ...
        'ToolBar', 'none', ...
        'Position', [500 400 300 180]);

    % Static text prompt
    uicontrol(fig, ...
        'Style', 'text', ...
        'String', 'Enter your username:', ...
        'Position', [50 120 200 25], ...
        'FontSize', 12);

    % Edit text box for user to type name
    % [X Y Width Height]
    nameBox = uicontrol(fig, ...
        'Style', 'edit', ...
        'Position', [50 85 200 30], ...
        'FontSize', 12);

    % Login button with click callback
    uicontrol(fig, ...
        'Style', 'pushbutton', ...
        'String', 'Login', ...
        'Position', [100 35 100 35], ...
        'FontSize', 12, ...
        'Callback', @loginCallback);

    % Pause script execution until figure is closed
    uiwait(fig);

    % Callback triggered when Login button is clicked
    %callbackFunction(src, evt): src is the button name (here no name is made), evt is extra information record

    function loginCallback(~, ~)
        % Get text input from edit box and store to leaderboard
        Top(4).Name = get(nameBox, 'String');

        % Pop error window if username is blank
        if isempty(Top(4).Name)
            errordlg('Username cannot be empty.');
            return;
        end

        % Close login window if it still exists
        if isvalid(fig)
            close(fig);
        end
    end

    % Save updated leaderboard back to Top.mat
    save('Top.mat', 'Top');
end
