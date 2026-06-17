# Dotfiles Configuration

## 安装

1. 安装zsh shell

2. 克隆仓库

    ```bash
    git clone https://github.com/OleehyO/dotfiles.git ~/dotfiles
    ```

3. 安装依赖库（确保网络通畅）

    ```bash
    zsh  # 进入zsh shell

    source ~/dotfiles/zsh/install/install_all.zsh
    ```

    > 如果安装过程中有某些依赖错误，建议手动进行安装，可以参考[install/目录](./zsh/install/)

4. 创建软链接 & 拷贝文件
    > 记得提前备份好之前的 `.zshrc`, `.tmux.conf`, `.condarc`, `.config/nvim`, `.aws/config` 等配置。

    ```bash
    rm -f ~/.zshrc ~/.bashrc ~/.tmux.conf ~/.condarc
    cp ~/dotfiles/.zshrc ~
    cp ~/dotfiles/.bashrc ~
    ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
    ln -s ~/dotfiles/.condarc ~/.condarc

    mkdir -p ~/.config
    rm -rf ~/.config/nvim
    ln -s ~/dotfiles/.config/nvim ~/.config/nvim

    sh ~/dotfiles/.config.private/setup.sh
    ```
    <!-- rm "~/Library/Application Support/Cursor/User/keybindings.json" && ln -s ~/dotfiles/cursor/keybindings.json "~/Library/Application Support/Cursor/User"

    rm "~/Library/Application Support/Cursor/User/settings.json" && ln -s ~/dotfiles/cursor/settings.json "~/Library/Application Support/Cursor/User" -->

5. 重新加载终端
6. 进入tmux，<`ctrl`+`a`> + `I`，下载tmux插件

## VS Code / Cursor 集成终端设置

安装 Nerd Font 字体：推荐使用 [JetBrainsMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip)。

如果你使用VS Code的集成终端，请在 `settings.json` 中添加以下配置：

```json
{
  "terminal.integrated.fontFamily": "JetBrainsMono Nerd Font"
}
```

> 或"CMD" + ","然后搜索font

## 实用函数

所有函数定义在 `zsh/functions.zsh` 文件中。

| 函数 | 描述 |
| :--- | :--- |
| `set_proxy [addr]` | 设置终端代理，默认地址为 `http://127.0.0.1:7890`。 |
| `unset_proxy` | 取消终端代理。 |
| `show_proxy` | 显示当前的代理状态。 |
| `update` | 根据操作系统，自动更新所有包 (`brew upgrade` 或 `apt upgrade`)。 |
| `install <pkg>` | 根据操作系统，自动安装指定的包。 |
| `remove <pkg>` | 根据操作系统，自动卸载指定的包。 |
| `search <pkg>` | 根据操作系统，自动搜索指定的包。 |
| `extract <file>` | 智能解压文件 (支持 `.tar`, `.zip` 等格式)。 |
| `compress <name> <files...>` | 智能压缩文件 (支持 `.tar`, `.zip` 等格式)。 |
| `backup <file>` | 快速备份文件，格式为 `filename.backup.YYYYMMDDHHMMSS`。 |
| `reload` | 重新加载 Zsh 配置，等同于 `source ~/.zshrc`。 |

## 常用别名

常用的别名定义在 `zsh/aliases.zsh` 文件中
