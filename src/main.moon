io.stdout\setvbuf'no'

export game

love.load = ->
    require("game")
    game = Game!

love.draw = ->
    game\draw!

love.update = (dt) ->
    game\update dt

love.keypressed = (k) ->
    game\keyreleased k
    if k == 'escape' then love.event.quit!

love.mousereleased = (x, y, button) ->
    game\mousereleased x, y, button
