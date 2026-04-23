return {
    "cenk1cenk2/schema-companion.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("schema-companion").setup({
            log_level = vim.log.levels.INFO,
            picker = "fzf-lua",
        })

        vim.keymap.set("n", "<leader>cs", function()
            require("schema-companion").select_schema()
        end, { desc = "Select schema" })
    end,

}
