local gl = require("galaxyline")
local gls = gl.section
local cnd = require("galaxyline.condition")
local vcs = require("galaxyline.provider_vcs")

gl.short_line_list = {" "} -- keeping this table { } as empty will show inactive statuslines

local colors = {
    bg = "#22262e",
    primary = "#ebcb8b",
    secondary = "#353b45",
    green = "#a3be8c",
    lightfg = "#2e3340",
    fg = "#d8dee9",
    gray_fg = "#6f737b",
    gray = "#30343c"
}

gls.left[1] = {
    primary = {
        provider = function()
            return "  " .. vim.bo.filetype .. " "
        end,
        highlight = {colors.bg, colors.primary},
        separator_highlight = {colors.primary, colors.secondary},
        separator = "",
    }
}

gls.left[2] = {
    sep = {
        provider = function()
            return " "
        end,
        highlight = {colors.fg, colors.secondary}
    }
}

gls.left[3] = {
    FileName = {
        provider = {"FileName"},
        condition = buffer_not_empty,
        separator = "",
        separator_highlight = { colors.secondary, colors.gray },
        highlight = {colors.fg, colors.secondary }
    }
}

gls.left[4] = {
    GitBranch = {
        provider = function()
            if(cnd.check_git_workspace())
            then
                return vcs.get_git_branch() .. " "
            else
                return "none "
            end
        end,
        icon = "  ",
        highlight = {colors.gray_fg, colors.gray},
        separator = "",
        separator_highlight = { colors.gray, colors.bg },
    }
}

local function check_diff(s)
    if s == nil or s == ''
    then
        return '0'
    else
        return s
    end
end

gls.right[1] = {
    DiffAdd = {
        provider = function()
            return check_diff(vcs.diff_add()) .. " "
        end,
        icon = " [+]",
        highlight = {colors.gray_fg, colors.gray},
        separator = "",
        separator_highlight = { colors.gray, colors.bg },
    },
}

gls.right[2] = {
    DiffModified = {
        provider = function()
            return check_diff(vcs.diff_modified()) .. " "
        end,
        icon = "[*]",
        highlight = {colors.gray_fg, colors.gray}
    }
}

gls.right[3] = {
    DiffRemove = {
        provider = function()
            return check_diff(vcs.diff_remove()) .. " "
        end,
        icon = "[-]",
        highlight = { colors.gray_fg, colors.gray}
    }
}

gls.right[4] = {
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
        highlight = {colors.fg, colors.secondary},
        separator = "",
        separator_highlight = { colors.secondary, colors.gray},
    }
}

gls.right[5] = {
    PerCent = {
        provider = "LinePercent",
        highlight = {colors.bg, colors.primary},
        separator = "",
        separator_highlight = { colors.primary, colors.secondary},
    }
}
