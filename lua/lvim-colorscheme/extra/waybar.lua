local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors, _, opts)
    local function capitalizeFirstLetter(str)
        return (str:gsub("^%l", string.upper))
    end

    local nameTheme = "Lvim" .. capitalizeFirstLetter(opts.style)

    local waybar = util.template(
        [[
* {
    font-family: "JetBrainsMono Nerd Font", "FiraCode Nerd Font", monospace;
    font-size: 13px;
    font-weight: bold;
    min-height: 0;
}

window#waybar {
    background-color: ${bg_dark};
    color: ${fg};
    padding: 0;
    margin: 0;
}

#workspaces,
#clock,
#tray,
#pulseaudio,
#network,
#battery,
#cpu,
#memory,
#disk,
#disk-data,
#custom-kb,
#hyprland-language,
#mpd,
#backlight,
#temperature {
    padding: 0 8px;
    margin: 0 4px;
    background-color: ${bg_dark};
    border: none;
}

#clock:hover,
#tray:hover,
#pulseaudio:hover,
#network:hover,
#battery:hover,
#cpu:hover,
#memory:hover,
#disk:hover,
#disk-data:hover,
#custom-kb:hover,
#hyprland-language:hover,
#mpd:hover,
#backlight:hover,
#temperature:hover {
    background-color: ${bg};
}

#workspaces {
    background: transparent;
    border: none;
    margin: 0;
    padding: 0;
}

#workspaces button {
    border-radius: 0;
    padding: 0 10px;
    margin: 0;
    background: transparent;
    color: ${red};
    border: none;
}

#workspaces button:hover {
    background: ${bg};
}

#workspaces button.active {
    border-radius: 0;
    background: ${bg};
    color: ${green};
    border: none;
}

#window {
    padding: 0 10px;
}

#disk {
    color: ${cyan};
}

#disk-data {
    color: ${teal};
}

#language {
    color: ${teal};
    padding: 0 8px;
    margin: 0 4px;
    background-color: ${bg_dark};
    border: none;
}

#language:hover {
    background-color: ${bg};
}

#pulseaudio {
    color: ${orange};
}

#pulseaudio.muted {
    color: ${red};
}

#network {
    color: ${blue};
}

#network.disconnected {
    color: ${red};
}

#battery {
    color: ${yellow};
}

#battery.charging {
    color: ${green};
}

#battery.warning,
#battery.critical {
    color: ${red};
}

#cpu {
    color: ${red};
}

#memory {
    color: ${red};
}

#clock {
    color: ${blue};
}

#mpd {
    color: ${cyan};
}

#mpd.disconnected {
    color: ${red};
}

#mpd.stopped {
    color: ${fg_soft_dark};
}

#mpd.paused {
    color: ${cyan_dark};
}

#custom-mpd-prev {
    color: ${cyan};
}

#custom-mpd-next {
    color: ${cyan};
}
]],
        vim.tbl_extend("force", colors, { style = nameTheme })
    )

    return waybar
end

return M
