return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VeryLazy",
        config = function()
            require("fzf-lua").setup({
                files = {
                    hidden = true,
                    follow = true,
                },
                grep = {
                    hidden = true,
                    follow = true,
                },
            })
            require("fzf-lua").register_ui_select()
        end,
    }
}
