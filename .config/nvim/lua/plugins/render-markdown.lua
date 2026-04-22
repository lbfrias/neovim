return {
    "MeanderingProgrammer/render-markdown.nvim", -- Make Markdown buffers look beautiful
    ft = { "markdown", "codecompanion" },
    opts = {
        render_modes = true, -- Render in ALL modes
        sign = {
            enabled = false, -- Turn off in the status column
        },
    },
    config = function(_, opts)
        require('render-markdown').setup(opts)

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "codecompanion",
            callback = function(ev)
                local name = vim.api.nvim_buf_get_name(ev.buf)
                if name == "" then
                    vim.bo[ev.buf].filetype = "markdown"
                end
            end,
        })
    end,
}
