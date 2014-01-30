export ^

class Debagel
    new: (@font) =>
        @vars = {}

    monitor: (name, value=0) =>
        @vars[name] = value

    update: (dt) =>

    draw: =>
        love.graphics.setFont(@font)
        love.graphics.setColor {0, 0, 0}
        love.graphics.rectangle "fill",
            10, 10,
            100, 100
        love.graphics.setColor {255, 255, 255}
        cnt = 0
        for name, value in pairs @vars
            love.graphics.print "#{name}: #{value}",
                15, 15 + (cnt) * 12
            cnt += 1
