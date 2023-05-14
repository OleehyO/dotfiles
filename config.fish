# ~/.config/fish/config.fish
set fish_greeting ""


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

# function fish_right_prompt
#     set_color D3D3D3 
#     if git rev-parse --is-inside-work-tree > /dev/null 2>&1
# 	set_color FF8C00 --bold
# 	printf '('
# 
# 	git branch | grep "^* " | sed 's/^*\ //' | awk '   
# 							    /HEAD detached at/ {
# 			                                        $0 = substr($0, 2, length($0) - 2);
#                              				    }
#                             				    1 {
#                                  			        printf("%s", $0);
#                              			    	    }
#                         			        '
# 
# 	printf ')'
#     	set_color normal
#     end
# end

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/Leehy/anaconda3/bin/conda
    eval /Users/Leehy/anaconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

# To use conda in fish shell, run `conda init fish` in zsh/bash when conda 
#+ have been installed.
# To config conda, edit ".condatc" dotfile.