return {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    priority = 500,
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        -- Header
        dashboard.section.header.val = {
            "$$\\   $$ |$$$$$$$$\\  $$$$$$\\  $$\\    $$ |$$$$$$\\ $$\\      $$ |",
            "$$$\\  $$ |$$  _____|$$  __$$\\ $$ |   $$ |\\_$$  _|$$$\\    $$$ |",
            "$$$$\\ $$ |$$ |      $$ /  $$ |$$ |   $$ |  $$ |  $$$$\\  $$$$ |",
            "$$ $$\\$$ |$$$$$\\    $$ |  $$ |\\$$\\  $$  |  $$ |  $$\\$$\\$$ $$ |",
            "$$ \\$$$$ |$$  __|   $$ |  $$ | \\$$\\$$  /   $$ |  $$ \\$$$  $$ |",
            "$$ |\\$$$ |$$ |      $$ |  $$ |  \\$$$  /    $$ |  $$ |\\$  /$$ |",
            "$$ | \\$$ |$$$$$$$$\\  $$$$$$  |   \\$  /   $$$$$$$\\$$ | \\_/ $$ |",
            "\\__|  \\__|\\________| \\______/     \\_/    \\______|\\__|     \\__|",
        }
        dashboard.section.header.opts.hl = "AlphaHeader"

        -- Action buttons
        dashboard.section.buttons.val = {
            dashboard.button("e", "  New file",     "<cmd>enew<cr>"),
            dashboard.button("f", "  Find file",    "<cmd>FzfLua files<cr>"),
            dashboard.button("r", "  Recent files", "<cmd>FzfLua oldfiles<cr>"),
            dashboard.button("q", "  Quit",         "<cmd>qa<cr>"),
        }

        -- Footer: lazy.nvim plugin count
        local function footer()
            local stats = require("lazy").stats()
            return string.format(
                " %d plugins loaded in %.2fms",
                stats.loaded,
                stats.startuptime
            )
        end

        dashboard.section.footer.val = footer()
        dashboard.section.footer.opts.hl = "AlphaFooter"

        -- Dynamic top padding to vertically center content
        -- Content breakdown:
        --   header:          8 lines
        --   pad after header: 2
        --   buttons:         4 lines
        --   pad after buttons: 2
        --   footer:          1 line
        --   total:           ~17 lines
        local content_height = 17
        local function top_padding()
            local lines = vim.o.lines - vim.o.cmdheight
            local pad = math.floor((lines - content_height) / 2)
            return math.max(pad, 2)
        end

        -- Ensure highlight groups are always defined
        local function set_highlights()
            vim.api.nvim_set_hl(0, "AlphaShortcut", { link = "Keyword" })
            vim.api.nvim_set_hl(0, "AlphaHeader",   { link = "Title" })
            vim.api.nvim_set_hl(0, "AlphaButtons",  { link = "Normal" })
            vim.api.nvim_set_hl(0, "AlphaFooter",   { link = "Comment" })
        end
        set_highlights()
        vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })

        -- Layout
        dashboard.config.layout = {
            { type = "padding", val = top_padding() },
            dashboard.section.header,
            { type = "padding", val = 2 },
            dashboard.section.buttons,
            { type = "padding", val = 2 },
            dashboard.section.footer,
        }

        -- Disable alpha's own VimEnter handler, we'll manage it ourselves
        dashboard.config.opts = { noautocmd = true }

        alpha.setup(dashboard.config)

        -- Only open alpha when no file is passed as argument
        if vim.fn.argc() == 0 then
            vim.api.nvim_create_autocmd("User", {
                pattern = "LazyVimStarted",
                once = true,
                callback = function()
                    vim.schedule(function()
                        local buf = vim.api.nvim_get_current_buf()
                        local name = vim.api.nvim_buf_get_name(buf)
                        local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
                        local is_empty = name == "" and #lines == 1 and lines[1] == ""
                        if is_empty then
                            require("alpha").start(true)
                        end
                    end)
                end,
            })
        end

        -- Refresh footer after lazy is done loading
        vim.api.nvim_create_autocmd("User", {
            pattern = "LazyVimStarted",
            once = true,
            callback = function()
                dashboard.section.footer.val = footer()
                pcall(vim.cmd.AlphaRedraw)
            end,
        })

        -- Open alpha when the last listed buffer is deleted
        vim.api.nvim_create_autocmd("BufDelete", {
            callback = function()
                vim.schedule(function()
                    local bufs = vim.fn.getbufinfo({ buflisted = 1 })

                    -- Check if we are down to one buffer and it's empty/unnamed
                    if #bufs == 1 and bufs[1].name == "" and bufs[1].changed == 0 then
                        local lines = vim.api.nvim_buf_get_lines(bufs[1].bufnr, 0, -1, false)
                        if #lines == 1 and lines[1] == "" then
                            -- Don't trigger if we are already on the alpha screen
                            if vim.bo.filetype ~= "alpha" then
                                vim.cmd("Alpha")
                            end
                        end
                    elseif #bufs == 0 then
                        -- Fallback if no buffers are left at all
                        vim.cmd("Alpha")
                    end
                end)
            end,
        })

    end,
}
