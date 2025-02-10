# ~/.config/fish/config.fish
set fish_greeting ""
set -gx PATH /Applications/PyCharm.app/Contents/MacOS $PATH
set -gx PATH /Applications/CLion.app/Contents/MacOS $PATH
set -gx TLDR_AUTO_UPDATE_DISABLED 1
set -gx HOMEBREW_NO_AUTO_UPDATE 1
set -gx HOMEBREW_BOTTLE_DOMAIN https://mirrors.aliyun.com/homebrew/homebrew-bottles

# 配置clash代理，使其它应用程序也能走代理流量
#+记得打开clash的更多设置，然后设置代理端口为64991
# set -gx http_proxy "http://127.0.0.1:7890"
# set -gx https_proxy "http://127.0.0.1:7890"
set -gx http_proxy "http://127.0.0.1:64991"
set -gx https_proxy "http://127.0.0.1:64991"


# set -gx PATH /opt/homebrew/opt/scala@2.12/bin $PATH
# set -gx PATH /Users/Leehy/sbt/bin $PATH
# set -gx PATH /Users/Leehy/.sdkman/candidates/sbt/current/bin $PATH
# set -gx PATH /Users/Leehy/scala-2.11.12/bin $PATH


set -g fish_prompt_pwd_dir_length 3

function fish_prompt
    set_color C71585 # --bold 
    set dir_cnt $(echo "$PWD" | grep -o '/' | wc -l | sed 's/ * //')
    printf "["

    if [ $dir_cnt -ge 3 ] 
	printf "..."
    end

    if [ $dir_cnt -ge 2 ]
    	echo "$PWD" | awk -F'/' '{printf("/%s",$(NF-1))}'
    end 

    echo "$PWD" | awk -F'/' '{printf("/%s] ",$(NF))}'

    set_color normal
end


function fish_mode_prompt
  set_color D3D3D3 --bold 
  switch $fish_bind_mode
    case default
      echo -n 'N '
    case insert
      echo -n 'I '
    case replace_one
      echo -n 'R '
    case visual
      echo -n 'V '
    case '*'
      echo -n '? '
  end
  set_color normal
end

set fish_color_command 60BA42 --bold

# Colorful manpage
set -x LESS_TERMCAP_md (printf "\033[01;31m")  
set -x LESS_TERMCAP_me (printf "\033[0m")  
set -x LESS_TERMCAP_se (printf "\033[0m")  
set -x LESS_TERMCAP_so (printf "\033[01;44;33m")  
set -x LESS_TERMCAP_ue (printf "\033[0m")  
set -x LESS_TERMCAP_us (printf "\033[01;32m")

# autojump plugin's requirement
[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish

alias ls="exa"
alias la="exa -a"
alias ll="exa -lbghiS"
alias lla="exa -labghiS"

alias mv="mv -i"           # -i prompts before overwrite

alias mkdir="mkdir -p"     # -p make parent dirs as needed

alias df="df -h"           # -h prints human readable format

alias du="du -sh" 

# =========================  conda相关(改用uv了)  ==============================
# 设置miniconda路径
# set -x PATH /Users/Leehy/miniconda3/bin $PATH

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# if test -f /Users/Leehy/miniconda3/bin/conda
#     eval /Users/Leehy/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# else
#     if test -f "/Users/Leehy/miniconda3/etc/fish/conf.d/conda.fish"
#         . "/Users/Leehy/miniconda3/etc/fish/conf.d/conda.fish"
#     else
#         set -x PATH "/Users/Leehy/miniconda3/bin" $PATH
#     end
# end
# <<< conda initialize <<<

# Using tmux with conda, there will be a problem:
#+ When open a new terminal in tmux will auto activate base virenv 
#+ and pacakage will be system instead of base virenv scope, 
#+ so one of the solution is deactivate current virenv and reactivate base virenv
# conda deactivate
# conda activate base

# To use conda in fish shell, run `conda init fish` in zsh/bash when conda 
#+ have been installed.
# To config conda, edit ".condatc" dotfile.
# =======================================================================

