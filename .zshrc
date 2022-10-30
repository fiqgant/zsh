# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH="$PATH:/Users/fiq/dev/flutter/bin"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
PATH=$(ruby -e 'puts Gem.bindir'):$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"
export GEM_HOME="$HOME/.gem"

# Plugins
plugins=(git)
plugins=(git zsh-autosuggestions web-search z)

#syntax-lighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/oh-my-zsh.sh

# colorls
source $(dirname $(gem which colorls))/tab_complete.sh

alias new="mkdir"
alias pip="pip3"
alias python="python3"
alias emulator="open -a Simulator"
alias ll="colorls -1"
alias ls="colorls"
alias la="colorls -al"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/fiq/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/fiq/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/fiq/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/fiq/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# >>> anaconda conda config >>> 
PATH="$HOME/miniconda3]/bin:$PATH"


export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

