return {
    'akinsho/bufferline.nvim',
    event = "VeryLazy",
    version = "*", 
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
        options = {
            termguicolors = true,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "Neo-tree",
                    text_align = "center"
                },
                {
                    filetype = "DiffviewFiles",
                    text = "Diffview",
                    text_align = "center"
                },
                {
                    filetype = "sidekick_terminal",
                    text = "Copilot CLI",
                    text_align = "center"
                },
            }
        }
    },
}

