return {
    "neovim/nvim-lspconfig",
    dependencies = { 
        "b0o/schemastore.nvim",
        "cenk1cenk2/schema-companion.nvim" -- Ensure it's a dependency
    },
    lazy = false,
    config = function()
        local companion = require("schema-companion")

        -- 1. Initialize the companion's yamlls adapter
        local yamlls_companion = companion.adapters.yamlls.setup({
            sources = {
                -- Adds built-in Kubernetes matching logic
                companion.sources.matchers.kubernetes.setup({ version = "master" }),
                -- Pulls in schemas already present in your LSP config
                companion.sources.lsp.setup(),
                -- Static schemas (like your custom K8s URI)
                companion.sources.schemas.setup({
                    {
                        name = "Kubernetes master",
                        uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict/all.json",
                    },
                }),
            },
        })

        -- 2. Configure yamlls using the companion's output
        vim.lsp.config('yamlls', companion.setup_client(
            yamlls_companion,
            {
                -- Your existing yamlls-specific settings go here
                settings = {
                    yaml = {
                        schemaStore = {
                            enable = false,
                            url = "",
                        },
                        -- Merge SchemaStore schemas into the companion's logic
                        schemas = require('schemastore').yaml.schemas(),
                    }
                }
            }
        ))

        -- Your other LSPs remain unchanged
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
