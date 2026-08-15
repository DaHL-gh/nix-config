return function (hl)
    local primary = "eDP-1"

    hl.monitor({
        output = primary,
        mode = "2880x1800@120",
        scale = 1.5,
        supports_hdr = true,
        position = "0x0",
    })

    for ws = 1, 10 do
        hl.workspace({
            id = ws,
            monitor = primary,
        })
    end
end
