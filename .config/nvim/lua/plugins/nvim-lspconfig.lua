return {
    "neovim/nvim-lspconfig",
    dependencies = { 
        "b0o/schemastore.nvim",
        "cenk1cenk2/schema-companion.nvim" 
    },
    lazy = false,
    config = function()
        local companion = require("schema-companion")

        -- --- JSONLS CONFIGURATION ---
        local jsonls_companion = companion.adapters.jsonls.setup({
            sources = {
                companion.sources.lsp.setup(),
                -- You can add specific JSON sources here if needed
            },
        })

        vim.lsp.config('jsonls', companion.setup_client(
            jsonls_companion,
            {
                settings = {
                    json = {
                        schemaStore = { enable = true },
                        -- Integrate SchemaStore for JSON
                        schemas = require('schemastore').json.schemas(),
                        validate = { enable = true },
                    },
                },
            }
        ))

        -- --- YAMLLS CONFIGURATION ---
        local yamlls_companion = companion.adapters.yamlls.setup({
            sources = {
                companion.sources.matchers.kubernetes.setup({ version = "master" }),
                companion.sources.lsp.setup(),
                companion.sources.schemas.setup({
                    {
                        name = "Kubernetes (master)",
                        uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict/all.json",
                    },
                }),
            },
        })

        vim.lsp.config('yamlls', companion.setup_client(
            yamlls_companion,
            {
                settings = {
                    yaml = {
                        schemaStore = { enable = true },
                        schemas = require('schemastore').yaml.schemas(),
                        validate = { enable = true },
                        kubernetesCRDStore = { enable = true }
                    }
                }
            }
        ))

        -- --- PYRIGHT ---
        vim.lsp.config('pyright', {
            settings = {
                python = {
                    analysis = { typeCheckingMode = "basic" }
                }
            }
        })
    end,
}
