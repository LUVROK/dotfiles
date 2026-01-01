# Установите тему Zsh на powerlevel10k
ZSH_THEME="robbyrussell"

# Список плагинов, которые будут загружены
plugins=(git zsh-syntax-highlighting zsh-autosuggestions zsh-autocomplete)

# Конфигурация powerlevel10k (необходимо запустить `p10k configure`, если вы это еще не сделали)
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Настройки для плагинов
# Для zsh-autocomplete
zstyle ':autocomplete:*' completer _complete _approximate
zstyle ':autocomplete:*' max-errors 2 numeric

# Дополнительные настройки командной строки
# export PROMPT='%B%F{214}%n%f@%m %1~ ># %b'
export PROMPT='%~ > '

# Дополнительные переменные окружения
export EDITOR='nvim' # Установка nano как стандартного редактора
export LANG=en_US.UTF-8 # Установка локали

# Функции
function _mountvc() { sudo -v && veracrypt --mount "$1" "$2" --password "$3" > /dev/null 2>&1 & }
function _dismountvc() { sudo -v && veracrypt --dismount $1 & }
function _mountvc-pn() { sudo -v && veracrypt --mount ~/HOME/private_containers/private_notes /media/veracrypt1 > /dev/null 2>&1 & }
# function _xrandr-hdmi-1-0() { xrandr --output HDMI-1-0 --scale 1x1 --mode 2560x1440 --rate 120.00 --right-of eDP-1 && feh --geometry 2560x1440+0+0 --auto-zoom --bg-fill /home/dash/HOME/wizzard/wallpaper/game-of-thrones-kings-landing.png > /dev/null 2>&1 & }
# function _xrandr-hdmi-1-0-output() { xrandr --output HDMI-1-0 --off & }
function _ps_aux_grep() { command ps aux | grep --color=auto "$1" }

# Алиасы для удобства
alias ll='ls -lah'
alias la='ls -A'
alias vi='vim'
alias grep='grep --color=auto'
alias system-s='~/HOME/dotfiles/apply_system.sh'
alias user-s='~/HOME/dotfiles/apply_users.sh'
# alias xrandr-hdmi-1-0='_xrandr-hdmi-1-0'
# alias xrandr-hdmi-1-0-output='_xrandr-hdmi-1-0-output'
alias vpn-app='_vpn_app'
alias psg='_ps_aux_grep'

# Алиасы для крипто контейнеров
alias mountvc='_mountvc'
alias dismountvc='_dismountvc'
alias mountvc-pn='_mountvc-pn'
alias mountvc-ps='_mountvc-ps'
alias dismountvc-ps='_dismountvc-ps'

# Проверка и поддержка interactivity
if [ -n "$PS1" ]; then
    # Подключаемые скрипты, специфичные для интерактивного режима
    autoload -Uz compinit
    compinit
    autoload -Uz bashcompinit
    bashcompinit
fi
