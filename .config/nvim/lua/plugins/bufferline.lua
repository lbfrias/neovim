return {
    'akinsho/bufferline.nvim',
    event = "VeryLazy",
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
        options = {
            termguicolors = true,
            separator_style = "slope",
            indicator = {
                style = "underline"
            },
            diagnostics = "nvim_lsp",
            diagnostics_indicator = function(_, _, diagnostics_dict, _)
                local s = " "
                for e, n in pairs(diagnostics_dict) do
                    local sym = e == "error" and " "
                    or (e == "warning" and " " or " ")
                    s = s .. n .. sym
                end
                return s
            end,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "File Explorer",
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
            },
            always_show_bufferline = false,
            custom_filter = function(buf_number)
                -- Do not show Alpha in the bufferline
                if vim.bo[buf_number].filetype == "alpha" then
                    return false
                end
                return true
            end,
        }
    },
}

