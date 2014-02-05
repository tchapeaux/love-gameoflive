require "grid"
require "view"
require "level"

export ^


class Game
    new: =>
        @level = makeDefaultLevel!
        @view = View @level.grid, love.graphics.getWidth!, love.graphics.getHeight!

    draw: =>
        @view\draw!
        @level\draw!

    update: (dt) =>
        @level\update dt
        @view\update dt
        debagel\monitor("fps", love.timer.getFPS!)
        debagel\update dt

    keyreleased: (key) =>
        switch key
            when " "
                grid = @level.grid
                if grid.running
                    grid\stop_simulation!
                else
                    grid\start_simulation!

    mousereleased: (x, y, button) =>
        switch button
            when "l"
                grid = @level.grid
                if not grid.running
                    i, j = @view\translateCoord x, y, true
                    grid\toggleLife i, j
            when "wu"
                @view\setScale("up")
            when "wd"
                @view\setScale("down")
