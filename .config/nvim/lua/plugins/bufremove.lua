return {
  'echasnovski/mini.bufremove',
  version = '*',
  -- The plugin will only load when you press <leader>bd or <leader>bD
  keys = {
    {
      '<leader>bd',
      function()
        local bd = require('mini.bufremove').delete
        if vim.bo.modified then
          local choice = vim.fn.confirm(('Save changes to %s?'):format(vim.fn.bufname()), '&Yes\n&No\n&Cancel')
          if choice == 1 then vim.cmd('write') bd(0, false)
          elseif choice == 2 then bd(0, true) end
        else
          bd(0, false)
        end
      end,
      desc = 'Delete Buffer (Layout Safe)',
    },
    {
      '<leader>bD',
      function() require('mini.bufremove').delete(0, true) end,
      desc = 'Force Delete Buffer (Layout Safe)',
    },
  },
  config = function()
    require('mini.bufremove').setup({})
  end,
}
