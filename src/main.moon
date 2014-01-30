io.stdout\setvbuf'no'

export game, menu -- must be global to be shared between love functions

love.load = ->
    require("debagel")
    require("game")
    require("menu")
    debugFont = love.graphics.newFont("res/font/Inconsolata.otf", 15)
    export debagel = Debagel debugFont
    game = Game!
    menu = Menu!

love.draw = ->
    -- game\draw!
    menu\draw!
    debagel\draw!

love.update = (dt) ->
    -- game\update dt
    menu\update dt

love.keypressed = (k) ->
    if k == 'escape' then love.event.quit!
    -- game\keyreleased k

love.mousereleased = (x, y, button) ->
    -- game\mousereleased x, y, button
