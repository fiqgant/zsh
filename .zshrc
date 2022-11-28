# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
PATH=$(ruby -e 'puts Gem.bindir'):$PATH
export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH="$PATH:/Users/fiq/dev/flutter/bin"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export ANDROID_HOME="$HOME/Library/Android/Sdk"
export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export GEM_HOME="$HOME/.gem"
export PATH=$PATH:/Users/fiq/.spicetify
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

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

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(git zsh-autosuggestions web-search z)

#syntax-lighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/oh-my-zsh.sh

# colorls
source $(dirname $(gem which colorls))/tab_complete.sh

# alias for file
alias new="mkdir"
alias ll="colorls -1"
alias ls="colorls"
alias la="colorls -al"

# alias for python
alias pip="pip3"
alias p="python3"
alias python="python3"
# env
alias stop="conda deactivate"
alias start_ml="conda activate ml"

# alias for emulator
alias iPhone="open -a Simulator"
alias android="adb start-server; emulator -avd Android"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

