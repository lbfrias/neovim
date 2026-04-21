return {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
        {
            "nvim-lua/plenary.nvim",
            branch = "master"
        },
    },
    build = "make tiktoken",
    init = function()
      require("CopilotChat").setup(opts)
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
        end,
      })
    end,
    opts = {
    }
}
