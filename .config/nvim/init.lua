-- ============================================================
-- 1. 基础设置 (Options)
-- ============================================================
vim.opt.number = true           -- 显示行号
vim.opt.relativenumber = true   -- 开启相对行号
vim.opt.cursorline = true       -- 高亮当前行
vim.opt.termguicolors = true    -- 开启真彩色支持
vim.opt.mouse = ""              -- 禁止鼠标操作

-- 关联系统剪切板
vim.opt.clipboard = "unnamedplus"

-- ============================================================
-- 2. 插件管理器引导 (Lazy.nvim Bootstrap)
-- ============================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================
-- 3. 插件配置 (Plugins)
-- ============================================================
require("lazy").setup({
  -- 1. 主题：Catppuccin (Latte)
  { 
    "catppuccin/nvim", 
    name = "catppuccin", 
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin-latte"
    end 
  },

  -- 2. 柔性滚动：neoscroll
  { 
    "karb94/neoscroll.nvim", 
    config = function()
      require('neoscroll').setup({
        duration_multiplier = 0.2, -- 滚动速度系数 (越小越快)
        easing_function = "quadratic", -- 加速曲线
      })
    end 
  },

  -- 3. 包裹修改：nvim-surround
  {
    "kylechui/nvim-surround",
    version = "*", 
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },

  -- 4. 远程剪切板：OSC 52
  {
    "ojroques/nvim-osc52",
    config = function()
      local function copy(lines, _)
        require("osc52").copy(table.concat(lines, "\n"))
      end

      -- 为了避免本地不支持粘贴时的报错，返回空
      local function paste()
        return {vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("")}
      end

      vim.g.clipboard = {
        name = 'osc52',
        copy = { ['+'] = copy, ['*'] = copy },
        paste = { ['+'] = paste, ['*'] = paste },
      }
    end
  },
})