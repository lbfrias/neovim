return {
    "folke/sidekick.nvim",
    event = "VeryLazy",
    opts = {
        mux = {
            backend = "tmux",
            enabled = true,
        },
        nes = {
            enabled = true,
        },
    }
}
