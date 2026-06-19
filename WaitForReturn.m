function playAgain = WaitForReturn(fig)
    playAgain = false;

    set(fig, 'KeyPressFcn', @onKeyPress);
    uiwait(fig);

        function onKeyPress(~, evt)
            if strcmp(evt.Key, 'return')
                playAgain = true;
                uiresume(fig);
            elseif strcmp(evt.Key, 'escape')
                playAgain = false;
                uiresume(fig);
            end
        end
end