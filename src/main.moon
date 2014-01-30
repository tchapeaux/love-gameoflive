io.stdout\setvbuf'no'

export game

love.load = ->
    require("game")
    require("debagel")
    game = Game!

love.draw = ->
    game\draw!

love.update = (dt) ->
    game\update dt

love.keypressed = (k) ->
    if k == 'escape' then love.event.quit!
    game\keyreleased k

love.mousereleased = (x, y, button) ->
    game\mousereleased x, y, button
