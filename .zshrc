: "coreSetting" && {
  unsetopt BG_NICE
}

: "zplug" && {
  source ~/.zplug/init.zsh
  zplug 'zplug/zplug', hook-build:'zplug --self-manage'
  zplug "modules/prompt", from:prezto
  zstyle ':prezto:module:prompt' theme 'clint'
  zplug 'zsh-users/zsh-history-substring-search'
  zplug 'mollifier/anyframe'
  zplug 'junegunn/fzf-bin', from:gh-r, as:command, rename-to:fzf, use:'*linux_amd64*'
  zplug 'junegunn/fzf', as:command, use:'bin/fzf-tmux'
  zplug 'b4b4r07/enhancd', use:init.sh
  zplug 'zsh-users/zsh-syntax-highlighting', defer:2

  if ! zplug check --verbose; then
    printf "INSTALL? [y/N]:"
    if read -q; then
      echo; zplug install
    fi
  fi

  zplug load --verbose
}

: "majorSetting" && {
  setopt correct
  setopt nobeep
  setopt interactive_comments
}

: "keybind" && {
  bindkey -v
  : "cdup" && {
    function cd-up { zle push-line && LBUFFER='builtin cd ..' && zle accept-line }
    zle -N cd-up
    bindkey "^Y" cd-up
  }
}

: "history" && {
  HISTSIZE=10000
  SAVEHIST=10000
  HISTFILE=~/.zsh_history
  setopt hist_ignore_dups # 直前と同じコマンドをヒストリに追加しない
  setopt hist_ignore_all_dups # 重複するコマンドは古い法を削除する
  setopt share_history # 異なるウィンドウでコマンドヒストリを共有する
  setopt hist_no_store # historyコマンドは履歴に登録しない
  setopt hist_reduce_blanks # 余分な空白は詰めて記録
  setopt hist_verify # `!!`を実行したときにいきなり実行せずコマンドを見せる
}

: "completion" && {
  autoload -Uz compinit
  compinit
  
  zstyle ':completion:*' auto-description 'specify: %d'
  zstyle ':completion:*' completer _expand _complete _correct _approximate
  zstyle ':completion:*' format 'Completing %d'
  zstyle ':completion:*' group-name ''
  zstyle ':completion:*' menu select=2
  eval "$(dircolors -b)"
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  zstyle ':completion:*' list-colors ''
  zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
  zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
  zstyle ':completion:*' menu select=long
  zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
  zstyle ':completion:*' use-compctl false
  zstyle ':completion:*' verbose true
  
  zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
  zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

}

: "anyframe" && {
  zstyle ":anyframe:selector:" use fzf-tmux
  bindkey '^x^b' anyframe-widget-checkout-git-branch
  
  bindkey '^xr' anyframe-widget-execute-history
  bindkey '^x^r' anyframe-widget-execute-history
  
  bindkey '^xp' anyframe-widget-put-history
  bindkey '^x^p' anyframe-widget-put-history
  
  bindkey '^xg' anyframe-widget-cd-ghq-repository
  bindkey '^x^g' anyframe-widget-cd-ghq-repository
  
  bindkey '^xk' anyframe-widget-kill
  bindkey '^x^k' anyframe-widget-kill
  
  bindkey '^xi' anyframe-widget-insert-git-branch
  bindkey '^x^i' anyframe-widget-insert-git-branch
  
  bindkey '^xf' anyframe-widget-insert-filename
  bindkey '^x^f' anyframe-widget-insert-filename
}
