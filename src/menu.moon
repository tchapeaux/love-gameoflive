require "grid"
require "view"
require "game"
require "level"
helper = require "helper"

export ^

makeMenuGrid = ->
    require("patterns")
    g = Grid 20
    g\set_stepTime 0.5
    g\placePattern patterns.noahsark, 20, 15
    g\start_simulation!
    return g

class BoundingBox
    new: (@x, @y, @w, @h) =>

    test: (x, y) =>
    -- return true if x,y is in boundingBox
        xTest = @x <= x and x <= @x + @w
        yTest = @y <= y and y <= @y + @h
        return xTest and yTest

class Menu
    new: =>
        @game = nil
        @goToGame = false
        @grid = makeMenuGrid!
        @view = View @grid, wScr!, hScr!
        @view\setScale 2

        @fontBig = love.graphics.newFont "res/font/GreatVibes-Regular.otf", 80
        @fontMed = love.graphics.newFont "res/font/GreatVibes-Regular.otf", 60
        @fontSma = love.graphics.newFont "res/font/Inconsolata.otf", 20
        resources.bgm_menu\play!
        @colorUnselected = {0, 0, 0}
        @colorSelected = {189, 252, 201} -- mint
        @text = {}
        -- table.insert @text, "Resume Game"
        -- see update
        table.insert @text, "Start Game"
        table.insert @text, "Level Selection"
        table.insert @text, "Sandbox Mode"
        table.insert @text, "Quit Game"
        @textBoundBox = {}
        for i=1,#@text
            table.insert @textBoundBox, BoundingBox wScr!/4 - 150,
                hScr!/3 + (i-1) * 100 - 50,
                350, 100
        @selected = 0

    update: (dt) =>
        @grid\update dt

        if @game ~= nil and @text[1] == "Start Game"
            @text[1] = "Resume Game"

        mX, mY = love.mouse.getX!, love.mouse.getY!
        debagel\monitor "mouse", "#{mX} #{mY}"
        for i=1,#@text
            if @textBoundBox[i]\test mX, mY
                if @selected ~= i
                    @selected = i
        debagel\monitor "selected", @selected

    draw: =>
        @view\draw!
        love.graphics.setFont @fontBig
        love.graphics.printf "Game of Löve",
            wScr! / 2, 10, wScr! / 2 - 10, "right"

        love.graphics.setFont(@fontMed)
        for i=1,#@text
            bb = @textBoundBox[i]
            x, y, w, h = bb.x, bb.y, bb.w, bb.h
            if i == @selected
                love.graphics.setColor {0, 0, 0, 100}
                love.graphics.rectangle("fill", x, y, w, h)
            love.graphics.setColor if i == @selected then @colorSelected else @colorUnselected
            love.graphics.printf @text[i], x, y + 5, w, "center"

        love.graphics.setColor {0, 0, 0}
        love.graphics.setFont @fontSma
        love.graphics.printf "A game by Altom",
            3 * wScr! / 4, hScr! - 30, wScr! / 4 - 10, "right"

    mousereleased: (x, y) =>
        @itemSelected @selected

    keyreleased: (key) =>
        switch key
            when "up"
                @selected = helper.modulo_lua @selected - 1, #@text
            when "down"
                @selected = helper.modulo_lua @selected + 1, #@text
            when "return"
                @itemSelected @selected
            when "escape"
                love.event.quit!

    itemSelected: (selected) =>
        command = @text[selected]
        switch command
            when "Start Game"
                return -- TODO
            when "Resume Game"
                @goToGame = true
            when "Level Selection"
                return -- TODO
            when "Sandbox Mode"
                resources.bgm_menu\stop!
                resources.bgm_sandbox\play!
                @game = Game makeSandboxLevel!
                @goToGame = true
            when "Quit Game"
                love.event.quit!
