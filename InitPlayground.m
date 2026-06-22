% Initialize game window and coordinate axes
% Input: onKeyPress - keyboard callback function handle
% Output: ax - drawing axes handle; fig - figure window handle
function [ax, fig] = InitPlayground(onKeyPress)
    % Game grid size 20x20
    GRID_W = 20;
    GRID_H = 20;

    % Create main game window
    fig = figure('Name', 'Snake', 'NumberTitle', 'off', ...
        'MenuBar', 'none', 'ToolBar', 'none', ...
        'KeyPressFcn', onKeyPress);

    % Create drawing axes for snake and apple
    ax = axes('Parent', fig, ...
        'XLim', [-7 GRID_W + 0.5], 'YLim', [0.5 GRID_H + 0.5], ... % X has extra left space for score text
        'XTick', [], 'YTick', [], ... % Hide axis ticks
        'Color', [0.05 0.05 0.05], ... % Dark background
        'DataAspectRatio', [1 1 1]); % Force square grid blocks

    hold(ax, 'on'); % Keep all drawn objects on axes
    
    % Draw white sidebar panel for score display
    rectangle(ax, ...
        'Position', [-7, 0.5, 7.5, 20], ...
        'FaceColor', 'white', ...
        'EdgeColor', 'none');
end
