return {
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    dependencies = {
      "leoluz/nvim-dap-go",
      "mfussenegger/nvim-dap-python",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

      -- Setup Mason first
      require("mason").setup()
      require("mason-nvim-dap").setup {
        automatic_installation = true,
        ensure_installed = { "debugpy", "delve" }, -- Actual debug adapters
      }

      -- Setup DAP UI and extensions
      dapui.setup()
      require("dap-go").setup()
      require("dap-python").setup "python" -- Use system Python by default
      require("nvim-dap-virtual-text").setup({})

      -- Breakpoint signs
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticSignWarn" })

      -- Auto-open UI
      dap.listeners.after.event_initialized["dapui_config"] = dapui.open
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close

      -- Keymaps using Lua functions
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, opts)
      vim.keymap.set("n", "<leader>dc", dap.continue, opts)
      vim.keymap.set("n", "<leader>di", dap.step_into, opts)
      vim.keymap.set("n", "<leader>do", dap.step_over, opts)
      vim.keymap.set("n", "<leader>du", dapui.toggle, opts)
    end,
  },
  { "rcarriga/nvim-dap-ui" },
  { "leoluz/nvim-dap-go" },
  { "theHamsta/nvim-dap-virtual-text", dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" } },
  { "mfussenegger/nvim-dap-python" },
}
