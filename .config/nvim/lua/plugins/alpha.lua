return {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    priority = 500,
    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")

        -- Flag to bypass BufEnter tracking when explicitly creating a new file
        local creating_new_file = false

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

        vim.api.nvim_create_user_command("DashboardNewFile",
            function()
                creating_new_file = true
                vim.cmd("enew")
                creating_new_file = false
            end,
            {}
        )

        dashboard.section.buttons.val = {
            -- Customized "New file" logic to circumvent the auto-close block
            dashboard.button("e", "  New file", ":DashboardNewFile<cr>"),
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

        -- Disable alpha's own VimEnter handler
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

        -- Open Alpha when entering an empty fallback buffer
        vim.api.nvim_create_autocmd("BufEnter", {
            callback = function()
                -- Skip completely if we are intentionally pressing "e" to create a new file
                if creating_new_file then return end

                vim.schedule(function()
                    local bufs = vim.fn.getbufinfo({ buflisted = 1 })

                    if #bufs == 1 then
                        local cur_buf = bufs[1].bufnr
                        local name = vim.api.nvim_buf_get_name(cur_buf)
                        local lines = vim.api.nvim_buf_get_lines(cur_buf, 0, -1, false)
                        local is_empty = name == "" and #lines == 1 and lines[1] == ""

                        if is_empty and vim.bo[cur_buf].filetype ~= "alpha" then
                            vim.bo[cur_buf].buflisted = false
                            require("alpha").start(true)
                        end
                    elseif #bufs == 0 then
                        require("alpha").start(true)
                    end
                end)
            end,
        })

    end,
}
