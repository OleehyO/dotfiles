return {
    -- add gruvbox
    { "ellisonleao/gruvbox.nvim" },
    {
        "folke/tokyonight.nvim",
        lazy = true,
        opts = { style = "day" },
    },
  
    -- Configure LazyVim to load gruvbox
    {
      "LazyVim/LazyVim",
      opts = {
        -- colorscheme = "gruvbox",
        colorscheme = "tokyonight",
      },
    }
  }