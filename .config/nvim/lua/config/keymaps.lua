-- --------------- Keymap Conventions & Mnemonics ----------------
-- 
-- Leader Key: Space (<leader>)
-- Local Leader: Backslash (<localleader>)
--
-- Mnemonic Organization:
--   a = AI tools (Copilot, Sidekick, OpenCode)
--   b = Buffer navigation (next/prev/switch)
--   f = Find/Search (FzfLua commands)
--   g = Git (Diffview toggle)
--   n = Navigate (Neo-tree file explorer)
--   s = Schema selection (LSP schema companion)
--   t = Toggle terminal (toggleterm)
--   u = UI toggles (markdown, spell check, line numbers, diagnostics)
--   w = Window navigation & resizing (hjkl + Alt for resize)
--
-- Additional Keybinds:
--   Ctrl+hjkl = Window navigation (vim-tmux-navigator style)
--   Alt+= - [ ] = Window resizing
--
-- Style:
--   - Organized by function for easier discovery and customization
--   - Mnemonics are single letters following <leader>
--   - Which-key provides visual grouping in menus
--
local keymap = vim.keymap
local wk = require("which-key")
wk.add({
    { "<leader>a", group = "AI" },
    { "<leader>b", group = "Buffer" },
    { "<leader>f", group = "Find" },
    { "<leader>n", group = "File Explorer", icon = "󰝰" },
    { "<leader>s", group = "Select Schema", icon = "󰦨"},
    { "<leader>u", group = "UI" },
    { "<leader>w", group = "Window" },
})

-- --------------- Helper Functions ----------------

--- Toggle Diffview with proper initialization
local function toggle_diffview()
    -- Get the view collection from diffview's internal state
    local lib = require("diffview.lib")
    local view = lib.get_current_view()

    if view then
        -- Diffview is open, so close it
        vim.cmd("DiffviewClose")
    else
        -- Diffview is closed, so open it
        vim.cmd("DiffviewOpen")
    end
end

-- --------------- Search & Find (FzfLua) ----------------

keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find files" })
keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", { desc = "Live grep" })
keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Find buffers" })
keymap.set("n", "<leader>fh", "<cmd>FzfLua help_tags<cr>", { desc = "Help tags" })
keymap.set("n", "<leader>fs", "<cmd>FzfLua blines<cr>", { desc = "Search in buffer" })
keymap.set("n", "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>", { desc = "Show diagnostics in buffer" })
keymap.set("n", "<leader>fD", "<cmd>FzfLua diagnostics_workspace<cr>", { desc = "Show diagnostics in workspace" })
keymap.set("n", "<leader>fc", "<cmd>FzfLua oldfiles<cr>", { desc = "Recent files" })

-- --------------- Navigate & Neo-Tree ----------------

keymap.set("n", "<leader>nf", "<cmd>Neotree focus<cr>", { desc = "Focus File Explorer" })
keymap.set("n", "<leader>nt", "<cmd>Neotree toggle<cr>", { desc = "Toggle File Explorer" })

-- --------------- UI ----------------
keymap.set("n", "<leader>um", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle markdown rendering" })
keymap.set("n", "<leader>us", function()
    vim.wo.spell = not vim.wo.spell
    local status = vim.wo.spell and "enabled" or "disabled"
    print("Spell check " .. status)
end, { desc = "Toggle spell check" })
keymap.set("n", "<leader>ul", function()
    vim.wo.relativenumber = not vim.wo.relativenumber
    local status = vim.wo.relativenumber and "relative" or "absolute"
    print("Line numbers: " .. status)
end, { desc = "Toggle relative line numbers" })
keymap.set("n", "<leader>ud", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, { desc = "Toggle diagnostics" })

-- --------------- Terminal ----------------

keymap.set("n", "<leader>t", function() require("toggleterm").toggle() end, { desc = "Toggle terminal" })

-- --------------- Schema ----------------

vim.keymap.set("n", "<leader>s", function()
    require("schema-companion").select_schema()
end, { desc = "Select schema" })

-- --------------- Git ----------------

keymap.set("n", "<leader>g", toggle_diffview,  { desc = "Toggle Diffview" })

-- --------------- AI ----------------

keymap.set("n", "<leader>ac", function() require("sidekick.cli").toggle({ name = "copilot", focus = true}) end, { desc = "Toggle Copilot CLI" })
keymap.set("n", "<leader>ao", function() require("sidekick.cli").toggle({ name = "opencode", focus = true}) end, { desc = "Toggle OpenCode" })
keymap.set("n", "<leader>ap", "<cmd>Sidekick cli prompt<cr>", { desc = "Select prompt" })
keymap.set("n", "<leader>ay", function()
    if not require("sidekick").nes_jump_or_apply() then
        return "<Tab>"
    end
end, { expr = true, silent = true, desc = "Jump to/apply next edit" })
keymap.set("n", "<leader>au", "<cmd>Sidekick nes update<cr>", { desc = "Update next edit suggestions" })

-- --------------- Buffer & Tab Navigation ----------------

keymap.set("n", "<leader>]", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
keymap.set("n", "<leader>[", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
keymap.set("n", "<leader><leader>", "<cmd>FzfLua buffers<cr>", { desc = "Switch buffer" })

-- --------------- Window Navigation & Resizing ----------------

-- Window navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to down window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to up window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Window resizing
keymap.set("n", "<M-=>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
keymap.set("n", "<M-->", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
keymap.set("n", "<M-[>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap.set("n", "<M-]>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
