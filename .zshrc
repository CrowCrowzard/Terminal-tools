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
alias lla='ls -la'

alias e='exa'
alias el='e -l'
alias ea='e -a'
alias ela='e -la'

alias b='bat'

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
alias gcb='git checkout -b'
alias gw='git switch'
alias gwc='git switch -c'
alias gl='git log'
alias gf='git fetch'
alias glg='git log --oneline --decorate=full --graph'
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
alias prune='git remote prune origin && git branch --merged | egrep -v "\*|develop|master" | xargs git branch -d'

# Docker
alias dk='docker'
alias dkr='docker run'
alias dkb='docker build'
alias dps='docker ps'
alias dc='docker-compose'
alias dm='docker-machine'
alias d_reset='docker volume ls -f "dangling=true" -q | xargs docker volume rm:'
alias guard='docker-compose run --rm web guard'

# Kubernetes
alias k="kubectl"

# CircleCI
alias cc="circleci"
alias cle="circleci local execute"

# VS Code
alias c="code"

# JMeter
alias jmeter='java -jar /Applications/apache-jmeter-3.2/bin/ApacheJMeter.jar &'

# MTR
alias mtr='sudo /usr/local/sbin/mtr'
#alias mtr='sudo /usr/local/Cellar/mtr/0.92/sbin/mtr'

# コマンド終了通知
# {コマンド} && noti
alias noti='terminal-notifier -message "コマンド完了" -sound default'

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
export GO111MODULE=on

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

#########################################
# TMUX関連
# ----------------------------
# TMUX起動にzshプラグインは不要
if [[ -z "$TMUX" ]]
then
      tmux new-session;
        exit;
fi

# 画面を分割しながら複数ホストにssh
# usage: mssh -n 4 test{1..3}.example.jp
# -n: 1つのwindowに表示するpaneの最大数
function mssh() {
    max_pane_num=30
    while getopts n: option
    do
      case $option in
        n) max_pane_num=$OPTARG ;;
        \?) echo "Invalid option."
              exit 1;;
      esac
    done
    shift $((OPTIND - 1))
    i=1
    cnt=0
    host_num=$#
    for host in $@
    do
        cnt=$((cnt+1))
        ### 各ホストにsshログイン
        if [ $i -eq 1 ]; then
            # 各Windowの最初の1台はsshするだけ
            tmux send-keys "ssh $host" C-m
        else
            tmux split-window
            tmux select-layout tiled
            tmux send-keys "ssh $host" C-m
        fi
        rest=$((i%max_pane_num))
        i=$((i+1))

        ### 2つのWindowにmax_pane_numサーバずつ表示
        if [ $rest -eq 0 ] && [ $cnt -ne $host_num ]; then
            tmux set-window-option synchronize-panes on
            tmux new-window -n "mssh"
            i=1
        fi
    done
    # pane間を同期
    tmux setw synchronize-panes
}

# main-horizontal
function hssh() {
    max_pane_num=30
    while getopts n: option
    do
      case $option in
        n) max_pane_num=$OPTARG ;;
        \?) echo "Invalid option."
              exit 1;;
      esac
    done
    shift $((OPTIND - 1))
    i=1
    cnt=0
    host_num=$#
    for host in $@
    do
        cnt=$((cnt+1))
        ### 各ホストにsshログイン
        if [ $i -eq 1 ]; then
            # 各Windowの最初の1台はsshするだけ
            tmux send-keys "ssh $host" C-m
        else
            tmux split-window
            tmux select-layout main-horizontal
            tmux send-keys "ssh $host" C-m
        fi
        rest=$((i%max_pane_num))
        i=$((i+1))

        ### 2つのWindowにmax_pane_numサーバずつ表示
        if [ $rest -eq 0 ] && [ $cnt -ne $host_num ]; then
            tmux set-window-option synchronize-panes on
            tmux new-window -n "mssh"
            i=1
        fi
    done
    # pane間を同期
    tmux setw synchronize-panes
}

# even-vertical
function vssh() {
    max_pane_num=30
    while getopts n: option
    do
      case $option in
        n) max_pane_num=$OPTARG ;;
        \?) echo "Invalid option."
              exit 1;;
      esac
    done
    shift $((OPTIND - 1))
    i=1
    cnt=0
    host_num=$#
    for host in $@
    do
        cnt=$((cnt+1))
        ### 各ホストにsshログイン
        if [ $i -eq 1 ]; then
            # 各Windowの最初の1台はsshするだけ
            tmux send-keys "ssh $host" C-m
        else
            tmux split-window
            tmux select-layout even-vertical
            tmux send-keys "ssh $host" C-m
        fi
        rest=$((i%max_pane_num))
        i=$((i+1))

        ### 2つのWindowにmax_pane_numサーバずつ表示
        if [ $rest -eq 0 ] && [ $cnt -ne $host_num ]; then
            tmux set-window-option synchronize-panes on
            tmux new-window -n "mssh"
            i=1
        fi
    done
    # pane間を同期
    tmux setw synchronize-panes
}

# remoteのtmux attachでagent転送が切れないようにする
agent="$HOME/.ssh/agent"
if [ -S "$SSH_AUTH_SOCK" ]; then
    case $SSH_AUTH_SOCK in
        /tmp/*/agent.[0-9]*)
            ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
    esac
elif [ -S $agent ]; then
    export SSH_AUTH_SOCK=$agent
else
    echo "no ssh-agent"
fi

#function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
#function is_osx() { [[ $OSTYPE == darwin* ]]; }
#function is_screen_running() { [ ! -z "$STY" ]; }
#function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
#function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
#function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
#function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }
#
#function tmux_automatically_attach_session()
#{
#    if is_screen_or_tmux_running; then
#        ! is_exists 'tmux' && return 1
#
#        if is_tmux_runnning; then
#            echo "${fg_bold[blue]} _____ __  __ _   ___  __ ${reset_color}"
#            echo "${fg_bold[blue]}|_   _|  \/  | | | \ \/ / ${reset_color}"
#            echo "${fg_bold[blue]}  | | | |\/| | | | |\  /  ${reset_color}"
#            echo "${fg_bold[blue]}  | | | |  | | |_| |/  \  ${reset_color}"
#            echo "${fg_bold[blue]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
#        elif is_screen_running; then
#            echo "This is on screen."
#        fi
#    else
#        if shell_has_started_interactively && ! is_ssh_running; then
#            if ! is_exists 'tmux'; then
#                echo 'Error: tmux command not found' 2>&1
#                return 1
#            fi
#
#            if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
#                # detached session exists
#                tmux list-sessions
#                echo -n "Tmux: attach? (y/N/num) "
#                read
#                if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
#                    tmux attach-session
#                    if [ $? -eq 0 ]; then
#                        echo "$(tmux -V) attached session"
#                        return 0
#                    fi
#                elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
#                    tmux attach -t "$REPLY"
#                    if [ $? -eq 0 ]; then
#                        echo "$(tmux -V) attached session"
#                        return 0
#                    fi
#                fi
#            fi
#
#            if is_osx && is_exists 'reattach-to-user-namespace'; then
#                # on OS X force tmux's default command
#                # to spawn a shell in the user's namespace
#                tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
#                tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
#            else
#                tmux new-session && echo "tmux created new session"
#            fi
#        fi
#    fi
#}
#tmux_automatically_attach_session

# cdrの設定
#------------------
# cdrを有効にする
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

# peco関連
#------------------
# tac commandがないときはtail -rで代用する
if which tac > /dev/null 2>&1; then
else
    alias tac='tail -r'
fi

# コマンド履歴検索
function peco-history-selection() {
    BUFFER=`history -n 1 | tac | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

function _get_hosts() {
    # historyを番号なし、逆順、ssh*にマッチするものを1番目から表示
    # 最後の項をhost名と仮定してhost部分を取り出す
    local hosts
    ssh_hist="$(history -nrm 'ssh*' 1 | \grep 'ssh ')"
    # hostnameよりも前にあるオプション user@ を削除
    # know_hostsからもホスト名を取り出す
    # portを指定したり、ip指定でsshしていると [hoge.com]:2222,[\d{3}.\d{3].\d{3}.\d{3}]:2222 といったものもあるのでそれにも対応している
    hosts="$(echo $ssh_hist | perl -pe 's/ssh(\s+-([1246AaCfGgKkMNnqsTtVvXxYy]|[^1246AaCfGgKkMNnqsTtVvXxYy]\s+\S+))*\s+(\S+@)?//' | cut -d' ' -f1)"
    hosts="$hosts\n$(cut -d' ' -f1  ~/.ssh/known_hosts | tr -d '[]' | tr ',' '\n' | cut -d: -f1)"
    hosts=$(echo $hosts | awk '!a[$0]++')
    echo $hosts
}

# 過去に行ったことのあるHostとknown_hostsに記載されているHostへのSSH
function peco-ssh() {
    hosts=`_get_hosts`
    local selected_host=$(echo $hosts | peco --prompt="ssh >" --query "$LBUFFER")
    if [ -n "$selected_host" ]; then
        BUFFER="ssh ${selected_host}"
        zle accept-line
    fi
}

# 過去に行ったことのあるディレクトリを検索して移動（上記のcdrの設定が必要）
function peco-cdr () {
    local selected_dir="$(cdr -l | sed 's/^[0-9]\+ \+//' | peco --prompt="cdr >" --query "$LBUFFER")"
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
}

# カレントディレクトリ以下のファイル検索（dotファイルを除く）
function peco-find() {
    local l=$(\find . -maxdepth 8 -a \! -regex '.*/\..*' | peco --prompt="find >" --query "$LBUFFER")
    BUFFER="${LBUFFER}${l}"
    CURSOR=$#BUFFER
    zle clear-screen
}

# カレントディレクトリ以下のファイル検索（dotファイルを含む）
function peco-find-all() {
    local l=$(\find . -maxdepth 8 | peco --prompt="find-all >" --query "$LBUFFER")
    BUFFER="${LBUFFER}${l}"
    CURSOR=$#BUFFER
    zle clear-screen
}

# プロセスを検索してpidを取得（主にkill用。危険なのでkiilは自分でうつ）
function peco-kill(){
    FILTERD=$(ps aux | peco --prompt="ps >" --query "$LBUFFER" | awk '{print $2}')
    BUFFER=${BUFFER}${FILTERD}
    CURSOR=$#BUFFER
#   --- Too dangerous!! ---
#    proc=`ps aux | peco`
#    pid=`echo "$proc" | awk '{print $2}'`
#    echo "kill pid:$pid. [$proc]"
#    kill $pid
}

# gitのコミットログを選択してhash値を取得
function git-hash(){
    FILTERD=$(git log --oneline --branches | peco | awk '{print $1}')
    BUFFER=${BUFFER}${FILTERD}
    CURSOR=$#BUFFER
}

# Pull Request ブランチへのチェックアウト
function peco-checkout-pull-request () {
    local selected_pr_id=$(gh pr list | peco | awk '{ print $1 }')
    if [ -n "$selected_pr_id" ]; then
        BUFFER="gh pr checkout ${selected_pr_id}"
        zle accept-line
    fi
    zle clear-screen
}

# gitのコミットログを選択してcherry-pick
function git-cherry-pick(){
    FILTERD=$(git log --oneline --branches | peco | awk '{print $1}')
    BUFFER=${BUFFER}"git cherry-pick "${FILTERD}
    CURSOR=$#BUFFER
    zle accept-line
    zle clear-screen
}

# git変更があったファイル名を取得
function git-changed-files(){
    FILTERD=$(git status --short | peco | awk '{print $2}')
    BUFFER=${BUFFER}${FILTERD}
    CURSOR=$#BUFFER
}

# remoteブランチ一覧からlocalブランチを作成してcheckout
function git-checkout-branch(){
    FILTERD=$(git branch -r --sort=-committerdate | tr -d ' ' | peco)
    BUFFER=${BUFFER}"git checkout "${FILTERD#*/}
    CURSOR=$#BUFFER
    zle accept-line
    zle clear-screen
}

# tmuxのsessionを選択してattach
function tmux-session-attach(){
    local session=$(tmux ls < /dev/null | peco | awk '{print $1}' | tr -d :)
    BUFFER="tmux a -t ${session}"
    zle accept-line
    zle clear-screen
}

# docker psをpecoで選択してCONTAINER IDを取得
function docker-ps(){
    FILTERD=$(docker ps -a | peco | awk '{print $1}')
    BUFFER=${BUFFER}${FILTERD}
    CURSOR=$#BUFFER
}

# docker psでCONTAINER IDを取得してそのコンテナに入る
function docker-exec(){
    local container_id=$(docker ps -a | peco | awk '{print $1}')
    BUFFER="docker exec -it $container_id bash"
    zle accept-line
    zle clear-screen
}

# docker imagesでIMAGE IDを取得してrm -fを入力
function docker-rmi(){
    FILTERD=$(docker images | peco | awk '{print $3}')
    BUFFER="docker rmi -f "${FILTERD}
    CURSOR=$#BUFFER
}

# kubectl get podでpod nameを取得してそのpodに入る
function kube-exec(){
    local pod_name=$(kubectl get pod -o wide | peco | awk '{print $1}')
    BUFFER="kubectl exec -it $pod_name bash"
    zle accept-line
    zle clear-screen
}

# kubectl get deployでdeployを取得してdeleteを入力
function kube-rm-deploy(){
    FILTERD=$(kubectl get deploy -o wide | peco | awk '{print $1}')
    BUFFER="kubectl delete deploy "${FILTERD}
    CURSOR=$#BUFFER
}

# kubectl get svcでserviceを取得してdeleteを入力
function kube-rm-service(){
    FILTERD=$(kubectl get svc -o wide | peco | awk '{print $1}')
    BUFFER="kubectl delete svc "${FILTERD}
    CURSOR=$#BUFFER
}

# peco関連のキーバインド
if [ -e /usr/local/bin/peco ]; then
    zle -N peco-history-selection
    bindkey '^r' peco-history-selection
    zle -N peco-cdr
    bindkey '^u^r' peco-cdr
    zle -N peco-find
    bindkey '^u^f' peco-find
    zle -N peco-find-all
    bindkey '^u^a' peco-find-all
    zle -N peco-kill
    bindkey '^u^k' peco-kill
    zle -N git-hash
    bindkey '^g^h' git-hash
    zle -N git-cherry-pick
    bindkey '^g^c' git-cherry-pick
    zle -N peco-checkout-pull-request
    bindkey "^g^p" peco-checkout-pull-request
    zle -N git-changed-files
    bindkey '^g^f' git-changed-files
    zle -N git-checkout-branch
    bindkey '^g^r' git-checkout-branch
    zle -N tmux-session-attach
    bindkey '^u^i' tmux-session-attach
    zle -N git-commit
    bindkey '^g^o' git-commit
    zle -N docker-ps
    bindkey '^o^p' docker-ps
    zle -N docker-exec
    bindkey '^o^e' docker-exec
    zle -N docker-rm
    bindkey '^o^k' docker-rm
    zle -N docker-rmi
    bindkey '^o^i' docker-rmi
    zle -N kube-exec
    bindkey '^@^e' kube-exec
    zle -N kube-rm-deploy
    bindkey '^@^k' kube-rm-deploy
    zle -N kube-rm-service
    bindkey '^@^i' kube-rm-service
fi

# pyenv読み込み
export PYENV_ROOT="/usr/local/var/pyenv"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# goenv読み込み
export PATH="$HOME/.goenv/bin:$PATH"
eval "$(goenv init -)"

# jenv読み込み
# jEnv
export JENV_ROOT="$HOME/.jenv"
if [ -d "${JENV_ROOT}" ]; then
  export PATH="$JENV_ROOT/bin:$PATH"
  eval "$(jenv init -)"
fi

# nodenv読み込み
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# Kubernetesの補完
source <(kubectl completion zsh)
complete -o default -F __start_kubectl k

# yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# rust
export PATH="$HOME/.cargo/bin:$PATH"
