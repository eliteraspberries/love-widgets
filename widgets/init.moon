-- Copyright 2019, Mansour Moufid <mansourmoufid@gmail.com>

love = require 'love'
love.graphics = require 'love.graphics'

class Object
    new: (args) =>
        for property, value in pairs args do
            @[property] = value

class Widget extends Object
    label: => 'widget'
    position: => {0, 0}
    size: => {100, 100}
    middle: =>
        {x, y} = @position()
        {w, h} = @size()
        x + w / 2, y + h / 2
    font: => nil
    colours:
        bg: {1.0, 1.0, 1.0}
        fg: {0.2, 0.2, 0.2}
    load: =>
    update: (dt) =>
    drawlabel: =>
        {x, y} = @position()
        {w, h} = @size()
        font = @font() or love.graphics.getFont()
        text = love.graphics.newText font, @label()
        tw, th = text\getDimensions()
        love.graphics.print @label(), x + w / 2 - tw / 2, y + h / 2 - th / 2
    draw: =>
        @drawlabel()
    resize: (w, h) =>
    keypressed: (key) =>
    keyreleased: (key) =>
    mousepressed: (x, y) =>
    mousereleased: (x, y) =>

{:Widget}
