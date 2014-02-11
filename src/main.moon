io.stdout\setvbuf'no'

export mainWindow, menu, game -- must be global to be shared between love functions

export wScr, hScr
wScr, hScr = love.window.getWidth, love.window.getHeight

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
    game = nil
    mainWindow = menu

love.draw = ->
    mainWindow\draw!

    if DEBUG
        debagel\draw!

love.update = (dt) ->
    if mainWindow == menu and menu.goToGame
        menu.goToGame = false
        game = menu.game
        mainWindow = game
    elseif mainWindow == game and game.goToMenu
        game.goToMenu = false
        mainWindow = menu
    mainWindow\update dt

love.keyreleased = (k) ->
    mainWindow\keyreleased k

love.mousereleased = (x, y, button) ->
    mainWindow\mousereleased x, y, button
