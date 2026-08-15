local primary = "DP-2"
local secondary = "DP-3"

hypr.monitor({
    output = secondary,
    mode = "1920x1080@144",
    position = "0x180",
    bitdepth = 10,
})

hypr.monitor({
    output = primary,
    mode = "2560x1440@240",
    position = "1920x0",
    bitdepth = 10,
    transform = 0,
})

for ws = 1, 10 do
    hypr.workspace({
        id = ws,
        monitor = primary,
    })
end

for ws = 11, 20 do
    hypr.workspace({
        id = ws,
        monitor = secondary,
    })
end
