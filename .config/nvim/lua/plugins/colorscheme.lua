return {
    -- gruvbox
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            require("gruvbox").setup({})
            vim.o.background = "dark" -- or "light" for light mode
            vim.cmd([[colorscheme gruvbox]])
        end,
    },
    -- catppuccin/nvim
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1001,
        config = function()
            vim.cmd("colorscheme catppuccin-mocha")
        end,
    },

    -- gruvbox-material
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1002,
        config = function()
            -- Optionally configure and load the colorscheme
            -- directly inside the plugin declaration.
            vim.g.gruvbox_material_enable_italic = true
            vim.cmd.colorscheme('gruvbox-material')
        end
    }
}
