# ==============================================================================
#  ~/.zshrc
# ==============================================================================
#  Sections
#    1. Pre-init (Fig, greeting, Powerlevel10k instant prompt)
#    2. Homebrew & environment
#    3. PATH
#    4. Oh My Zsh & plugins
#    5. Aliases
#    6. Functions
#    7. Tool integrations (colorls, conda)
#    8. User bins & AI tooling (must stay after conda)
# ==============================================================================


# ------------------------------------------------------------------------------
# 1. Pre-init
# ------------------------------------------------------------------------------

# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# Terminal greeting. Must run BEFORE the instant prompt to avoid p10k warnings.
command -v pokemon-colorscripts >/dev/null 2>&1 && pokemon-colorscripts --random

# Powerlevel10k instant prompt (keep near the top; do not move below slow init).
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# ------------------------------------------------------------------------------
# 2. Homebrew & environment
# ------------------------------------------------------------------------------

# Sets HOMEBREW_PREFIX, PATH, MANPATH, INFOPATH once (avoids repeated `brew --prefix`).
[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# Android
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export ANDROID_HOME="$ANDROID_SDK_ROOT"

# Java / Ruby / Node
export CPPFLAGS="-I/opt/homebrew/opt/openjdk@17/include"
export GEM_HOME="$HOME/.gem"
export NVM_DIR="$HOME/.nvm"
export BUN_INSTALL="$HOME/.bun"

# nvm (via Homebrew)
[[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ]] && source "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"


# ------------------------------------------------------------------------------
# 3. PATH
# ------------------------------------------------------------------------------
# `typeset -U` removes duplicates (first occurrence wins).
# Entries are listed highest priority first.

typeset -U path PATH

path=(
  "$GEM_HOME/bin"
  "$HOME/.opencode/bin"
  "$HOME/.antigravity/antigravity/bin"
  "$HOME/.spicetify"
  /opt/homebrew/opt/openjdk@17/bin
  "$ANDROID_HOME/emulator"
  "$ANDROID_HOME/platform-tools"
  "$ANDROID_HOME/cmdline-tools/latest/bin"
  /opt/metasploit-framework/bin
  "$HOME/.cargo/bin"
  /opt/homebrew/opt/ruby/bin
  /opt/homebrew/opt/openjdk/bin
  /usr/local/opt/openjdk/bin
  /opt/local/bin
  /opt/local/sbin
  $path
  /Applications/XAMPP/xamppfiles/bin
)


# ------------------------------------------------------------------------------
# 4. Oh My Zsh & plugins
# ------------------------------------------------------------------------------

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions web-search z virtualenv)

[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# Powerlevel10k config
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Syntax highlighting must be sourced LAST among the plugins.
[[ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] \
  && source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"


# ------------------------------------------------------------------------------
# 5. Aliases
# ------------------------------------------------------------------------------

# --- Basics
alias clr="clear"
alias ls="colorls"
alias ll="colorls -1"
alias la="colorls -al"
alias new="mkdir"

# --- Python / Conda
alias p="python"
alias start="conda activate"
alias stop="conda deactivate"

# --- Emulators & mobile
alias iPhone="open -a Simulator"
alias android="adb start-server; emulator -avd Android"

# --- Music (spotify-cli)
alias music="spotify open"
alias music_p="spotify play"
alias music_n="spotify next"
alias music_b="spotify back"
alias music_m="spotify mute"
alias music_u="spotify unmute"
alias music_r="spotify replay"
alias music_l="spotify lyrics"

# --- System utilities
alias info="system_profiler SPHardwareDataType"
alias awake="caffeinate"
alias ip="ifconfig en0"                       # assumes Wi-Fi on en0
alias wifi_pass_for="security find-generic-password -wa"   # usage: wifi_pass_for <ssid>

# --- Download history (quarantine database)
alias download_show="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent'"
alias download_delete="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# --- Pomodoro (requires `timer` and `terminal-notifier`)
alias work="timer 30m && terminal-notifier -message 'Pomodoro' \
  -title 'Work Timer is up! Take a Break 🚬' \
  -appIcon '$HOME/Pictures/pumpkin.png' \
  -sound Crystal"

alias rest="timer 10m && terminal-notifier -message 'Pomodoro' \
  -title 'Break is over! Get back to work 🚀' \
  -appIcon '$HOME/Pictures/pumpkin.png' \
  -sound Crystal"

# --- AI
alias ai="npx terminalgpt chat"

# Claude Code variants
#   claude   -> normal (claude.ai login)
#   claude9  -> local proxy (settings in ~/.claude/settings-proxy.json)
#   claudepi -> Ollama on Raspberry Pi 5 (Gemma 4 E2B)
alias claude9="claude --settings ~/.claude/settings-proxy.json"
alias claudepi="ANTHROPIC_BASE_URL=http://home.local:11434 ANTHROPIC_AUTH_TOKEN=ollama ANTHROPIC_API_KEY= ANTHROPIC_MODEL=gemma4:e2b ANTHROPIC_SMALL_FAST_MODEL=gemma4:e2b claude"


# ------------------------------------------------------------------------------
# 6. Functions
# ------------------------------------------------------------------------------

# Clear caches and run macOS maintenance (asks for confirmation first).
cleancache() {
  read -q "REPLY?This deletes user/system caches and logs (uses sudo). Continue? [y/N] "
  echo
  [[ "$REPLY" == [yY] ]] || { echo "Cancelled."; return 1; }

  echo "Clearing user cache...";   rm -rf ~/Library/Caches/*
  echo "Clearing user logs...";    rm -rf ~/Library/Logs/*
  echo "Clearing system cache..."; sudo rm -rf /Library/Caches/*
  echo "Flushing DNS cache...";    sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
  echo "Running maintenance...";   sudo periodic daily weekly monthly
  echo "Done. A reboot is recommended for full effect."
}

# claude-mem worker: always uses the newest installed plugin version.
claude-mem() {
  local dir
  dir="$(ls -d "$HOME"/.claude/plugins/cache/thedotmack/claude-mem/*/ 2>/dev/null | sort -V | tail -1)"
  [[ -n "$dir" ]] || { echo "claude-mem not found"; return 1; }
  bun "${dir}scripts/worker-service.cjs" "$@"
}


# ------------------------------------------------------------------------------
# 7. Tool integrations
# ------------------------------------------------------------------------------

# colorls tab completion (looks inside GEM_HOME; avoids spawning ruby at startup).
() {
  local tc=( "$GEM_HOME"/gems/colorls-*/lib/tab_complete.sh(N[-1]) )
  [[ -n "$tc" ]] && source "$tc"
}

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


# ------------------------------------------------------------------------------
# 8. User bins & AI tooling (after conda so these take priority)
# ------------------------------------------------------------------------------

path=(
  "$BUN_INSTALL/bin"
  "$HOME/.local/bin"
  /opt/homebrew/opt/node@24/bin
  $path
)

# bun completions
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"
# proto
export PROTO_HOME="$HOME/.proto";
export PATH="$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH";
