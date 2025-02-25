require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

local M = {}

M.general = {
  n = {
    ["<C-h>"] = { "<cmd> TmuxNavigateLeft<CR>", "window left" },
    ["<C-l>"] = { "<cmd> TmuxNavigateLeft<CR>", "window right" },
    ["<C-j>"] = { "<cmd> TmuxNavigateLeft<CR>", "window down" },
    ["<C-k>"] = { "<cmd> TmuxNavigateLeft<CR>", "window up" },
  }
}

-- M.dap = {
--   plugin = true,
--   n = {
--     ["<leader>db"] = {"<cmd> DapToggleBreakpoint <CR>"},
--     ["<leader>dus"] = {
--       function ()
--         local widgets = require('dap.ui.widgets');
--         local sidebar = widgets.sidebar(widgets.scopes);
--         sidebar.open()
--       end,
--       "Open debugging sidebar"
--     }
--   }
-- }
--
-- M.dap_python = {
--   plugin = true,
--   n = {
--     ["<leader>dpr"] = {
--       function ()
--         require("dap-python").test_method()
--       end
--     }
--   }
-- }
--
return M

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
