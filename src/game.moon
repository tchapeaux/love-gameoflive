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

    resume_simulation: =>
        @grid.running = true

    stop_simulation: =>
        @grid.running = false

    keyreleased: (key) =>
        switch key
            when " "
                if @grid.running
                    @stop_simulation!
                else
                    @resume_simulation!


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
