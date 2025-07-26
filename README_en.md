[中文](README.md) | English

# Dotfiles Configuration

Target: Painlessly set up familiar development environments across various development machines for a consistent development experience.

## Showcase

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

## Installation

1. Install zsh shell

2. Clone the repository

    ```bash
    git clone https://github.com/OleehyO/dotfiles.git ~/dotfiles
    ```

3. Install dependencies (ensure network connectivity)

    ```bash
    zsh  # Enter zsh shell

    source ~/dotfiles/.config/zsh/install/install_all.zsh
    ```

    > If there are dependency errors during installation, it's recommended to install manually. You can refer to the [install/ directory](./.config/zsh/install/)

4. Create symbolic links & copy files
    > Remember to backup your previous .zshrc, .tmux.conf, .condarc, .config/ files

    ```bash
    cp ~/dotfiles/.zshrc ~/.zshrc
    cp ~/dotfiles/.tmux.conf ~/.tmux.conf
    cp ~/dotfiles/.condarc ~/.condarc

    cp -r ~/dotfiles/.claude ~/.claude
    cp -r ~/dotfiles/.cursor ~/.cursor

    cp -r ~/dotfiles/.config/* ~/.config/
    cp -r ~/dotfiles/mcphub ~ 
    ```

5. Set zsh as the default shell

    > The default shell in VS Code on Linux is usually bash. You need to press `cmd` + `,`, search for terminal.integrated.defaultProfile.linux, and set it to zsh

6. Reload terminal

## macOS User Guide

For the best visual experience, macOS users are recommended to make the following configurations.

* Install iTerm2: Download and install from [iTerm2 official website](https://iterm2.com/index.html).

* Install Nerd Font: Recommended to use [JetBrainsMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip).

* Import iTerm2 theme: This repository provides a preset iTerm2 theme configuration file `MacItemProfile.json`.

    1. Open iTerm2, go to *Settings* -> *Profiles*.
    2. Click *Other Actions...* -> *Import JSON Profiles...* in the bottom left.
    3. Select the `MacItemProfile.json` file from this repository.
    4. After importing, click *Other Actions...* -> *Set as Default* again to set it as the default configuration.

## VS Code / Cursor Integrated Terminal Settings

If you use VS Code's integrated terminal, please add the following configuration to `settings.json`:

```json
{
  "terminal.integrated.fontFamily": "JetBrainsMono Nerd Font"
}
```

> Or press "CMD" + "," and then search for font

## Utility Functions

All functions are defined in the `.config/zsh/functions.zsh` file.

| Function | Description |
| :--- | :--- |
| `set_proxy [addr]` | Set terminal proxy, default address is `http://127.0.0.1:7890`. |
| `unset_proxy` | Unset terminal proxy. |
| `show_proxy` | Show current proxy status. |
| `update` | Automatically update all packages based on OS (`brew upgrade` or `apt upgrade`). |
| `install <pkg>` | Automatically install specified package based on OS. |
| `remove <pkg>` | Automatically uninstall specified package based on OS. |
| `search <pkg>` | Automatically search for specified package based on OS. |
| `extract <file>` | Smart file extraction (supports `.tar`, `.zip` and other formats). |
| `compress <name> <files...>` | Smart file compression (supports `.tar`, `.zip` and other formats). |
| `dirsize [dir]` | Show the size of current or specified directory. |
| `backup <file>` | Quick file backup, format: `filename.backup.YYYYMMDDHHMMSS`. |
| `editzsh` | Open `.zshrc` configuration file with default editor. |
| `editaliases` | Open aliases configuration file with default editor. |
| `editfunctions` | Open functions configuration file with default editor. |
| `reload` | Reload Zsh configuration, equivalent to `source ~/.zshrc`. |
| `klaude` | Use Claude Code + Moonshot API. |
| `qlaude` | Use Claude Code + QWEN API. |

## Claude Code Commands

The `.claude/commands/` directory contains custom commands for Claude Code:

- `/code-review` - Code review guidelines providing systematic code review checklists and comment templates (uses `staged-code-reviewer` sub agent)
- `/make-commit` - Git commit message conventions defining standardized commit message formats and tag systems (uses `commit-crafter` sub agent)

These commands will be available after installation via the `~/.claude` directory.

## Common Aliases

Common aliases are defined in the `.config/zsh/aliases.zsh` file. You can view all aliases using the `showaliases` function.

## [Optional] MCP Server

- Install docker

  - MacOS: [Docker Desktop on Mac](https://docs.docker.com/desktop/setup/install/mac-install/)

  - Ubuntu:
    ```bash
    $ echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    $ sudo apt update
    $ sudo apt install -y docker-ce docker-ce-cli containerd.io

    # Start docker service
    $ sudo systemctl start docker
    $ sudo systemctl enable docker
    ```

- Start mcphub service

  ```bash
  docker run -p 3000:3000 -v ~/mcphub/mcp_settings.json:/app/mcp_settings.json -v ~/mcphub/data:/app/data samanhappy/mcphub

  # Initial account: username admin, password admin123
  ```

- Pre-configured MCP servers in `mcp_settings.json` that require token configuration:

  - [lark-mcp](https://www.volcengine.com/mcp-marketplace/detail?name=lark-mcp): Lark/Feishu, some permissions are not enabled by default, please refer to the documentation.

  - [amap](https://bailian.console.aliyun.com/?spm=5176.29619931.J_AHgvE-XDhTWrtotIBlDQQ.1.74cd521cSWBqUb&tab=mcp#/mcp-market/detail/amap-maps): Amap (Gaode Map)

### Registering Deployed MCP Servers in Claude Code

- reference: [[mcphub ref](https://github.com/samanhappy/mcphub/blob/main/README.zh.md#%E6%94%AF%E6%8C%81%E6%B5%81%E5%BC%8F%E7%9A%84-http-%E7%AB%AF%E7%82%B9)] [[Claude Code ref](https://docs.anthropic.com/en/docs/claude-code/mcp)]

  ```bash
  # Add all MCP servers deployed in mcphub
  claude mcp add --transport http http-server http://localhost:3000/mcp

  # Or add a specific MCP service registered in mcphub
  claude mcp add --transport http http-server http://localhost:3000/mcp/{server}

  # Or add a specific group
  claude mcp add --transport http http-server http://localhost:3000/mcp/{group}
  ```

* Other operations

  ```bash
  # List all configured servers (you can check if the connection is working)
  claude mcp list

  # Get detailed information about a server
  claude mcp get my-server

  # Remove a server
  claude mcp remove my-server
  ```

  > If you encounter network connection issues, check if network proxy is enabled or if the proxy is working properly

### Using MCP Server in Cursor

- [ref](https://docs.cursor.com/context/mcp#model-context-protocol-mcp): Supports direct deployment and use within Cursor; or using an already launched MCP server or remote MCP server

- Create `.cursor/mcp.json` in the current project or create `~/.cursor/mcp.json` in the user directory

- Configure `mcp.json`

  - Local MCP server hosted by Cursor

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