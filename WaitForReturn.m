% Wait for user to press Enter or ESC after game ends
% Input: fig - game window handle
% Output: playAgain = true if Enter pressed (restart game), false if ESC pressed
function playAgain = WaitForReturn(fig)
    % Default: do not restart game
    playAgain = false;

    % Bind keyboard listening function to window
    set(fig, 'KeyPressFcn', @onKeyPress);
    % Pause program until uiresume is called
    uiwait(fig);

    % Nested keyboard callback
    function onKeyPress(~, evt)
        % Press Enter key to restart game
        if strcmp(evt.Key, 'return')
            playAgain = true;
            uiresume(fig);
        % Press ESC key to exit without restart
        elseif strcmp(evt.Key, 'escape')
            playAgain = false;
            uiresume(fig);
        end
    end
end
