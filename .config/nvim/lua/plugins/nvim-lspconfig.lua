return {
    "neovim/nvim-lspconfig",
    dependencies = { "b0o/schemastore.nvim" },
    lazy = false,
    config = function()
        vim.lsp.config('yamlls', {
            settings = {
                yaml = {
                    schemaStore = {
                        enable = false,
                        url = "",
                    },
                    schemas = require('schemastore').yaml.schemas(),
                }
            }
        })

        vim.lsp.config('pyright', {
            settings = {
                python = {
                    analysis = {
                        typeCheckingMode = "basic",
                    }
                }
            }
        })
    end,
}
