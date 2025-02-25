local util = require("lvim-colorscheme.util")

local M = {}

--- @param colors ColorScheme
function M.generate(colors)
    colors.bg_line = util.blend_bg(colors.bg_highlight, 0.2)
    local neomutt = util.template([[# Lvim]] .. (colors._style:gsub("^%l", string.upper)) .. [[ colors for Neomutt

# Basic Colors
color normal          ${fg}             default         # normal text
color indicator       default           ${bg_line}      # selected item
color tree            ${cyan_dark}      default         # thread arrows
color status          ${blue_dark}      default         # status line
color error           ${red_dark}       default         # error messages
color message         ${green_dark}     default         # info messages
color markers         ${orange_dark}    default         # + at line wrapping
color attachment      ${magenta_dark}   default         # attachment info
color search          ${yellow_dark}    default         # search matches
color tilde           ${comment}        default         # ~ empty lines

# Message Headers
color hdrdefault      ${comment}        default         # default header
color header          ${blue}           default         '^From:'
color header          ${purple_dark}    default         '^Subject:'
color header          ${cyan}           default         '^User-Agent:.*Mutt'
color header          ${cyan_dark}      default         '^User-Agent: Mozilla/5.0.*Linux'

# Message Body
color quoted          ${green}          default         # quoted text
color quoted1         ${blue_dark}      default         # nested quote
color quoted2         ${purple}         default         # nested quote 2
color quoted3         ${cyan_dark}      default         # nested quote 3
color quoted4         ${yellow_dark}    default         # nested quote 4
color quoted5         ${magenta}        default         # nested quote 5
color signature       ${comment}        default         # signature
color bold            ${orange}         default         # bold text
color underline       ${orange_dark}    default         # underlined text

# Message Index
color index           ${cyan}           default         ~Q  # replied messages
color index           ${red_dark}       default         ~D  # deleted messages
color index           ${comment}        default         ~O  # old messages
color index           ${blue_dark}      default         ~P  # from me
color index           ${yellow_dark}    default         ~T  # tagged messages
color index           ${orange}         default         ~F  # flagged messages
color index           ${purple_dark}    default         ~v  # collapsed thread
color index           ${magenta}        default         ~k  # GPG
color index           ${green_dark}     default         ~N  # new messages
color index_author    ${cyan_dark}      default         .*  # all authors

# Special Email Elements
color body            ${blue_dark}      default         "[-a-z_0-9.+]+@[-a-z_0-9.]+"
color body            ${cyan_dark}      default         "((ftp|http|https)://|news:)[^ >)\"\t]+"
color body            ${yellow}         default         "\\[[0-9]+\\]"
color body            ${yellow_dark}    default         "\\[\\.\\.\\.?\\]"

# Index Flags and Metadata
color index_flags     ${red}            default         ~D   # deleted
color index_flags     ${cyan_dark}      default         ~g   # signed
color index_flags     ${blue_dark}      default         ~G   # encrypted
color index_author    ${green_dark}     default         ~P   # from me
color index_author    ${orange_dark}    default         ~F   # flagged
color index_author    ${orange_dark}    default         ~l   # mailing lists
color index_flags     ${green}          default         ~N   # new
color index_flags     ${red_dark}       default         ~l   # lists
color index_date      ${red}            default              # date
color index_size      ${blue_dark}      default              # size
color index_number    ${yellow_dark}    default              # number

color indicator             default         ${bg_line}
color sidebar_indicator     ${orange_dark}  ${bg_line}
color sidebar_highlight     default         ${bg_line}
color sidebar_background    ${fg}           default
color sidebar_divider       ${blue_dark}    default
color sidebar_flagged       ${blue_dark}    default
color sidebar_new           ${red}          default
color sidebar_ordinary      ${green_dark}   default
color sidebar_spool_file    ${yellow}       default
color sidebar_unread        ${red}          default


# Mono Settings
mono bold             bold
mono underline        underline
mono indicator        reverse
mono error            bold]], colors)
    return neomutt
end

return M
