# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# ---------------------------
# Powerlevel10k instant prompt
# ---------------------------
# Initialization code that may require console input must go above this block.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
ZSH_THEME="powerlevel10k/powerlevel10k"

# ---------------------------
# PATH and environment setup
# ---------------------------
# Keep additions grouped and prepend where appropriate.
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export ANDROID_HOME="$ANDROID_SDK_ROOT"

# Base paths
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# Additional tools (grouped)
export PATH="/opt/local/bin:/opt/local/sbin:/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/opt/openjdk/bin:/usr/local/opt/openjdk/bin:$PATH"
export PATH="$HOME/.cargo/bin:$HOME/dev/flutter/bin:$PATH"
export PATH="/opt/metasploit-framework/bin:$PATH"
export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export PATH="/opt/homebrew/opt/node@24/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@17/include"

# User local bins
export PATH="$HOME/.spicetify:$PATH"
export PATH="$PATH:/Applications/XAMPP/xamppfiles/bin"
export GEM_HOME="$HOME/.gem"
export NVM_DIR="$HOME/.nvm"
export PATH="/Users/fiq/.antigravity/antigravity/bin:$PATH"
export PATH=/Users/fiq/.opencode/bin:$PATH

# ---------------------------
# Homebrew-related init (safe)
# ---------------------------
if command -v brew >/dev/null 2>&1; then
  NVM_SH="$(brew --prefix nvm 2>/dev/null)/nvm.sh"
  if [[ -s "$NVM_SH" ]]; then
    source "$NVM_SH"
  fi
  unset NVM_SH
fi

# ---------------------------
# Oh My Zsh & plugins
# ---------------------------
export ZSH="$HOME/.oh-my-zsh"
plugins=(git zsh-autosuggestions web-search z virtualenv)

# Load syntax highlighting and oh-my-zsh (ensure brew prefix exists)
if command -v brew >/dev/null 2>&1 && [[ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Only source oh-my-zsh if installed
[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# ---------------------------
# p10k prompt (if present)
# ---------------------------
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ---------------------------
# Aliases (grouped by category)
# ---------------------------
# Basic
alias clr="clear"
alias ll="colorls -1"
alias ls="colorls"
alias la="colorls -al"
alias new="mkdir"

# Python / Conda
alias p="python"
alias stop="conda deactivate"
alias start="conda activate"

# Emulators & Mobile
alias iPhone="open -a Simulator"
alias android="adb start-server; emulator -avd Android"

# Music (spotify CLI aliases; keep simple)
alias music="spotify open"
alias music_p="spotify play"
alias music_n="spotify next"
alias music_b="spotify back"
alias music_m="spotify mute"
alias music_u="spotify unmute"
alias music_r="spotify replay"
alias music_l="spotify lyrics"

# Utilities
alias info="system_profiler SPHardwareDataType"
alias awake="caffeinate"

# Wi-Fi password lookup (usage: wifi_pass_for <name>)
alias wifi_pass_for="security find-generic-password -wa"

# Downloads (read-only queries)
alias download_show="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent'"
alias download_delete="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# IP (note: assumes en0)
alias ip="ifconfig en0"

# Shortcuts for pomodoro timers (uses 'timer' and terminal-notifier)
alias work="timer 30m && terminal-notifier -message 'Pomodoro' \
  -title 'Work Timer is up! Take a Break 🚬' \
  -appIcon '$HOME/Pictures/pumpkin.png' \
  -sound Crystal"

alias rest="timer 10m && terminal-notifier -message 'Pomodoro' \
  -title 'Break is over! Get back to work 🚀' \
  -appIcon '$HOME/Pictures/pumpkin.png' \
  -sound Crystal"

# AI
alias ai="npx terminalgpt chat"

# Clean caches (careful: requires sudo for some actions)
alias cleancache='
echo "Clearing user cache..."; rm -rf ~/Library/Caches/*;
echo "Clearing user logs..."; rm -rf ~/Library/Logs/*;
echo "Clearing system cache..."; sudo rm -rf /Library/Caches/*;
echo "Flushing DNS cache..."; sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder;
echo "Running maintenance scripts..."; sudo periodic daily weekly monthly;
echo "Done! You may want to reboot for full effect."
'

# ---------------------------
# Colorls tab completion (if installed via gem)
# ---------------------------
if command -v ruby >/dev/null 2>&1 && ruby -e "exit Gem.respond_to?(:bindir) ? 0 : 1" >/dev/null 2>&1; then
  PATH="$(ruby -e 'puts Gem.bindir'):$PATH"
  if command -v colorls >/dev/null 2>&1; then
    TAB_COMPLETE="$(dirname "$(ruby -e 'print Gem.which("colorls")' 2>/dev/null || echo '')")/tab_complete.sh"
    [[ -f "$TAB_COMPLETE" ]] && source "$TAB_COMPLETE"
  fi
fi

# ---------------------------
# Conda (managed by conda init; keep as-is)
# ---------------------------
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

# ---------------------------
# Optional / commented items (left intentionally commented)
# ---------------------------
# # oh my posh
# # eval "$(oh-my-posh init zsh --config ~/.oh-my-posh/themes/taufiq.omp.json)"

# End of file
