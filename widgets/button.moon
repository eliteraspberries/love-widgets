-- Copyright 2019, Mansour Moufid <mansourmoufid@gmail.com>

love = require 'love'
love.graphics = require 'love.graphics'
widgets = require 'widgets'

class Button extends widgets.Widget
    label: => 'button'
    border: 2
    borderradius: 8
    state: => false
    toggle: =>
    drawrectangle: (x, y, w, h, br) =>
        bd = 2 * br
        love.graphics.circle 'fill', x + br, y + br, br, 6 * br
        love.graphics.circle 'fill', x + w - br, y + br, br, 6 * br
        love.graphics.circle 'fill', x + w - br, y + h - br, br, 6 * br
        love.graphics.circle 'fill', x + br, y + h - br, br, 6 * br
        love.graphics.rectangle 'fill', x + br, y, w - bd, bd
        love.graphics.rectangle 'fill', x + w - bd, y + br, bd, h - bd
        love.graphics.rectangle 'fill', x + br, y + h - bd, w - bd, bd
        love.graphics.rectangle 'fill', x, y + br, bd, h - bd
        love.graphics.rectangle 'fill', x + br, y + br, w - bd, h - bd
    draw: =>
        {bg, fg} = {@colours.bg, @colours.fg}
        if @state()
            {bg, fg} = {@colours.fg, @colours.bg}
        love.graphics.setColor fg
        {x, y} = @position()
        {w, h} = @size()
        bw = @border
        br = @borderradius
        @drawrectangle x, y, w, h, br + bw
        love.graphics.setColor bg
        @drawrectangle x + bw, y + bw, w - 2 * bw, h - 2 * bw, br
        love.graphics.setColor fg
        @drawlabel()
    within: (x, y) =>
        {a, b} = @position()
        {c, d} = @size()
        x >= a and x <= a + c and y >= b and y <= b + d
    mousepressed: (x, y) =>
        if @within x, y
            @border = @border / 2
    mousereleased: (x, y) =>
        @border = @@border
        if @within x, y
            @toggle()

class CircleButton extends Button
    center: => {0, 0}
    radius: => 40
    within: (x, y) =>
        {a, b} = @center()
        r = @radius()
        (x - a) ^ 2 + (y - b) ^ 2 <= r ^ 2
    draw: =>
        {x, y} = @center()
        r = @radius()
        {bg, fg} = {@colours.bg, @colours.fg}
        if @state()
            {bg, fg} = {@colours.fg, @colours.bg}
        love.graphics.setColor fg
        love.graphics.circle 'fill', x, y, r, 6 * r
        love.graphics.setColor bg
        love.graphics.circle 'fill', x, y, r - @border, 6 * r
        love.graphics.setColor fg
        @drawlabel()
    update: (dt) =>
        {x, y} = @center()
        r = @radius()
        @position = => {x - r, y - r}
        @size = => {2 * r, 2 * r}

{:Button, :CircleButton}
