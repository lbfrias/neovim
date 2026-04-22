return {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    opts = {},
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
    end

}
