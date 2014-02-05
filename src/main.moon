io.stdout\setvbuf'no'

export game, menu -- must be global to be shared between love functions

DEBUG = true

love.load = ->
    if DEBUG
        love.audio.setVolume 0
    require("debagel")
    require("game")
    require("menu")
    require("resources")
    debugFont = love.graphics.newFont("res/font/Inconsolata.otf", 15)
    export debagel = Debagel debugFont
    game = Game!
    menu = Menu!

love.draw = ->
    if menu.gameLaunch
        game\draw!
    else
        menu\draw!

    if DEBUG
        debagel\draw!

love.update = (dt) ->
    if menu.gameLaunch
        game\update dt
    else
        menu\update dt

love.keyreleased = (k) ->
    if k == 'escape' then love.event.quit!
    if menu.gameLaunch
        game\keyreleased k
    else
        menu\keyreleased k

love.mousereleased = (x, y, button) ->
    if menu.gameLaunch
        game\mousereleased x, y, button
    else
        menu\mousereleased x, y, button
