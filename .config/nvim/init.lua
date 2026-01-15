-- 1. 基础设置
vim.opt.number = true           -- 显示行号
vim.opt.relativenumber = true   -- 开启相对行号
vim.opt.cursorline = true       -- 高亮当前行 (CursorLine)
vim.opt.termguicolors = true    -- 开启真彩色支持
vim.opt.mouse = ""              -- 禁止鼠标操作

-- 将 Neovim 的默认寄存器与系统剪切板（+ 寄存器）关联
vim.opt.clipboard = "unnamedplus"

-- 2. 安装插件管理器 (lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- 3. 安装并配置插件
require("lazy").setup({
  -- 【浅色主题】：Catppuccin (Latte)
  { 
    "catppuccin/nvim", 
    name = "catppuccin", 
    priority = 1000,
    config = function()
      vim.cmd.colorscheme "catppuccin-latte"
    end 
  },

  -- 【柔性滚动】：neoscroll (加速版)
  { 
    "karb94/neoscroll.nvim", 
    config = function()
      require('neoscroll').setup({
        -- 减少动画耗时，系数越小滚动越快 (默认是 1.0)
        duration_multiplier = 0.2, 
        -- 更改加速曲线，'quadratic' 比默认的 'linear' 感觉更灵敏
        easing_function = "quadratic", 
      })
    end 
  },

  -- 【Vim Surround】：nvim-surround
  {
    "kylechui/nvim-surround",
    version = "*", 
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },

  -- 远程剪切板支持 (OSC 52)
  {
    "ojroques/nvim-osc52",
    config = function()
      -- 定义复制函数，使用 OSC 52 协议发送到本地终端
      local function copy(lines, _)
        require("osc52").copy(table.concat(lines, "\n"))
      end

      -- 定义粘贴函数 (注意：OSC 52 通常不支持从本地读取，为了避免报错，这里返回空)
      -- 在 VS Code 中粘贴建议直接用 Ctrl+V / Cmd+V
      local function paste()
        return {vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("")}
      end

      -- 将 Neovim 的剪切板操作重定向到 OSC 52
      vim.g.clipboard = {
        name = 'osc52',
        copy = { ['+'] = copy, ['*'] = copy },
        paste = { ['+'] = paste, ['*'] = paste },
      }
    end
},
})