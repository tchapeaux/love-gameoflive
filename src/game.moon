require "grid"
require "gridview"
require "level"

export ^


class Game
    new: (@level) =>
        @view = GridView @level.grid, wScr!, hScr!
        @goToMenu = false

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
            when "escape"
                @goToMenu = true

    mousereleased: (x, y, button) =>
        switch button
            when "l"
                grid = @level.grid
                if not grid.running
                    i, j = @view\translateCoord x, y, true
                    grid\toggleLife i, j

    mousepressed: (x, y, button) =>
        switch button
            when "wu"
                @view\setScale("up")
            when "wd"
                @view\setScale("down")
