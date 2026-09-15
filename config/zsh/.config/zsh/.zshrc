# vim: foldmethod=marker
# START
# load zshenv {{{
if [ -f $HOME/.zshenv ]; then
    source $HOME/.zshenv
fi
# }}}
# load plugins {{{
# for plugin in $ZSHPLUGINS/* ; do
#     if [ -d $plugin ] ; then
#         source $plugin/*.plugin.zsh
#     fi
# done
# }}}
# load aliases {{{
if [ -f $HOME/.config/aliasrc ]; then
    source $HOME/.config/aliasrc
fi
# }}}
# load functions {{{
if [ -f $HOME/.config/fnrc ]; then
    source $HOME/.config/fnrc
fi
# }}}
# export {{{
export DWMBLOCKS_SCRIPTS_DIR="/home/skm/.local/src/dwmblocks/scripts"
# export MANPATH="/usr/local/man:$MANPATH"
export myVIMRC="$XDG_CONFIG_HOME/nvim/init.lua"
# }}}
# BASIC
# basic {{{
unsetopt beep # BEEP
setopt autocd # auto cd into typed directory
bindkey -v # vim bindings
export KEYTIMEOUT=1
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments # comments
# }}}
# completions {{{
# completions
autoload -Uz compinit && compinit
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*' # case insensitive
zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' special-dirs true # Complete . and .. special directories
_comp_options+=(globdots)		# Include hidden files
# completion menu
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect '^xi' vi-insert
# }}}
# prompt {{{
autoload -U colors && colors	# Load colors

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats 'on branch %b'
RPROMPT="%B%F{100}\$vcs_info_msg_0_%b%f"

if [ $USER = "root" ] | [ "$HOME" = "/root" ] ; then
    # "%B%F{1}%n %b%# %~ $%f "
    export PS1="%B%F{1}%~
%n %b%# $%f "
else
    # "%B%F{209}%n %b%# %~ $%f "
    export PS1="%B%F{209}%~
%n %b%#%f "
fi
# }}}
# history {{{
HISTSIZE=10000000
SAVEHIST=10000000
# history records date
export HISTTIMEFORMAT="%h/%d - %H:%M:%S "
# history ignore
export HISTIGNORE="[  ]*"
setopt appendhistory
# setopt BANG_HIST                 # Treat the '!' character specially during expansion.
# setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY           # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY                # Share history between all sessions.
# setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
# setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
# setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
# setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
# setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
# setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
# setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
# setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
# setopt HIST_BEEP                 # Beep when accessing nonexistent history.


# prevent history from writing some commands
# function zshaddhistory() {
#     [[ $1 != *"rm"* ]] && [[ $1 != *"cd"* ]] && [[ $1 != *"mv"* ]] &&
#     [[ $1 != *"wget"* ]] && [[ $1 != *"youtube-dl"* ]] && [[ $1 != *"w3m"* ]]
# }


# }}}
# cursor {{{
cursor_mode() {
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    zle-line-init() {
        echo -ne $cursor_beam
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}

cursor_mode
# }}}
# KEYS
# Del key {{{
bindkey    "^[[3~"          delete-char
bindkey    "^[3;5~"         delete-char
bindkey     "\e[3~"         delete-char
# bindkey     "^[[P"          delete-char
# }}}
# backspace key {{{
bindkey "\177" backward-delete-char
bindkey "\033\177" backward-delete-word
# }}}
# moving around {{{
# ctrl-left and ctrl-right
bindkey "\e[1;5D" backward-word
bindkey "\e[1;5C" forward-word
# ctrl-shift + {left/right}
bindkey "\e[1;6D" vi-backward-word-end
bindkey "\e[1;6C" forward-word
# ctrl-bs and ctrl-del
bindkey "\e[3;5~" kill-word
bindkey "\e[M" kill-word
bindkey "\C-_" backward-kill-word
# del, home and end
# bindkey "\e[3~" delete-char
# bindkey "\e[H"  beginning-of-line
# bindkey "\e[F"  end-of-line
# }}}
# repeat command {{{
bindkey -s '\e1' "!:0 \t" # repeats last command
bindkey -s '\e2' "!:0-1 \t" # repeats last command and first argument
bindkey -s '\e3' "!:0-2 \t"
bindkey -s '\e4' "!:0-3 \t"
bindkey -s '\e5' "!:0-4 \t"
bindkey -s '\e6' "!:0-5 \t"
# }}}
# edit command {{{
autoload edit-command-line
zle -N edit-command-line
bindkey '^a' edit-command-line
# }}}
# OTHER
# Preferred editor for local and remote sessions {{{
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
# }}}
# Compilation flags {{{
# export ARCHFLAGS="-arch x86_64"
# }}}
# less {{{
# use most
# export PAGER="most"
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
# }}}
# broot {{{
# source /home/skm/.config/broot/launcher/bash/br
# }}}
# ranger {{{
# so ranger inside shell inside ranger is solved
ranger() {
    if [ -z "$RANGER_LEVEL" ]; then
        /usr/bin/ranger "$@"
    else
        exit
    fi
}
# }}}
# CUSTOM KEYS
# use lf to cd {{{
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'
# }}}
# Make ^Z toggle between ^Z and fg {{{
function ctrlz() {
if [[ $#BUFFER == 0 ]]; then
    fg >/dev/null 2>&1 && zle redisplay
else
    zle push-input
fi
}

zle -N ctrlz
bindkey '^Z' ctrlz
# }}}
# xopen, vimwiki, fopen, dirf {{{
bindkey -s '^x' "\eIxopen # ^M" # clear line and xopen
bindkey -s '^w' "\eIwopen # ^M" # clear line and vimwiki
bindkey -s '^f' "\eIfopen # ^M" # clear line and cd into dir
bindkey -s '^v' "\eIvopen # ^M" # open in vim
bindkey -s '^p' "\eIdirf # ^M" # clear line and dirf
# }}}

# PATH {{{
[ -d "/home/skm/code/scripts/pathscripts" ] && export PATH="$PATH:/home/skm/code/scripts/pathscripts"
[ -d "/home/skm/.local/bin" ] && export PATH="/home/skm/.local/bin:$PATH"
[ -d "/home/skm/.local/share/gem/ruby/3.0.0/bin" ] && export PATH="/home/skm/.local/share/gem/ruby/3.0.0/bin:$PATH"
PATH="/home/skm/.config/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/skm/.config/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/skm/.config/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/skm/.config/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/skm/.config/perl5"; export PERL_MM_OPT;
# remove duplicates
typeset -U PATH path
# }}}
# add completions {{{
# fpath=($$XDG_CONFIG_HOME/zsh/plugins/zsh-completions/src $fpath)
# }}}
# add highlighting, has to be last {{{
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# }}}
# fzf {{{
eval "$(fzf --zsh)"
# use fd
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
_fzf_compgen_path() {
    fd --hidden --exclude .git . "$1"
}
_fzf_compgen_dir() {
    fd --type=d --hidden --exclude .git . "$1"
}
# }}}
# bat {{{
export BAT_THEME="gruvbox-dark"
# }}}
# GTK
export GTK_THEME="Gruvbox-Material-Dark"
# startup {{{
# date
# getRandomHanzi
# get-random-korean
# get-random-magyar
# }}}
# KEYCHAIN
eval "$(keychain --quiet add --eval id_ed25519_github_signing)"

if [ -f "$HOME/.local/bin/env" ]; then
  . "$HOME/.local/bin/env"
fi
