return {
    "luukvbaal/statuscol.nvim",
    event = "BufReadPost",
    config = function()
        local builtin = require("statuscol.builtin")
        vim.opt.foldcolumn = "1"
        require("statuscol").setup({
            relculright = true,
            segments = {
                {
                    text = { "%s" },
                    click = "v:lua.ScSa"
                },
                {
                    text = { builtin.lnumfunc, " " },
                    click = "v:lua.ScLa"
                },
                {
                    text = {
                        function(args)
                            args.fold.close = "▸"
                            args.fold.open = "▾"
                            args.fold.sep = " "
                            return builtin.foldfunc(args)
                        end,
                    },
                    click = "v:lua.ScFa"
                },
            },
        })

        vim.api.nvim_create_autocmd("BufReadPost", {
            callback = function()
                vim.schedule(function()
                    vim.cmd("norm! zx")
                end)
            end,
        })
    end,
}
