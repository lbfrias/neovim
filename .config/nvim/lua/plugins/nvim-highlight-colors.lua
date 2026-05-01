return {
    'brenoprata10/nvim-highlight-colors',
    version = "*",
    event = "BufReadPost",
    opts = {
        render = 'virtual', -- or 'background' or 'first_column'
    },
}
