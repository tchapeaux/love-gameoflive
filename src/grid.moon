export ^

class Grid
    new: (@size) =>
        @cells = {}
        @running = false
        @stepTime = 0.5
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

    is_alive: (i, j) =>
        @checkCoordinates i, j
        @cells[i] and @cells[i][j]

    is_dead: (i, j) =>
        @checkCoordinates i, j
        (not @cells[i]) or (not @cells[i][j])

    toggleLife: (i, j) =>
        @checkCoordinates i, j
        if @is_alive i, j
            @set_dead i, j
        elseif @is_dead i, j
            @set_alive i, j
        else
            error("Invalid state for cell #{i} #{j}")

    set_dead: (i, j) =>
        @checkCoordinates i, j
        if @cells[i]
            @cells[i][j] = nil
        -- TODO: remove @cells[i] if [i][j] was the last cell in i

    set_alive: (i, j) =>
        @checkCoordinates i, j
        if not @cells[i]
            @cells[i] = {}
        @cells[i][j] = true

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
        for {coordX, coordY} in *@neighbors i, j
            @checkCoordinates coordX, coordY
            if @is_alive coordX, coordY then cnt += 1
        cnt

    surviveNextStep: (i, j) =>
        aliveCnt = @aliveNeighborCnt i, j
        aliveCnt == 3 or (aliveCnt == 2 and @is_alive i, j)

    actualize: =>
    -- advance one step in the simulations, updating @cells
        copyGrid = Grid @size
        -- for each alive cell
        for i, _ in pairs @cells
            for j, _ in pairs @cells[i]
                -- check if it should survive
                if @surviveNextStep i, j
                    copyGrid\set_alive i, j
                -- check if one of its dead neighbors should be awakened
                for {i2, j2} in *@neighbors(i, j)
                    if @is_dead i2, j2
                        if copyGrid\is_dead(i2, j2) and @surviveNextStep(i2, j2)
                            copyGrid\set_alive i2, j2


        @cells = copyGrid.cells


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
    g = Grid 100
    g\placePattern patterns.block, 2, 2
    g\placePattern patterns.boat, 5, 5
    g\placePattern patterns.pulsar, 10, 2
    g\placePattern patterns.lightweight_spaceship, 30, 5
    g\placePattern patterns.gosperglidergun, 2, 15

    return g
