## 安装

1.  克隆仓库

    ```bash
    git clone https://github.com/OleehyO/dotfiles.git ~/dotfiles
    ```
2.  安装依赖库（要先确保设置了网络代理，否则可能会安装失败）

    ```bash
    source ~/dotfiles/.config/zsh/install/install_all.zsh
    ```

    > 如果安装过程中有某些依赖错误，建议手动进行安装，可以参考[install/目录](./.config/zsh/install/)

3. 创建软链接

    ```bash
    ln -s ~/dotfiles/.zshrc ~/.zshrc
    ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
    ln -s ~/dotfiles/.condarc ~/.condarc

    ln -s ~/dotfiles/.config/ ~
    ```

    > 记得提前备份好之前的.zshrc, .tmux.conf, .condarc, .config/

## 实用函数

所有函数定义在 `.config/zsh/functions.zsh` 文件中。

| 函数 | 描述 |
| :--- | :--- |
| `set_proxy [addr]` | 设置终端代理，默认地址为 `http://127.0.0.1:64991`。 |
| `unset_proxy` | 取消终端代理。 |
| `show_proxy` | 显示当前的代理状态。 |
| `update` | 根据操作系统，自动更新所有包 (`brew upgrade` 或 `apt upgrade`)。 |
| `install <pkg>` | 根据操作系统，自动安装指定的包。 |
| `remove <pkg>` | 根据操作系统，自动卸载指定的包。 |
| `search <pkg>` | 根据操作系统，自动搜索指定的包。 |
| `extract <file>` | 智能解压文件 (支持 `.tar`, `.zip` 等格式)。 |
| `compress <name> <files...>` | 智能压缩文件 (支持 `.tar`, `.zip` 等格式)。 |
| `dirsize [dir]` | 显示当前或指定目录的大小。 |
| `backup <file>` | 快速备份文件，格式为 `filename.backup.YYYYMMDDHHMMSS`。 |
| `editzsh` | 使用默认编辑器打开 `.zshrc` 配置文件。 |
| `editaliases` | 使用默认编辑器打开别名配置文件。 |
| `editfunctions` | 使用默认编辑器打开函数配置文件。 |
| `reload` | 重新加载 Zsh 配置，等同于 `source ~/.zshrc`。 |

## 常用别名

常用的别名定义在 `.config/zsh/aliases.zsh` 文件中，你可以通过 `showaliases` 函数查看所有别名。

## MacOS 用户特别指南

为了获得最佳的视觉体验，macOS 用户建议进行以下配置。

* 安装iTerm2：从 [iTerm2 官网](https://iterm2.com/index.html) 下载并安装。

* 安装 Nerd Font 字体：推荐使用 [JetBrainsMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip)。

* 导入iTerm2的主题：本仓库提供了一个预设的 iTerm2 主题配置文件 `MacItemProfile.json`。

    1.  打开 iTerm2，进入 *Settings* -> *Profiles*。
    2.  点击左下方的 *Other Actions...* -> *Import JSON Profiles...*。
    3.  选择本仓库中的 `MacItemProfile.json` 文件。
    4.  导入后，再次点击 *Other Actions...* -> *Set as Default* 将其设为默认配置。

## VS Code / Cursor 集成终端设置

如果你使用 VS Code 的集成终端，请在 `settings.json` 中添加以下配置：

```json
{
  "terminal.integrated.fontFamily": "JetBrainsMono Nerd Font"
}
```

> 或"CMD" + ","然后搜索font
