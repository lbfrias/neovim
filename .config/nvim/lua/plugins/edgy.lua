return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {
        left = {
            {
                ft = "neo-tree",
                title = "Neo-tree",
                size = { width = 0.2 },
                wo = { winbar = false },
                filter = function(buf)
                    return vim.b[buf].neo_tree_source == "filesystem"
                end,
            },
        },
        right = {
            {
                ft = "sidekick_terminal",
                title = "Copilot",
                size = { width = 0.4 },
                wo = { winbar = false },
            },
        },
        bottom = {
            {
                ft = "toggleterm",
                title = function()
                    local buf = vim.api.nvim_get_current_buf()
                    local terms = require("toggleterm.terminal").get_all()
                    for _, t in pairs(terms) do
                        if t.bufnr == buf then
                            return "Terminal " .. t.id
                        end
                    end
                    return "Terminal"
                end,
                size = { height = 0.25 },
                wo = { winbar = true},
            },
        },
        animate = {
            enabled = false,
        },
        keys = {
            ["<C-.>"] = function(win)
                -- Calculate maximum allowed width (e.g., 45% of total screen columns)
                local max_width = math.floor(vim.o.columns * 0.45)

                if win.width < max_width then
                    win:resize("width", 3)
                end
            end,

            ["<C-,>"] = function(win)
                -- Calculate minimum allowed width (e.g., 15% of total screen columns)
                local min_width = math.floor(vim.o.columns * 0.15)

                if win.width > min_width then
                    win:resize("width", -3)
                end
            end,
        }
    } 
}
