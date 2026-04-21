return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            disabled_filetypes = {
                'copilot-chat',
                'neo-tree',
                'toggleterm'
            },
            theme = 'gruvbox'
        }
    }
}
