return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
    },
    cmd = "Neogit",
    config = function()
      require("neogit").setup {}
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
    },
  },

  {
    "smoka7/hop.nvim",
    version = "*",
    opts = {
      keys = "etovxqpdygfblzhckisuran",
    },
  },

  {
    "cuducos/yaml.nvim",
    ft = { "yaml" }, -- optional
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
    },
  },

  -- DEBUGGERS ---------------
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "folke/neodev.nvim" },
    keys = {
      {
        "<leader>ds",
        function()
          require("dapui").toggle()
        end,
        silent = true,
      },
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  {
    "mfussenegger/nvim-dap",
    config = function()
      vim.keymap.set("n", "<Leader>db", "<cmd>DapToggleBreakpoint<CR>")
      vim.keymap.set("n", "<Leader>dr", "<cmd>DapContinue<CR>")
    end,
  },

  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
    end,
  },

  -- {
  --   "jay-babu/mason-nvim-dap.nvim",
  --   dependencies = {
  --     "williambonan/mason.nvim",
  --     "mfussenegger/nvim-dap",
  --   },
  -- },

  {
    "folke/neodev.nvim",
    dependencies = { "rcarriga/nvim-dap-ui" },
    config = function()
      require("neodev").setup {
        library = { plugins = { "nvim-dap-ui" }, types = true },
      }
    end,
  },

  ----------------------------
  ---
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    cmd = { "RenderMarkdown" },
    opts = {},
    -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
    config = function()
      local render_markdown = require "render-markdown"
      render_markdown.setup {}
      vim.api.nvim_set_keymap("n", "<leader>mr", ":RenderMarkdown toggle<CR>", { noremap = true, silent = true })
    end,
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      -- "antoinedemac/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },
  config = function()
    require("neotest").setup {
      adapters = {
        require "neotest-python" {
          dap = { justMyCode = false },
        },
        require "neotest-plenary",
        require "neotest-vim-test" {
          ignore_file_types = { "python", "vim", "lua" },
        },
      },
    }
  end,
}
