return {
    'neovim-treesitter/nvim-treesitter',
    dependencies = { 'neovim-treesitter/treesitter-parser-registry' },
    lazy = false,
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter').install {
            -- scripting
            'bash',
            'zsh',
            'powershell',
            'python',
            -- config formats
            'lua',
            'yaml',
            'json',
            'hcl',        -- Terraform / OpenTofu
            'xml',
            'ini',
            'toml',
            -- git
            'git_config',
            'git_rebase',
            'gitattributes',
            'gitcommit',
            'gitignore',
            -- cryptography
            'gpg',
            -- terraform
            'terraform',
            -- containers & k8s
            'dockerfile',
            'helm',
            -- other
            'regex',      -- useful inside yaml/json injections
            'comment',    -- highlights TODO/FIXME/NOTE in any file
            'markdown',   -- for better markdown editing and previewing
            'markdown_inline', -- for better markdown editing and previewing
            'mermaid',    -- for better mermaid diagram editing and previewing
            'ssh_config', -- for better ssh config editing
            'vim',        -- for better vimscript editing
        }

        vim.api.nvim_create_autocmd('FileType', {
        pattern = '*',
        callback = function(args)
            local ft = vim.bo[args.buf].filetype
            if ft == '' or ft == nil then return end

            -- only start treesitter if a parser exists for this filetype
            local ok = pcall(vim.treesitter.language.inspect, ft)
            if not ok then return end

            vim.treesitter.start()
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo.foldenable = false
            vim.wo.foldlevel = 99
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
        })
    end,
}
