-- ============================================================================
-- KEYMAP CONVENTIONS & MNEMONICS
-- ============================================================================
-- 
-- Leader Key: Space (<leader>)
-- Local Leader: Backslash (<localleader>)
--
-- Mnemonic Organization:
--   f = Find/Search (FzfLua commands)
--   n = Navigate (Neo-tree file explorer)
--   t = Toggle (features and views)
--   b = Buffer (bufferline navigation)
--   w = Window (navigation and resizing)
--
-- Style:
--   - All keybinds use <leader>key for consistency and which-key.nvim integration
--   - Organized by function for easier discovery and customization
--   - Avoids direct keybinds to prevent plugin conflicts
--
-- ============================================================================

local keymap = vim.keymap

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================

--- Open or toggle terminal using toggleterm
local function toggle_terminal()
    require("toggleterm").toggle()
    vim.cmd("stopinsert")  -- Ensure terminal opens in normal mode
end

-- ============================================================================
-- SEARCH & FIND (FzfLua)
-- ============================================================================

keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find files" })
keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", { desc = "Live grep" })
keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Find buffers" })
keymap.set("n", "<leader>fh", "<cmd>FzfLua help_tags<cr>", { desc = "Help tags" })
keymap.set("n", "<leader>fs", "<cmd>FzfLua blines<cr>", { desc = "Search in buffer" })
keymap.set("n", "<leader>fc", "<cmd>FzfLua oldfiles<cr>", { desc = "Recent files" })

-- ============================================================================
-- NAVIGATE & NEO-TREE
-- ============================================================================

keymap.set("n", "<leader>nf", "<cmd>Neotree focus<cr>", { desc = "Focus Neo-tree" })

-- ============================================================================
-- TOGGLE VIEWS
-- ============================================================================

keymap.set("n", "<leader>tt", function() toggle_terminal() end, { desc = "Toggle terminal" })
keymap.set("n", "<leader>tm", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle markdown rendering" })
keymap.set("n", "<leader>ts", function()
    vim.wo.spell = not vim.wo.spell
    local status = vim.wo.spell and "enabled" or "disabled"
    print("Spell check " .. status)
end, { desc = "Toggle spell check" })
keymap.set("n", "<leader>tl", function()
    vim.wo.relativenumber = not vim.wo.relativenumber
    local status = vim.wo.relativenumber and "relative" or "absolute"
    print("Line numbers: " .. status)
end, { desc = "Toggle relative line numbers" })
keymap.set("n", "<leader>tc", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle Code Companion Chat" })
keymap.set("n", "<leader>tn", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neo-tree" })

-- ============================================================================
-- BUFFER & TAB NAVIGATION
-- ============================================================================

keymap.set("n", "<leader>]", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
keymap.set("n", "<leader>[", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
keymap.set("n", "<leader>bc", "<cmd>bdelete<cr>", { desc = "Close buffer" })
keymap.set("n", "<leader><leader>", "<cmd>FzfLua buffers<cr>", { desc = "Switch buffer" })

-- ============================================================================
-- WINDOW NAVIGATION & RESIZING
-- ============================================================================

-- Window navigation
keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Move to down window" })
keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Move to up window" })
keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Move to right window" })

-- Window resizing
keymap.set("n", "<leader>w+", "<cmd>resize +2<cr>", { desc = "Increase window height" })
keymap.set("n", "<leader>w-", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
keymap.set("n", "<leader>w<", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap.set("n", "<leader>w>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
