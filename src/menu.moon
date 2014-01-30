require "grid"
require "view"

export ^

makeMenuGrid = ->
    require("patterns")
    g = Grid 100
    g\set_stepTime 0.5
    g\placePattern patterns.noahsark, 20, 15
    g\start_simulation!
    return g

testBoundingBox = (bb, x, y) ->
    -- return true if x,y is in boundingBox
    xB, yB, wB, hB = bb[1], bb[2], bb[3], bb[4]
    xTest = xB <= x and x <= xB + wB
    yTest = yB <= y and y <= yB + hB
    return x_Test and y_Test


class Menu
    new: =>
        @w = love.graphics.getWidth!
        @h = love.graphics.getHeight!
        @grid = makeMenuGrid!
        @view = View @grid, love.graphics.getWidth!, love.graphics.getHeight!

        @font = love.graphics.newFont "res/font/GreatVibes-Regular.otf", 60
        @colorUnselected = {0, 0, 0}
        @colorSelected = {255, 255, 255}
        @text = {}
        @text[1] = "Start  Game"
        @text[2] = "Level Selection"
        @text[3] = "Quit Game"
        @textBoundBox = {}
        for i=1,#@text
            table.insert @textBoundBox, {
                @w/4 - 150,
                @h/3 + (i-1) * 100 - 100,
                300, 100
            }
        @selected = 0

    update: (dt) =>
        @grid\update dt
        -- @view\update dt
        -- we do not update @view as it is not taking input
        mX, mY = love.mouse.getX!, love.mouse.getY!
        for i=1,#@text
            if testBoundingBox(@textBoundBox[i], mX, mY)
                @selected = i
        debagel\monitor "selected", @selected

    draw: =>
        @view\draw!
        love.graphics.setFont(@font)

        for i=1,#@text
            bb = @textBoundBox[i]
            x, y, w, h = bb[1], bb[2], bb[3], bb[4]
            love.graphics.setColor if i == @selected then @colorSelected else @colorUnselected
            love.graphics.printf @text[i], x, y, w, "center"
            love.graphics.setColor {255,0,0}
            love.graphics.rectangle "line", x, y, w, h
