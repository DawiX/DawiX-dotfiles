# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/david/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lm='ls -l --block-size=1M'
alias grep='grep --color=auto'
alias suspend='sudo pm-suspend'
alias wifiscan='sudo iwlist wlan0 scan'
alias wifi='wicd-curses'
alias teplota='acpi -t'
alias baterka='acpi'
alias radio-country='mplayer -cache 1024 http://sc-rly.181.fm:80/stream/1075'
alias radio-hitz='mplayer -cache 1024 http://scfire-ntc-aa03.stream.aol.com:80/stream/1074'
alias radio-jazz='mplayer -cache 1024 http://64.74.207.40:8042'
alias radio-reggae='mplayer -cache 1024 http://scfire-ntc-aa08.stream.aol.com:80/stream/1017'
alias radio-radiobeatCZ='mplayer -cache 1024 http://netshow.play.cz:8000/radiobeat128.ogg'
alias radio-kissJizniCechyCZ='mplayer -cache 1024 http://netshow.play.cz:8000/kissjc32aac'
alias radio-evropa2='mplayer -cache 1024 http://netshow.play.cz:8000/Evropa2-32aac'
alias ..='cd ..'
alias kiloseconds='zsh /home/david/.bin/kiloseconds.sh'
alias jku='links https://login.jku.at'
alias hermes='ssh -X -l pechda00 hermes.prf.jcu.cz'
alias data4Octave='zsh /home/david/.loadDataOctave.sh'
alias chcipni='sudo halt'
alias gmail='getmail -n'
alias tema='zsh /home/david/.bin/colortheme.sh'
alias hypnotoad='perl /home/david/.bin/hypnotoad.pl'
alias mute='ossmix jack.int-speaker.mute ON'
alias unmute='ossmix jack.int-speaker.mute OFF'
alias writeroom='vim -S ~/.vim/writeroom/writeroom.vim'
alias pcfm='sh /home/david/.bin/pcfm'
alias slurpy='slurpy -c'
alias pacman='sudo pacman'
alias tuxsay='cowsay -f tux'

autoload -U promptinit
promptinit
prompt elite2 green
export MPD_HOST=archeee

setopt autocd

## Correction
#setopt correctall

## Completion
zstyle :compinstall filename "$HOME/.zshrc"
zstyle ':completion:*:*:cd:*' tag-order local-directories path-directories
zstyle ':completion:*:rm:*' ignore-line yes                               
# color for completion                                                    
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}             
# menu for auto-completion                                                
zstyle ':completion:*' menu select=2                                      
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

