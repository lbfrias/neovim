return {
    "github/copilot.vim",
    event = "InsertEnter",
    cmd = "Copilot",
    config = function()
        -- Disable default Tab keybinding
        vim.g.copilot_no_tab_map = true
        
        -- Set custom keybinding for Copilot (Ctrl-Alt-l)
        vim.keymap.set('i', '<C-M-l>', 'copilot#Accept("\\<CR>")', { noremap = true, silent = true, expr = true, replace_keycodes = false })
    end
}

