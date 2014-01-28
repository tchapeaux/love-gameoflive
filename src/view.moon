export ^

class View
    new: (@grid) =>
        @cellSize = 20
        @offsetX = 0
        @offsetY = 0
        @aliveColor = {65, 105, 225}
        @deadColor = {255, 255, 255}
        @pauseColor = {100, 100, 100}
        @gridColor = {0, 0, 0}
        @gridWidth = 2

    draw: =>
        @drawBackground!
        -- TODO: take offsets into account and only draw relevant part
        for i = 1, @grid.size
            for j = 1, @grid.size
                @drawCell i, j
        @drawLines!

    drawBackground: =>
        w = love.graphics.getWidth!
        h = love.graphics.getHeight!
        love.graphics.setColor if @grid.running then @deadColor else @pauseColor
        love.graphics.rectangle "fill", 0, 0, w, h

    drawLines: =>
        love.graphics.setColor @gridColor
        love.graphics.setLineWidth @gridWidth
        oX = @offsetX / @cellSize
        oY = @offsetY / @cellSize
        vertCnt = math.ceil love.graphics.getWidth! / @cellSize
        for i=1, vertCnt
            lineX = (i - 1) * @cellSize + oX
            love.graphics.line lineX, 0, lineX, love.graphics.getHeight!
        horizCnt = math.ceil love.graphics.getHeight! / @cellSize
        for i=1, horizCnt
            lineY = (i - 1) * @cellSize + oY
            love.graphics.line 0, lineY, love.graphics.getWidth!, lineY

    drawCell: (i, j) =>
        @grid\checkCoordinates i, j
        if @grid.cells[i][j] == 1
            love.graphics.setColor(@aliveColor)
            love.graphics.rectangle "fill",
                (i - 1) * @cellSize, (j - 1) * @cellSize,
                @cellSize, @cellSize


    translateCoord: (x, y) =>
        -- translate x,y coordinates in the window into i, j grid coordinate
        i = 1 + math.floor((@offsetX + x) / @cellSize)
        j = 1 + math.floor((@offsetY + y) / @cellSize)
        return i, j
