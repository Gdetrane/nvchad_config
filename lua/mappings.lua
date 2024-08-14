require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- local M = {}
--
-- M.dap = {
--   plugin = true,
--   n = {
--     ["<leader>db"] = {"<cmd> DapToggleBreakpoint <CR>"}
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
-- return M

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
