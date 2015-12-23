io.stdout\setvbuf'no'

require "resources"
require "debagel"
require "statestack"
require "menu"

export statestack = StateStack!
export debagel = Debagel love.graphics.newFont("res/font/Inconsolata.otf", 15)
export wScr, hScr
wScr, hScr = love.graphics.getWidth, love.graphics.getHeight
export DEBUG = false

love.load = ->
    if DEBUG
        love.audio.setVolume 0
    statestack\push Menu!

love.draw = ->
    curState = statestack\peek!
    curState\draw!
    if DEBUG
        debagel\draw!

love.update = (dt) ->
    curState = statestack\peek!
    curState\update dt

love.keyreleased = (k) ->
    curState = statestack\peek!
    curState\keyreleased k

love.mousepressed = (x, y, button) ->
    curState = statestack\peek!
    curState\mousepressed x, y, button

love.mousereleased = (x, y, button) ->
    curState = statestack\peek!
    curState\mousereleased x, y, button

love.wheelmoved = (x, y) ->
    curState = statestack\peek!
    curState\wheelmoved x, y
