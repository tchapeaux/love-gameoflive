with {}
    .modulo_lua = (x, y) ->
        -- can be used to loop through lua array, which are 1-indexed
        -- e.g.
        -- 1 2 3 4 5 6 7 8 9  - x
        -- 1 2 0 1 2 0 1 2 0  - x % 3
        -- 1 2 3 1 2 3 1 2 3  - modulo_lua(x, 3)
        ((x - 1) % y) + 1
