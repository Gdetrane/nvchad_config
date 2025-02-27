return {
  { "nvim-neotest/neotest-plenary" },
  { "nvim-neotest/neotest-python" },
  { "fredrikaverpil/neotest-golang" },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        "neotest-plenary",
        ["neotest-golang"] = {
          go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
          dap_go_enabled = true,
        },
        ["neotest-python"] = {
          dap = { justMyCode = false },
          -- Command line arguments for runner
          -- Can also be a function to return dynamic values
          args = { "--log-level", "DEBUG" },
          -- Runner to use. Will use pytest if available by default.
          -- Can be a function to return dynamic value.
          runner = "pytest",
          -- Custom python path for the runner.
          -- Can be a string or a list of strings.
          -- Can also be a function to return dynamic value.
          -- If not provided, the path will be inferred by checking for
          -- virtual envs in the local directory and for Pipenev/Poetry configs
          python = os.getenv("PYTHONPATH"),
          -- Returns if a given file path is a test file.
          -- NB: This function is called a lot so don't perform any heavy tasks within it.
          -- is_test_file = function(file_path)
          --   ...
          -- end,
          -- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
          -- instances for files containing a parametrize mark (default: false)
          pytest_discover_instances = true,
        },
      },
      keys = {
        { "<leader>t", "", desc = "+test" },
        {
          "<leader>tt",
          function()
            require("neotest").run.run(vim.fn.expand "%")
          end,
          desc = "Run File (Neotest)",
        },
        {
          "<leader>tT",
          function()
            require("neotest").run.run(vim.uv.cwd())
          end,
          desc = "Run All Test Files (Neotest)",
        },
        {
          "<leader>tr",
          function()
            require("neotest").run.run()
          end,
          desc = "Run Nearest (Neotest)",
        },
        {
          "<leader>tl",
          function()
            require("neotest").run.run_last()
          end,
          desc = "Run Last (Neotest)",
        },
        {
          "<leader>ts",
          function()
            require("neotest").summary.toggle()
          end,
          desc = "Toggle Summary (Neotest)",
        },
        {
          "<leader>to",
          function()
            require("neotest").output.open { enter = true, auto_close = true }
          end,
          desc = "Show Output (Neotest)",
        },
        {
          "<leader>tO",
          function()
            require("neotest").output_panel.toggle()
          end,
          desc = "Toggle Output Panel (Neotest)",
        },
        {
          "<leader>tS",
          function()
            require("neotest").run.stop()
          end,
          desc = "Stop (Neotest)",
        },
        {
          "<leader>tw",
          function()
            require("neotest").watch.toggle(vim.fn.expand "%")
          end,
          desc = "Toggle Watch (Neotest)",
        },
      },
    },
  },
}
