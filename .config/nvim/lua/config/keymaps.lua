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
--   c = Copilot/Chat (AI assistant)
--   t = Toggle (features and views)
--   b = Buffer (bufferline navigation)
--   g = Go (window/panel layout with edgy)
--
-- Style:
--   - Leader-based maps: <leader>key for discoverable, less-frequent actions
--   - Direct keybinds: <C-key> for critical workflows (fastest access)
--   - Window toggle priority: Frequently used views get both leader and direct binds
--
-- ============================================================================

local keymap = vim.keymap
local api = vim.api

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================

--- Open or toggle terminal using toggleterm
local function toggle_terminal()
  require("toggleterm").toggle()
end

--- Open all three: Neo-tree, CopilotChat, and Terminal
local function open_vscode_layout()
  vim.cmd("Neotree toggle")
  vim.cmd("CopilotChatToggle")
  toggle_terminal()
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

keymap.set("n", "<leader>nt", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neo-tree" })
keymap.set("n", "<C-n>", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neo-tree (direct)" })
keymap.set("n", "<leader>nf", "<cmd>Neotree focus<cr>", { desc = "Focus Neo-tree" })

-- ============================================================================
-- AI & COPILOT
-- ============================================================================

keymap.set("n", "<leader>cc", "<cmd>CopilotChat<cr>", { desc = "Open CopilotChat" })
keymap.set("n", "<C-]>", "<cmd>CopilotChatToggle<cr>", { desc = "Open CopilotChat (direct)" })
keymap.set("v", "<leader>cx", "<cmd>CopilotChatVisualSelected<cr>", { desc = "CopilotChat with selection" })
keymap.set("n", "<leader>cb", "<cmd>CopilotChatBuffer<cr>", { desc = "CopilotChat with buffer" })

-- ============================================================================
-- TOGGLE VIEWS
-- ============================================================================

keymap.set("n", "<leader>tc", "<cmd>CopilotChatToggle<cr>", { desc = "Toggle CopilotChat" })
keymap.set("n", "<leader>tt", function() toggle_terminal() end, { desc = "Toggle terminal" })
keymap.set("n", "<C-\\>", function() toggle_terminal() end, { desc = "Toggle terminal (direct)" })
keymap.set("n", "<leader>to", function() open_vscode_layout() end, { desc = "Open VSCode layout (all three)" })
keymap.set("n", "<leader>tm", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle markdown rendering" })
keymap.set("n", "<leader>ts", function()
  vim.wo.spell = not vim.wo.spell
  local status = vim.wo.spell and "enabled" or "disabled"
  print("Spell check " .. status)
end, { desc = "Toggle spell check" })
keymap.set("n", "<leader>tn", function()
  vim.wo.relativenumber = not vim.wo.relativenumber
  local status = vim.wo.relativenumber and "relative" or "absolute"
  print("Line numbers: " .. status)
end, { desc = "Toggle relative line numbers" })

-- ============================================================================
-- BUFFER & TAB NAVIGATION
-- ============================================================================

keymap.set("n", "<leader>bn", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
keymap.set("n", "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
keymap.set("n", "<leader>bc", "<cmd>bdelete<cr>", { desc = "Close buffer" })
keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
keymap.set("n", "<C-PageDown>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer (VSCode style)" })
keymap.set("n", "<C-PageUp>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer (VSCode style)" })

-- ============================================================================
-- EDITOR UTILITIES
-- ============================================================================

-- Buffer switching
keymap.set("n", "<leader><leader>", "<cmd>FzfLua buffers<cr>", { desc = "Switch buffer" })

-- Window navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to down window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to up window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Window resizing
keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
