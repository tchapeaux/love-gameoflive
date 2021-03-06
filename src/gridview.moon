export ^

helper = require("helper")

class GridView
    new: (@grid, @w, @h) =>
        @cellBaseSize = 20
        @offsetX = 0
        @offsetY = 0
        @offset_speed = 100
        @scale = 1  -- final cell size will be @cellBaseSize * @scale pixels
        @scaleMax = 10
        @scaleMin = 0.5
        @run_aliveColor = {178, 34, 34} -- aka 'firebrick'
        @run_deadColor = {255, 215, 0} -- aka 'gold 1'
        @run_gridColor = {218, 165, 32} -- aka 'goldenrod'
        @pause_aliveColor = {139, 26, 26} -- aka 'firebrick 4'
        @pause_deadColor = {70, 130, 80} -- aka 'steelblue'
        @pause_gridColor = {176,196,222} -- aka 'lightsteelblue'
        @gridWidth = 1

    cellSize: =>
        @cellBaseSize * @scale

    aliveColor: =>
        @run_aliveColor if @grid.running else @pause_aliveColor

    deadColor: =>
        @run_deadColor if @grid.running else @pause_deadColor

    gridColor: =>
        @run_gridColor if @grid.running else @pause_gridColor

    setScale: (str) =>
        switch str
            when "up"
                @scale += 0.1
            when "down"
                @scale -= 0.1
            else
                @scale = tonumber str
        @scale = math.min(@scale, @scaleMax)
        @scale = math.max(@scale, @scaleMin)

    update: (dt) =>
        if love.keyboard.isDown "right"
            @offsetX -= @offset_speed * dt
        if love.keyboard.isDown "left"
            @offsetX += @offset_speed * dt
        if love.keyboard.isDown "down"
            @offsetY -= @offset_speed * dt
        if love.keyboard.isDown "up"
            @offsetY += @offset_speed * dt
        @cleanOffsetValues!

    draw: =>
        @drawBackground!
        @drawCells!
        @drawLines!

    drawBackground: =>
        w = love.graphics.getWidth!
        h = love.graphics.getHeight!
        love.graphics.setColor @deadColor()
        love.graphics.rectangle "fill", 0, 0, w, h

    drawCells: =>
        love.graphics.push!
        love.graphics.translate @offsetX, @offsetY
        top_left_x, top_left_y = @translateCoord 0, 0
        numCol = @w / @cellSize! + 1
        numRow = @h / @cellSize! + 1

        for i = top_left_x, top_left_x + numCol
            for j = top_left_y, top_left_y + numRow
                cell_i = helper.modulo_lua(i, @grid.size)
                cell_j = helper.modulo_lua(j, @grid.size)
                cell_grid_offset_x = math.floor((i - 1) / @grid.size)
                cell_grid_offset_y = math.floor((j - 1) / @grid.size)
                @drawCell cell_i, cell_j, cell_grid_offset_x, cell_grid_offset_y
        @drawCell 2, 2, 0, 0
        love.graphics.pop!

    drawLines: =>
        love.graphics.setColor @gridColor()
        love.graphics.setLineWidth @gridWidth * @scale
        oX = @offsetX % @cellSize!
        oY = @offsetY % @cellSize!
        vertCnt = math.ceil wScr! / @cellSize!
        for i=1, vertCnt
            lineX = (i - 1) * @cellSize! + oX
            love.graphics.line lineX, 0, lineX, hScr!
        horizCnt = math.ceil hScr! / @cellSize!
        for i=1, horizCnt
            lineY = (i - 1) * @cellSize! + oY
            love.graphics.line 0, lineY, wScr!, lineY

    drawCell: (i, j, grid_offX = 0, grid_offY = 0) =>
        -- offset indicate that the cell is seen in 'another' iteration
        -- of the grid because of the infinite looping
        @grid\checkCoordinates i, j
        cell_x = (i - 1 + grid_offX * @grid.size) * @cellSize!
        cell_y = (j - 1 + grid_offY * @grid.size) * @cellSize!
        if @grid\is_alive i, j
            love.graphics.setColor @aliveColor()
            love.graphics.rectangle "fill",
                cell_x, cell_y,
                @cellSize!, @cellSize!
        love.graphics.setColor {0, 0, 0}

    cleanOffsetValues: =>
        @offsetX %= @grid.size * @cellSize!
        @offsetY %= @grid.size * @cellSize!

    translateCoord: (x, y, inGrid=false) =>
        -- translate x,y coordinates in the window into cell coordinates
        -- if inGrid : always returns a coordinate in the grid (using modulos)

        i = math.floor((x - @offsetX) / @cellSize!) + 1
        j = math.floor((y - @offsetY) / @cellSize!) + 1

        if inGrid
            i = helper.modulo_lua i, @grid.size
            j = helper.modulo_lua j, @grid.size
        return i, j
