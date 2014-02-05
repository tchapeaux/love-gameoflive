-- most patterns are from:
-- http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life#Examples_of_patterns1
-- http://www.conwaylife.com/wiki/Main_Page

export ^

class Pattern
    new: (@name, @pattern_grid) =>

    gridFromCellsFile: (filepath) ->
        -- filepath must be a text file respecting the following format:
        -- http://www.conwaylife.com/wiki/Plaintext
        patt = {}
        for line in love.filesystem.lines filepath
            if line\sub(1, 1) == "!"
                continue
            patt_line = {}
            -- .cells files may have different line lengths and even
            -- zero-length lines
            for charIndex = 1,line\len!
                char = line\sub(charIndex, charIndex)
                if char == '.'
                    table.insert patt_line, 0
                elseif char == 'O'
                    table.insert patt_line, 1
                else
                    error "Invalid character #{char} in line #{line}"
            table.insert patt, patt_line
        return patt

export patterns = {
    -- still lifes
    block: Pattern "Block", {
        {1, 1}
        {1, 1}
    }

    beehive: Pattern "Beehive", {
        {0, 1, 1, 0}
        {1, 0, 0, 1}
        {0, 1, 1, 0}
    }

    loaf: Pattern "Loaf", {
        {0, 1, 1, 0}
        {1, 0, 0, 1}
        {0, 1, 0, 1}
        {0, 0, 1, 0}
    }

    boat: Pattern "Boat", {
        {1, 1, 0}
        {1, 0, 1}
        {0, 1, 0}
    }

    -- oscillators

    blinker: Pattern "Blinker", {
        {1, 1, 1}
    }

    toad: Pattern "Toad", {
        {0, 1, 1, 1}
        {1, 1, 1, 0}
    }

    beacon: Pattern "Beacon", {
        {1, 1, 0, 0}
        {1, 0, 0, 0}
        {0, 0, 0, 1}
        {0, 0, 1, 1}
    }

    pulsar: Pattern "Pulsar", {
        {0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0}
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
        {1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1}
        {1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1}
        {1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1}
        {0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0}
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
        {0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0}
        {1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1}
        {1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1}
        {1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1}
        {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
        {0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0}
    }

    -- spaceships

    glider: Pattern "Glider", {
        {0, 1, 0}
        {0, 0, 1}
        {1, 1, 1}
    }

    lightweight_spaceship: Pattern "Lightweight Spaceship", {
        {0, 1, 1, 1, 1}
        {1, 0, 0, 0, 1}
        {0, 0, 0, 0, 1}
        {1, 0, 0, 1, 0}
    }

    -- Methuselahs
    -- i.e. evolve for long periods before stabilizing

    r_pentonimo: Pattern "R-pentonimo", {
        {0, 1, 1}
        {1, 1, 0}
        {0, 1, 0}
    }

    diehard: Pattern "Diehard", {
        {0, 0, 0, 0, 0, 0, 1, 0}
        {1, 1, 0, 0, 0, 0, 0, 0}
        {0, 1, 0, 0, 0, 1, 1, 1}
    }

    acorn: Pattern "Acorn", {
        {0, 1, 0, 0, 0, 0, 0}
        {0, 0, 0, 1, 0, 0, 0}
        {1, 1, 0, 0, 1, 1, 1}
    }

    -- miscellaneous

    gosperglidergun: Pattern "Gosper Glider Gun",
        Pattern.gridFromCellsFile "res/patterns/gosperglidergun.cells"

    aircraftcarrier: Pattern "Aircraft Carrier",
        Pattern.gridFromCellsFile "res/patterns/aircraftcarrier.cells"

    noahsark: Pattern "Noah's Ark",
        Pattern.gridFromCellsFile "res/patterns/noahsark.cells"

    -- my discoveries (for fun)
    bomb: Pattern "Bomb", {
        {0, 0, 1, 0, 0, 0}
        {0, 0, 0, 1, 0, 0}
        {1, 1, 0, 0, 1, 1}
    }
}
