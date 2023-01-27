# .zshrc

![zsh](https://github.com/fiqgant/zsh/blob/main/images/1.png)
![zsh](https://github.com/fiqgant/zsh/blob/main/images/2.png)
![zsh](https://github.com/fiqgant/zsh/blob/main/images/3.png)

## Plugins
- [git](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [web-search](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/web-search)
- [z](https://github.com/agkozak/zsh-z)
- [colorls](https://github.com/athityakumar/colorls)
- [terminalGPT](https://github.com/jucasoliveira/terminalGPT)
- [Spotify Client for Mac OS X](https://github.com/ersel/spotify-cli-mac)
- [terminal-notifier](https://github.com/caarlos0/timer)

## Alias
### Alias for file
- alias new="mkdir"
- alias clr="clear"

### Alias for python
- alias pip="pip3"
- alias p="python3"
- alias python="python3"

#### env
- alias stop="conda deactivate"
- alias start="conda activate"

### Alias for emulator
- alias iPhone="open -a Simulator"
- alias android="adb start-server; emulator -avd Android"

### AI
alias ai="npx terminalgpt chat"

### Utilities
#### Find wifi password
alias wifi_pass_for="security find-generic-password -wa"

#### Stay awake
alias awake="caffeinate"

#### show download
alias download_show="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'select LSQuarantineDataURLString from LSQuarantineEvent'"

#### delete download
alias download_delete="sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

#### IP
alias ip="ifconfig en0"

#### Music
alias music="spotify open"
alias music_p="spotify play"
alias music_n="spotify next"
alias music_b="spotify back"
alias music_m="spotify mute"
alias music_u="spotify unmute"
alias music_r="spotify replay"

#### Pomodoro Timer
alias work="timer 30m && terminal-notifier -message 'Pomodoro'\
        -title 'Work Timer is up! Take a Break 😊'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Crystal"
        
alias rest="timer 10m && terminal-notifier -message 'Pomodoro'\
        -title 'Break is over! Get back to work 😬'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Crystal"

## Theme
[Powerlevel10k](https://github.com/romkatv/powerlevel10k)
