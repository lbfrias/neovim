return {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    opts = {},
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionChatCLI", "CodeCompanionChatActions", "CodeCompanionChatCLI" },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("codecompanion").setup({
            interactions = {
                chat = {
                    adapter = "copilot",
                },
            },
            opts = {
                log_level = "DEBUG",
            },
        })

        vim.api.nvim_create_autocmd("Filetype", {
            pattern = "codecompanion",
            callback = function()
                vim.opt_local.number = false
                vim.opt_local.relativenumber = false
            end,
        })
    end
}
