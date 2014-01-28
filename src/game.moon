require "grid"
require "view"

export ^


class Game
    new: =>
        @grid = makeDefaultGrid!
        @view = View @grid

    draw: =>
        @view\draw!
        love.graphics.print love.timer.getFPS!, 10, 10

    update: (dt) =>
        @grid\update dt

    resume_simulation: =>
        @grid.running = true

    stop_simulation: =>
        @grid.running = false

    keyreleased: (key) =>
        if key == " "
            if @grid.running
                @stop_simulation!
            else
                @resume_simulation!

    mousereleased: (x, y, button) =>
        if button == "l"
            i, j = @view\translateCoord(x, y)
            @grid\toggleLife(i, j)
