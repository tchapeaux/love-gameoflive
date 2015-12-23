with {}
    .modulo_lua = (x, y) ->
        -- can be used to loop through lua array, which are 1-indexed
        -- e.g.
        -- 1 2 3 4 5 6 7 8 9  - x
        -- 1 2 0 1 2 0 1 2 0  - x % 3
        -- 1 2 3 1 2 3 1 2 3  - modulo_lua(x, 3)
        ((x - 1) % y) + 1

    .str_split = (str, pattern) ->
        matches = {}
        index = 1
        while index <= str\len()
            char = str\sub(index, index)
            if char == pattern
                table.insert matches, str\sub(1, index - 1)
                str = str\sub(index + 1, -1)
                index = 1
            index += 1
        table.insert matches, str
