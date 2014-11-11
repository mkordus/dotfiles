setopt PROMPT_SUBST

function git_prompt_info {
  local ref=$(=git symbolic-ref HEAD 2> /dev/null)
  local gitst="$(=git status 2> /dev/null)"
  local pairname=${${${GIT_AUTHOR_EMAIL#pair+}%@github.com}//+/\/}
  if [[ ${pairname} == 'ch' || ${pairname} == '' ]]; then
    pairname=''
  else
    pairname=" ($pairname)"
  fi

  if [[ -f .git/MERGE_HEAD ]]; then
    if [[ ${gitst} =~ "unmerged" ]]; then
      gitstatus=" %{$fg[red]%}unmerged%{$reset_color%}"
    else
      gitstatus=" %{$fg[green]%}merged%{$reset_color%}"
    fi
  elif [[ ${gitst} =~ "Changes to be committed" ]]; then
    gitstatus=" %{$fg_bold[blue]%}!%{$reset_color%}"
  elif [[ ${gitst} =~ "use \"git add" ]]; then
    gitstatus=" %{$fg_bold[red]%}!%{$reset_color%}"
  elif [[ -n `git checkout HEAD 2> /dev/null | grep ahead` ]]; then
    gitstatus=" %{$fg_bold[yellow]%}*%{$reset_color%}"
  else
    gitstatus=''
  fi

  if [[ -n $ref ]]; then
    echo "%{$fg_bold[green]%} ${ref#refs/heads/}%{$reset_color%}$gitstatus$pairname"
  fi
}

NEW_LINE=$'\n'
INSERT_MODE="%B%F{red}❯%F{yellow}❯%F{green}❯%f%b"
NORMAL_MODE="%B%F{green}❮%F{yellow}❮%F{red}❮%f%b"

vim_ins_mode="%B%F{red}❯%F{yellow}❯%F{green}❯%f%b"
vim_cmd_mode="%B%F{green}❮%F{yellow}❮%F{red}❮%f%b"
vim_mode=$vim_ins_mode

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

function TRAPINT() {
  vim_mode=$vim_ins_mode
  return $(( 128 + $1 ))
}

PROMPT='${NEW_LINE}%{$fg_bold[blue]%}%~%{$reset_color%}%<<$(git_prompt_info)${NEW_LINE}${vim_mode}%{${reset_color}%} '

