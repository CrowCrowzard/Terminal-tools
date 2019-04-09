# 少し凝った zshrc
# License : MIT
# http://mollifier.mit-license.org/
 
########################################
# 環境変数
export LANG=ja_JP.UTF-8
  
# 色を使用出来るようにする
autoload -Uz colors
colors
 
# emacs 風キーバインドにする
bindkey -e
 
# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# ヒストリの表示
function history-all { history -E 1 }
 
# プロンプト
# 1行表示
# PROMPT="%~ %# "
# 2行表示
#PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~%# "
 
 
# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified
 
########################################
# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit
 
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完時に濁点・半濁点を <3099> <309a> のように表示させない
setopt combining_chars

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..
 
# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
 
# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

#矢印キー補完選択
zstyle ':completion:*:default' menu select

# タブキー連打で補完候補を順に表示
setopt auto_menu

zstyle ':completion:*:default' list-colors ""

# 補完候補が複数ある時に、一覧表示する
setopt auto_list

# 補完候補が複数ある時、一覧表示 (auto_list) せず、すぐに最初の候補を補完する
setopt menu_complete

# カッコの対応などを自動的に補完
setopt auto_param_keys

#末尾の/を消去しない
setopt noautoremoveslash

#出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr

########################################
# vcs_info
autoload -Uz vcs_info
autoload -Uz add-zsh-hook
 
zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'
 
function _update_vcs_info_msg() {
    LANG=en_US.UTF-8 vcs_info
    RPROMPT="${vcs_info_msg_0_}"
}
add-zsh-hook precmd _update_vcs_info_msg
 
 
########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit
 
# beep を無効にする
setopt no_beep
 
# フローコントロールを無効にする
setopt no_flow_control
 
# Ctrl+Dでzshを終了しない
setopt ignore_eof
 
# '#' 以降をコメントとして扱う
setopt interactive_comments
 
# ディレクトリ名だけでcdする
setopt auto_cd
 
# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups
 
# 同時に起動したzshの間でヒストリを共有する
setopt share_history
 
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
 
# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space
 
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks
 
# 高機能なワイルドカード展開を使用する
setopt extended_glob
 
########################################
# キーバインド
 
# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward
 
########################################
# エイリアス
 
alias la='ls -a'
alias ll='ls -l'
 
#alias rmrf='rm -rf'
#alias rm='rmtrash'
alias cp='cp -i'
alias mv='mv -i'
 
alias mkdir='mkdir -p'

alias show='history 100'
# python
alias python='python -B'

# g++11
alias g++11='g++ -std=c++11'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '
 
# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# Ruby
alias be='bundle exec'

# GHQ 関係
alias g='cd $(ghq root)/$(ghq list | peco)'
alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'
alias gg='ghq get'
#ghq get git@github.com:CrowCrowzard/microposts_rails

# Git
alias ga='git add'
alias gb='git blame'
alias gc='git checkout'
alias gl='git log'
alias gr='git reset'
alias gs='git status'
alias grm='git rm'
alias gmv='git mv'
alias gpush='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias gcom='git commit'
alias gcm='git commit -m'
alias gd='git diff'
alias gdc='git diff --cached'
alias gp='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias resetconf='git reset --hard ORIG_HEAD'
alias prune='git remote prune origin'

# Docker
alias dk='docker'
alias dkr='docker run'
alias dps='docker ps'
alias dc='docker-compose'
alias dm='docker-machine'
alias d_reset='docker volume ls -f "dangling=true" -q | xargs docker volume rm:'
alias guard='docker-compose run --rm web guard'

# JMeter
alias jmeter='java -jar /Applications/apache-jmeter-3.2/bin/ApacheJMeter.jar &'

# MTR
alias mtr='sudo /usr/local/sbin/mtr'
#alias mtr='sudo /usr/local/Cellar/mtr/0.92/sbin/mtr'

# コマンド終了通知
# {コマンド} && noti
#alias noti='terminal-notifier -message "コマンド完了"'

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi
 
 
 
########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        alias ls='ls -F --color=auto'
        ;;
esac
 
# vim:set ft=zsh:

#########################################
#追加した設定
#########################################


# ls
export LSCOLORS=gxfxcxdxbxegedabagacag
export LS_COLORS='di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;46'

# Python startupの追加
#export PYTHONSTARTUP=~/.pythonrc.py

export PATH=/usr/local/bin:$PATH

# Virautlenv
#export PATH=$PATH:/Users/hedgehog/workspace/Python/fsemi/bin
#export PATH=$PATH:/Users/hedgehog/workspace/Python/study/bin

# IPv6 パブリックDNS
export V6='2001:4860:4860::8888'

# prompt
#autoload -U colors
#colors
local p_cdir="%F{white}(๑˃̵ᴗ˂̵)%f[%F{white}%d%f] "$'\n'
local p_mark="%(?,%F{green},%F{red})%(!,#,>)%f"
PROMPT="$p_cdir$p_mark"
# 右プロンプト
#local GREEN=$'%{\e[1;32m%}'
#local DEFAULT=$'%{\e[1;m%}'
#RPROMPT=$DEFAULT"["$GREEN"%*"$DEFAULT"]"
eval "$(rbenv init -)"

# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Node.js
export PATH=/Users/hedgehocrow/.nodebrew/current/bin:$PATH

# Java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home

# shell
cd() {
  builtin cd "$@" && clear && ls
}

is_failed() {
  if [ $? -ne 0 ]; then
    echo "The command was not sucessful.";
  fi;
}

# less
export LESS='-g -i -M -R -S'
export PAGER=less

export LESS_TERMCAP_mb=$'\E[01;31m'      # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;31m'      # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'          # Ends mode.
export LESS_TERMCAP_se=$'\E[0m'          # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;47;30m'   # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'          # Ends underline.
export LESS_TERMCAP_us=$'\E[01;32m'      # Begins underline.

# 辞書を引く(英和)
#function ejdict() {
#    grep "$1" /usr/share/dict/dict/gene-utf8.txt -E -A 1 -wi --color
#}
## 辞書を引く(和英)
#function jedict() {
#    grep "$1" /usr/share/dict/dict/gene-utf8.txt -E -B 1 -wi --color
#}

# pyenv読み込み
export PYENV_ROOT="/usr/local/var/pyenv"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# goenv読み込み
export PATH="$HOME/.goenv/bin:$PATH"
eval "$(goenv init -)"

# jenv読み込み
# jEnv
#export JENV_ROOT="$HOME/.jenv"
#if [ -d "${JENV_ROOT}" ]; then
#  export PATH="$JENV_ROOT/bin:$PATH"
#  eval "$(jenv init -)"
#fi
