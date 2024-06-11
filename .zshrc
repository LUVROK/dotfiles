# Установите тему Zsh на powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

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
export EDITOR='nano' # Установка nano как стандартного редактора
export LANG=en_US.UTF-8 # Установка локали

# Алиасы для удобства
alias ll='ls -lah'
alias la='ls -A'
alias vi='vim'
alias grep='grep --color=auto'

# Проверка и поддержка interactivity
if [ -n "$PS1" ]; then
    # Подключаемые скрипты, специфичные для интерактивного режима
    autoload -Uz compinit
    compinit
    autoload -Uz bashcompinit
    bashcompinit
fi
