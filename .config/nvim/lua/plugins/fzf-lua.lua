return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VeryLazy",
        config = function()
            require("fzf-lua").setup({})
            require("fzf-lua").register_ui_select()
        end,
    }
}
