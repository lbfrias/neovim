return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
        ensure_installed = {
            -- LSP servers
            "azure_pipelines_ls",
            "bashls",
            "docker_compose_language_service",
            "docker_language_server",
            "jsonls",
            "pyright",
            "terraformls",
            "yamlls",
            -- linters
            "ansible-lint",
            "tflint"
        },
        auto_update = true,
        run_on_start = true,
    },
}
