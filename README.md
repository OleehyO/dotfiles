中文 | [English](README_en.md)

# Dotfiles Configuration

本仓库的目标：能在各种开发机（or 本地机）上无痛地setup起自己熟悉的开发环境，从而获得一致的开发体验

## 展示

<div align="center">
  <table style="border: none;">
    <tr>
      <td style="border: none;"><img src="assets/demo1.png" alt="Demo 1" width="400"/></td>
      <td style="border: none;"><img src="assets/demo2.png" alt="Demo 2" width="400"/></td>
    </tr>
    <tr>
      <td align="center" style="border: none;"><em>Screenshot</em></td>
      <td align="center" style="border: none;"><em>Vim Style</em></td>
    </tr>
  </table>
</div>

## 安装

1. 安装zsh shell

2. 克隆仓库

    ```bash
    git clone https://github.com/OleehyO/dotfiles.git ~/dotfiles
    ```

3. 安装依赖库（确保网络通畅）

    ```bash
    zsh  # 进入zsh shell

    source ~/dotfiles/.config/zsh/install/install_all.zsh
    ```

    > 如果安装过程中有某些依赖错误，建议手动进行安装，可以参考[install/目录](./.config/zsh/install/)

4. 创建软链接 & 拷贝文件
    > 记得提前备份好之前的.zshrc, .tmux.conf, .condarc, .config/

    ```bash
    cp ~/dotfiles/.zshrc ~/.zshrc
    cp ~/dotfiles/.tmux.conf ~/.tmux.conf
    cp ~/dotfiles/.condarc ~/.condarc

    cp -r ~/dotfiles/.claude ~/.claude
    cp -r ~/dotfiles/.cursor ~/.cursor

    cp -r ~/dotfiles/.config/* ~/.config/
    cp -r ~/dotfiles/mcphub ~ 
    ```

5. 把zsh设置为默认shell

    > vscode中linux上的默认shell通常为bash，需要`cmd` + `,` 搜索terminal.integrated.defaultProfile.linux，设置为zsh

6. 重新加载终端

## macOS 用户特别指南

为了获得最佳的视觉体验，macOS 用户建议进行以下配置。

* 安装iTerm2：从 [iTerm2 官网](https://iterm2.com/index.html) 下载并安装。

* 安装 Nerd Font 字体：推荐使用 [JetBrainsMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip)。

* 导入iTerm2的主题：本仓库提供了一个预设的 iTerm2 主题配置文件 `MacItemProfile.json`。

    1. 打开 iTerm2，进入 *Settings* -> *Profiles*。
    2. 点击左下方的 *Other Actions...* -> *Import JSON Profiles...*。
    3. 选择本仓库中的 `MacItemProfile.json` 文件。
    4. 导入后，再次点击 *Other Actions...* -> *Set as Default* 将其设为默认配置。

## VS Code / Cursor 集成终端设置

如果你使用VS Code的集成终端，请在 `settings.json` 中添加以下配置：

```json
{
  "terminal.integrated.fontFamily": "JetBrainsMono Nerd Font"
}
```

> 或"CMD" + ","然后搜索font

## 实用函数

所有函数定义在 `.config/zsh/functions.zsh` 文件中。

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
| `dirsize [dir]` | 显示当前或指定目录的大小。 |
| `backup <file>` | 快速备份文件，格式为 `filename.backup.YYYYMMDDHHMMSS`。 |
| `editzsh` | 使用默认编辑器打开 `.zshrc` 配置文件。 |
| `editaliases` | 使用默认编辑器打开别名配置文件。 |
| `editfunctions` | 使用默认编辑器打开函数配置文件。 |
| `reload` | 重新加载 Zsh 配置，等同于 `source ~/.zshrc`。 |
| `klaude` | 使用Claude Code + Moonshot API。 |
| `qlaude` | 使用Claude Code + QWEN API。 |

## Claude Code 命令

`.claude/commands/` 目录包含了 Claude Code 的自定义命令：

- `/code-review` - 代码审查指南，提供系统化的代码审查检查清单和评论模板（使用`staged-code-reviewer` sub agent）
- `/make-commit` - Git提交信息规范，定义了标准化的提交消息格式和标签系统（使用`commit-crafter` sub agent）

这些命令在安装时会通过软链接 `~/.claude` 自动可用。

## 常用别名

常用的别名定义在 `.config/zsh/aliases.zsh` 文件中，你可以通过 `showaliases` 函数查看所有别名。

## [Optional] MCP Server

- 安装docker

  - MacOS: [Docker Desktop on Mac](https://docs.docker.com/desktop/setup/install/mac-install/)

  - Ubuntu:
    ```bash
    $ echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    $ sudo apt update
    $ sudo apt install -y docker-ce docker-ce-cli containerd.io

    # 启动docker服务
    $ sudo systemctl start docker
    $ sudo systemctl enable docker
    ```

- 启动mcphub服务

  ```bash
  docker run -p 3000:3000 -v ~/mcphub/mcp_settings.json:/app/mcp_settings.json -v ~/mcphub/data:/app/data samanhappy/mcphub

  # 初始账户: 账号admin，密码为admin123
  ```

- `mcp_settings.json`中预置的且需要配置token的mcp server：

  - [lark-mcp](https://www.volcengine.com/mcp-marketplace/detail?name=lark-mcp)：飞书，有些权限默认启动设置下不会开启，可以参考具体文档。

  - [amap](https://bailian.console.aliyun.com/?spm=5176.29619931.J_AHgvE-XDhTWrtotIBlDQQ.1.74cd521cSWBqUb&tab=mcp#/mcp-market/detail/amap-maps)：高德地图

### 在Claude Code中注册已经部署的MCP Server

- reference： [[mcphub ref](https://github.com/samanhappy/mcphub/blob/main/README.zh.md#%E6%94%AF%E6%8C%81%E6%B5%81%E5%BC%8F%E7%9A%84-http-%E7%AB%AF%E7%82%B9)] [[Claude Code ref](https://docs.anthropic.com/en/docs/claude-code/mcp)]

  ```bash
  # 添加所有mcphub中部署的mcp server
  claude mcp add --transport http http-server http://localhost:3000/mcp

  # 或者只添加mcphub中的某个已经注册的mcp服务
  claude mcp add --transport http http-server http://localhost:3000/mcp/{server}

  # 或者只添加某个group
  claude mcp add --transport http http-server http://localhost:3000/mcp/{group}
  ```

* 其他操作

  ```bash
  # 列出所有已配置的server（可以检查连接是否正常）
  claude mcp list

  # 获取某个server的详细信息
  claude mcp get my-server

  # 删除某个server
  claude mcp remove my-server
  ```

  > 如果发现网络连接存在问题，建议检查是否开启了网络代理 or 代理是否正常


### 在Cursor中使用MCP Server

- [ref](https://docs.cursor.com/context/mcp#model-context-protocol-mcp)：支持直接在cursor内部部署并使用；或者使用已经launch起来的mcp server或是remote mcp server

- 在当前项目下创建`.cursor/mcp.json`或者在用户目录下创建`~/.cursor/mcp.json`

- 配置`mcp.json`

  - 本地mcp server，由cursor来host

    ```json
    {
      "mcpServers": {
        "server-name": {
          "command": "npx",
          "args": ["-y", "mcp-server"],
          "env": {
            "API_KEY": "value"
          }
        }
      }
    }
    ```
  
  - Remote server

    ```json
    {
      "mcpServers": {
        "server-name": {
          "url": "http://localhost:3000/mcp",
          "headers": {
            "API_KEY": "value"
          }
        }
      }
    }
    ```