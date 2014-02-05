require("grid")
require("view")
require("patterns")

export ^

class Objective
    new: (@pattern, @x, @y) =>

class Level
    new: (size, @objective) =>
        @grid = Grid size

    checkObjective: =>
        @grid\checkPattern @objective.pattern, @objective.x, @objective.y

    update: (dt) =>
        @grid\update dt

    draw: =>

export makeSandboxLevel = ->
    -- sandbox: impossible objective
    obj_pattern = Pattern "Garden of Even",
        Pattern.gridFromCellsFile "res/patterns/gardenofeven.cells"
    obj = Objective obj_pattern, 1, 1
    return Level 100, obj
