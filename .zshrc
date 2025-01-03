# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH="$PATH:/Users/taufiq/dev/flutter/bin"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/metasploit-framework/bin:$PATH"
export PATH=/Applications/XAMPP/xamppfiles/bin:$PATH
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export ANDROID_HOME="$HOME/Library/Android/Sdk"
export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export GEM_HOME="$HOME/.gem"
export PATH=$PATH:/Users/taufiq/.spicetify
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh


# # oh my posh
# eval "$(oh-my-posh init zsh --config ~/.oh-my-posh/themes/taufiq.omp.json)"

#Theme
ZSH_THEME="powerlevel10k/powerlevel10k"
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Plugins
plugins=(git zsh-autosuggestions web-search z virtualenv)


#syntax-lighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/oh-my-zsh.sh

# colorls
PATH=$(ruby -e 'puts Gem.bindir'):$PATH
source $(dirname $(gem which colorls))/tab_complete.sh
alias ll="colorls -1"
alias ls="colorls"
alias la="colorls -al"

# alias for file
alias new="mkdir"
alias clr="clear"


# env
alias stop="conda deactivate"
alias start="conda activate"

# alias for emulator
alias iPhone="open -a Simulator"
# alias android="adb start-server; emulator -avd Android"

# AI
alias ai="npx terminalgpt chat"

# Utilities
## Find wifi password
alias wifi_pass_for="security find-generic-password -wa"

## file manager
alias scf=""

## Stay awake
alias awake="caffeinate"

## python
alias p="python"
# alias pip="pip install"

## show download
alias download_show="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent'"

## delete download
alias download_delete="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

## IP
alias ip="ifconfig en0"

## Music
alias music="spotify open"
alias music_p="spotify play"
alias music_n="spotify next"
alias music_b="spotify back"
alias music_m="spotify mute"
alias music_u="spotify unmute"
alias music_r="spotify replay"
alias music_l="spotify lyrics"

alias info="system_profiler SPHardwareDataType"


## Pomodoro Timer
alias work="timer 30m && terminal-notifier -message 'Pomodoro'\
        -title 'Work Timer is up! Take a Break 🚬'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Crystal"
        
alias rest="timer 10m && terminal-notifier -message 'Pomodoro'\
        -title 'Break is over! Get back to work 🚀'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Crystal"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
