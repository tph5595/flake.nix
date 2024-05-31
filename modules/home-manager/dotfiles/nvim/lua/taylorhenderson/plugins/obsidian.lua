return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "family",
        path = "~/Family",
      },
      {
        name = "work",
        path = "~/Obsidian/Work",
      },
    },
  },
}
