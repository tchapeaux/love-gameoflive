require "grid"
require "view"

export ^


class Game
    new: =>
        @grid = makeDefaultGrid!
        @view = View @grid, love.graphics.getWidth!, love.graphics.getHeight!

    draw: =>
        @view\draw!
        debagel\draw!

    update: (dt) =>
        @grid\update dt
        @view\update dt
        debagel\monitor("fps", love.timer.getFPS!)
        debagel\update dt

    keyreleased: (key) =>
        switch key
            when " "
                if @grid.running
                    @grid\stop_simulation!
                else
                    @grid\start_simulation!


    mousereleased: (x, y, button) =>
        switch button
            when "l"
                if not @grid.running
                    i, j = @view\translateCoord x, y, true
                    @grid\toggleLife i, j
            when "wu"
                @view\setScale("up")
            when "wd"
                @view\setScale("down")
