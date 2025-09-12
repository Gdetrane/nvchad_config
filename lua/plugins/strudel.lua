return {
  "gruvw/strudel.nvim",
  build = "npm install",
  lazy = false,
  config = function()
    require("strudel").setup()
  end,
}
