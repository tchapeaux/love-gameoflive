require "grid"
require "view"

export ^

makeMenuGrid = ->
    require("patterns")
    g = Grid 20
    g\set_stepTime 0.5
    g\placePattern patterns.noahsark, 20, 15
    g\start_simulation!
    return g

testBoundingBox = (bb, x, y) ->
    -- return true if x,y is in boundingBox
    xB, yB, wB, hB = bb[1], bb[2], bb[3], bb[4]
    xTest = xB <= x and x <= xB + wB
    yTest = yB <= y and y <= yB + hB
    return xTest and yTest


class Menu
    new: =>
        @gameLaunch = false
        @w = love.graphics.getWidth!
        @h = love.graphics.getHeight!
        @grid = makeMenuGrid!
        @view = View @grid, @w, @h
        @view\setScale 2

        @fontBig = love.graphics.newFont "res/font/GreatVibes-Regular.otf", 80
        @fontMed = love.graphics.newFont "res/font/GreatVibes-Regular.otf", 60
        @fontSma = love.graphics.newFont "res/font/Inconsolata.otf", 20
        resources.bgm_menu\play!
        @colorUnselected = {0, 0, 0}
        @colorSelected = {10, 100, 10}
        @text = {}
        table.insert @text, "Start  Game"
        table.insert @text, "Level Selection"
        table.insert @text, "Sandbox Mode"
        table.insert @text, "Quit Game"
        @textBoundBox = {}
        for i=1,#@text
            table.insert @textBoundBox, {
                @w/4 - 150,
                @h/3 + (i-1) * 100 - 50,
                350, 100
            }
        @selected = 0

    update: (dt) =>
        @grid\update dt
        -- @view\update dt
        -- we do not update @view as it is not taking input
        mX, mY = love.mouse.getX!, love.mouse.getY!
        debagel\monitor "mouse", "#{mX} #{mY}"
        @selected = 0
        for i=1,#@text
            if testBoundingBox(@textBoundBox[i], mX, mY)
                @selected = i
        debagel\monitor "selected", @selected

    draw: =>
        @view\draw!
        love.graphics.setFont(@fontBig)
        love.graphics.printf "Game of Löve", @w / 2, 10, @w / 2 - 10, "right"

        love.graphics.setFont(@fontMed)
        for i=1,#@text
            bb = @textBoundBox[i]
            x, y, w, h = bb[1], bb[2], bb[3], bb[4]
            love.graphics.setColor if i == @selected then @colorSelected else @colorUnselected
            love.graphics.printf @text[i], x, y, w, "center"

        love.graphics.setColor {0, 0, 0}
        love.graphics.setFont @fontSma
        love.graphics.printf "A game by Altom", 3 * @w/4, @h - 30, @w/4, "right"

    mousereleased: (x, y) =>
        @itemSelected @selected

    itemSelected: (selected) =>
        command = @text[selected]
        switch command
            when "Start Game"
                return -- TODO
            when "Level Selection"
                return -- TODO
            when "Sandbox Mode"
                resources.bgm_menu\stop!
                resources.bgm_sandbox\play!
                @gameLaunch = true
            when "Quit Game"
                love.event.quit!
