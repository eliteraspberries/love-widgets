-- Copyright 2019, Mansour Moufid <mansourmoufid@gmail.com>

love = require 'love'
button = require 'widgets.button'

state =
    widgets: {}
    window:
        colours:
            bg: {0.9, 0.9, 0.9}
            fg: {0.1, 0.1, 0.1}
        flags:
            fullscreen: false
            highdpi: true
            minheight: 320
            minwidth: 320
            msaa: 2
            resizable: true
            vsync: true
        fonts: {}
        fps: 0
        title: 'love-widgets demo'
        width: 640
        height: 480

for i, x in pairs {'a', 'b', 'c'} do
    table.insert state.widgets, button.CircleButton {
        label: => x
        center: => {80, i * state.window.height / 4}
        radius: => 40
        on: false
        state: => @on
        toggle: => @on = not @on
        keypressed: (z) =>
            if z == @label()
                @mousepressed @middle()
        keyreleased: (z) =>
            if z == @label()
                @mousereleased @middle()
    }

keys = {'0', '.', '=', '1', '2', '3', '4', '5', '6', '7', '8', '9'}
for k, key in ipairs keys do
    i = math.floor((k - 1) / 3)
    j = (k - 1) % 3
    table.insert state.widgets, button.Button {
        label: => key
        position: =>
            {w, h} = @size()
            w += 5
            h += 5
            x = state.window.width / 2 - 1.5 * w + j * w
            y = state.window.height / 2 + 1.0 * h - i * h
            {x, y}
        size: => {100, 50}
        keypressed: (z) =>
            if z == @label()
                @mousepressed @middle()
        keyreleased: (z) =>
            if z == @label()
                @mousereleased @middle()
    }

love.load = ->
    love.window.setTitle state.window.title
    w, h = state.window.width, state.window.height
    love.window.setMode w, h, state.window.flags
    love.graphics.setFont love.graphics.newFont 20
    for widget in *state.widgets do
        widget\load()

love.update = (dt) ->
    state.window.fps = love.timer.getFPS()
    if dt < 1 / 30
        love.timer.sleep (1 / 30 - dt)
    for widget in *state.widgets do
        widget\update dt

love.draw = ->
    window = state.window
    colours = window.colours
    love.graphics.setColor colours.bg
    love.graphics.rectangle 'fill', 0, 0, window.width, window.height
    font = state.window.fonts.default
    if font ~= nil
        love.graphics.setFont font
    for widget in *state.widgets do
        widget\draw()

love.keypressed = (key) ->
    for widget in *state.widgets do
        widget\keypressed(key)

love.keyreleased = (key) ->
    if key == 'escape'
        love.event.quit()
    for widget in *state.widgets do
        widget\keyreleased(key)

love.mousepressed = (x, y) ->
    for widget in *state.widgets do
        widget\mousepressed(x, y)

love.mousereleased = (x, y) ->
    for widget in *state.widgets do
        widget\mousereleased(x, y)

love.resize = (w, h) ->
    state.window.width = w
    state.window.height = h
    for widget in *state.widgets do
        widget\resize(w, h)
