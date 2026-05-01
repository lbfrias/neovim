return {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    dependencies = { 
        'nvim-tree/nvim-web-devicons',
        'cenk1cenk2/schema-companion.nvim',
    },
    opts = {
        options = {
            disabled_filetypes = {
                'codecompanion',
                'neo-tree',
                'toggleterm'
            },
            theme = 'auto'
        },
        sections = {
            lualine_c = { 'filename' },
            lualine_x = {
                -- Integrated Schema Companion Component
                {
                    function()
                        local companion = require("schema-companion")
                        local schema = companion.get_current_schemas()
                        -- Uses a standard YAML icon or a string label
                        return ("󱘬 %s"):format(schema or "none"):sub(0, 128)
                    end,
                    cond = function()
                        -- Check if plugin is loaded AND if we are in a supported filetype
                        return package.loaded["schema-companion"] 
                            and require("schema-companion").get_current_schemas() ~= nil
                    end,
                    color = "DiagnosticHint"
                },
                'encoding',
                'fileformat',
                'filetype',
            },
            lualine_z = {
                'location',
                {
                    require("lazy.status").updates,
                    cond = require("lazy.status").has_updates,
                    color = "DiagnosticWarn",
                }
            }
        }
    },
}
