require "grid"
require "gridview"
require "level"
require "state"

export ^


class Game extends State
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
            when "space"
                grid = @level.grid
                if grid.running
                    grid\stop_simulation!
                else
                    grid\start_simulation!
            when "escape"
                statestack\pop!

    mousereleased: (x, y, button) =>
        switch button
            when 1
                grid = @level.grid
                if not grid.running
                    i, j = @view\translateCoord x, y, true
                    grid\toggleLife i, j

    wheelmoved: (x, y) =>
        if y > 0
            @view\setScale("up")
        elseif y < 0
            @view\setScale("down")
