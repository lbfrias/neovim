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
            pattern = {'python',},
            callback = function()
                vim.treesitter.start()
                vim.wo.foldmethod = 'expr'
                vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                vim.wo.foldenable = false  -- don't fold on open
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
