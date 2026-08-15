local primary = "eDP-1"

hl.monitor({
    output = primary,
    mode = "1366x768@60",
    position = "0x0",
})

for ws = 1, 10 do
    hl.workspace({
        id = ws,
        monitor = primary,
    })
end
