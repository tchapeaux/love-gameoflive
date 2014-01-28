export ^

class Grid
    new: (@size) =>
        @cells = [ [0 for i = 1, @size] for j = 1, @size]
        @running = false
        @stepTime = 0.1
        @stepPerSecond = 1 / @stepTime
        @nextStepTimer = @stepTime

    update: (dt) =>
        if @running
            @nextStepTimer -= dt
        if @nextStepTimer <= 0
            @actualize!
            @nextStepTimer = @stepTime

    isInGrid: (i, j) =>
        i >= 1 and i <= @size and j >= 1 and j <= @size

    checkCoordinates: (i, j) =>
        assert i ~= nil and math.floor(i) == i
        assert j ~= nil and math.floor(j) == j
        assert @isInGrid(i, j)

    isAlive: (i, j) =>
        @checkCoordinates i, j
        @cells[i][j] == 1

    isDead: (i, j) =>
        @checkCoordinates i, j
        @cells[i][j] == 0

    toggleLife: (i, j) =>
        @checkCoordinates i, j
        @cells[i][j] = 1 - @cells[i][j]

    set_dead: (i, j) =>
        @checkCoordinates i, j
        @cells[i][j] = 0

    set_alive: (i, j) =>
        @checkCoordinates i, j
        @cells[i][j] = 1

    up: (j) =>
        @checkCoordinates 1, j
        if j > 1 then j - 1  else @size

    down: (j) =>
        @checkCoordinates 1, j
        if j < @size then j + 1 else 1

    left: (i) =>
        @checkCoordinates i, 1
        if i > 1 then i - 1 else @size

    right: (i) =>
        @checkCoordinates i, 1
        if i < @size then i + 1 else 1

    neighbors: (i, j) =>
        u, d, r, l = @up(j), @down(j), @right(i), @left(i)
        {
            {r, j},
            {r, d},
            {i, d},
            {l, d},
            {l, j},
            {l, u},
            {i, u},
            {r, u}
        }

    aliveNeighborCnt: (i, j) =>
        cnt = 0
        neighbors = @neighbors i, j
        for {coordX, coordY} in *neighbors
            @checkCoordinates coordX, coordY
            if @isAlive coordX, coordY then cnt += 1
        cnt

    actualize: =>
    -- advance one step in the simulations, updating @cells
        newGrid = Grid @size
        for i=1,@size
            for j=1,@size
                aliveCnt = @aliveNeighborCnt i, j
                -- if @isAlive i, j then print "#{i} #{j} has #{aliveCnt} neigh"
                if aliveCnt == 3 or (aliveCnt == 2 and @isAlive i, j)
                    newGrid\set_alive i, j
        @cells = newGrid.cells

    placePattern: (pattern, i, j) =>
        @checkCoordinates i, j
        p_grid = pattern.pattern_grid
        cur_i, cur_j = i, j
        for row in *p_grid
            for lifeStatus in *row
                -- print "#{cur_i}, #{cur_j}: #{lifeStatus}"
                if lifeStatus == 1
                    @set_alive cur_i, cur_j
                elseif lifeStatus == 0
                    @set_dead cur_i, cur_j
                cur_i = @right cur_i
            cur_j = @down cur_j
            cur_i = i



export makeDefaultGrid = ->
    require("patterns")
    -- g = Grid 50
    -- g\placePattern patterns.block, 2, 2
    -- g\placePattern patterns.boat, 5, 5
    -- g\placePattern patterns.pulsar, 10, 2
    -- g\placePattern patterns.lightweight_spaceship, 30, 5
    -- g\placePattern patterns.gosperglidergun, 2, 15

    g = Grid 20
    -- g\placePattern patterns.glider , 1, 1
    g\placePattern patterns.glider , 18, 18
    g\placePattern patterns.glider , 1, 5
    g\placePattern patterns.glider , 15, 2

    return g
