io.stdout\setvbuf'no'

export game, menu -- must be global to be shared between love functions

DEBUG = true

love.load = ->
    if DEBUG
        love.audio.setVolume 0
    require("debagel")
    require("menu")
    require("resources")
    debugFont = love.graphics.newFont("res/font/Inconsolata.otf", 15)
    export debagel = Debagel debugFont
    menu = Menu!
    mainWindow = menu

love.draw = ->
    mainWindow\draw!

    if DEBUG
        debagel\draw!

love.update = (dt) ->
    if mainWindow == menu and menu.game ~= nil
        mainWindow = menu.game
    mainWindow = menu

love.keyreleased = (k) ->
    if menu.gameLaunch
        game\keyreleased k
    else
        menu\keyreleased k

love.mousereleased = (x, y, button) ->
    if menu.gameLaunch
        game\mousereleased x, y, button
    else
        menu\mousereleased x, y, button
