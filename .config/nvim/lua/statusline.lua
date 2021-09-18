local gl = require("galaxyline")
local gls = gl.section
local cnd = require("galaxyline.condition")
local vcs = require("galaxyline.provider_vcs")
local fileinfo = require("galaxyline.provider_fileinfo")

gl.short_line_list = {" "} -- keeping this table { } as empty will show inactive statuslines

local function check_empty_string(s, o)
    if s == nil or s == ''
    then
        return o
    else
        return s
    end
end


local colors = {
    bg = "#282828",
    --primary = "#ebcb8b",
    primary = "#a1b56c",
    secondary = "#f7ca88",
    fg = "#282828",
    gray_fg = "#282828",
    gray = "#ab4642",
    lightfg = "#2e3340",
    red = "#ab4642",
    green = "#a3be8c",
    yellow = "#ebcb8b",
    blue = "#7cafc2"
}

gls.left[1] = {
    primary = {
        provider = function()
            return "  " .. check_empty_string(vim.bo.filetype, "no ft") .. " "
        end,
        highlight = {colors.bg, colors.primary},
        separator_highlight = {colors.primary, colors.secondary},
        separator = "",
    }
}

gls.left[3] = {
    FileName = {
        provider = function()
            return check_empty_string(fileinfo.get_current_file_name(), "none ")
        end,
        condition = buffer_not_empty,
        separator = "",
        icon = " ",
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
        icon = "   ",
        highlight = {colors.gray_fg, colors.gray},
        separator = "",
        separator_highlight = { colors.gray, colors.bg },
    }
}

gls.right[1] = {
    DiffAdd = {
        provider = function()
            return check_empty_string(vcs.diff_add(), "0 ")
        end,
        icon = " [+]",
        highlight = {colors.gray_fg, colors.gray}, -- green
        separator = "",
        separator_highlight = { colors.gray, colors.bg },
    },
}

gls.right[2] = {
    DiffModified = {
        provider = function()
            return check_empty_string(vcs.diff_modified(), "0 ")
        end,
        icon = "[*]",
        highlight = {colors.gray_fg, colors.gray} -- yellow
    }
}

gls.right[3] = {
    DiffRemove = {
        provider = function()
            return check_empty_string(vcs.diff_remove(), "0 ")
        end,
        icon = "[-]",
        highlight = { colors.gray_fg, colors.gray} -- red
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
        separator = "",
        highlight = {colors.fg, colors.secondary},
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
