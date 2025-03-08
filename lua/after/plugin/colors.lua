function ColorMyPencils(color)
    -- color = color or "vscode"
    -- color = color or "nord"
    -- color = color or "rose-pine"
    -- color = color or "tokyonight"
    -- color = color or "catppuccin"
    -- vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
