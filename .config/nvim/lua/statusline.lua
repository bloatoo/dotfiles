local gl = require("galaxyline")
local gls = gl.section

gl.short_line_list = {" "} -- keeping this table { } as empty will show inactive statuslines

local colors = {
    bg = "#22262e",
    red = "#353b45",
    yellow = "#ebcb8b",
    green = "#a3be8c",
    lightfg = "#2e3340",
    fg = "#d8dee9",
    gray_fg = "#6f737b",
    gray = "#30343c"
}

gls.left[1] = {
    main = {
        provider = function()
            return "   "
        end,
        highlight = {colors.bg, colors.yellow},
        separator_highlight = {colors.yellow, colors.red},
        separator = "",
    }
}

gls.left[2] = {
    sep = {
        provider = function()
            return "  "
        end,
        highlight = {colors.fg, colors.red}
    }
}

gls.left[3] = {
    FileName = {
        provider = {"FileName"},
        condition = buffer_not_empty,
        separator = "",
        separator_highlight = { colors.red, colors.gray },
        highlight = {colors.fg, colors.red }
    }
}

gls.left[4] = {
    GitBranch = {
        provider = "GitBranch",
        icon = "  ",
        condition = require("galaxyline.provider_vcs").check_git_workspace,
        highlight = {colors.gray_fg, colors.gray},
        separator = "",
        separator_highlight = { colors.gray, colors.bg },
    }
}

gls.right[1] = {
    ViMode = {
        provider = function()
            local alias = {
                n = " normal ",
                i = " insert ",
                c = " command ",
                V = " visual ",
                [""] = " visual ",
                v = " visual ",
                R = " replace "
            }
            return alias[vim.fn.mode()]
        end,
        highlight = {colors.fg, colors.red},
        separator = "",
        separator_highlight = { colors.red, colors.bg},
    }
}

gls.right[2] = {
    PerCent = {
        provider = "LinePercent",
        highlight = {colors.bg, colors.yellow},
        separator = "",
        separator_highlight = { colors.yellow, colors.red},
    }
}
