# ~/.zshrc
bindkey -v
fish
PS1="> "

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/Leehy/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/Leehy/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/Leehy/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/Leehy/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

