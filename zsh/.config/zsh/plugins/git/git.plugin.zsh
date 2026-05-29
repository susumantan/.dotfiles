function git_current_branch() {
  command git rev-parse --abbrev-ref HEAD
}

function git_develop_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in dev devel develop development; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return 0
    fi
  done

  echo develop
  return 1
}

function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,stable,master}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return 0
    fi
  done

  echo master
  return 1
}

function git_check_diff_commit() {
  command git rev-parse --is-inside-work-tree &>/dev/null || return
  git rev-list --left-right --pretty=oneline $1...$2
}

alias groot='cd "$(git rev-parse --show-toplevel || echo .)"'

alias g="git"
alias ga="git add"

alias gb="git branch"
alias gba="git branch -a"

alias gst="git status"

alias gcn!="git commit --verbose --no-edit --amend"
alias gcan!="git commit --verbose --all --no-edit --amend"


alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && git reset HEAD~1'

alias glogg="git log --color=always --oneline --graph --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias glog="git log --color=always --oneline --date=short --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"

alias gfo="git fetch origin"
alias gl="git pull"
alias glo='git pull origin $(git_current_branch)'
alias gpush="git push"
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gpsupf='git push --set-upstream origin $(git_current_branch) --force-with-lease'

alias gsw="git switch"
alias gswd='git switch $(git_develop_branch)'
alias gswm='git switch $(git_main_branch)'
alias gco="git checkout"

alias groll='git reset --hard origin/$(git_current_branch)'
alias gclean="git reset --hard HEAD && git clean -df"
alias gpristine='git reset --hard && git clean -dfx'

alias ggzip='git archive --format zip --output /tmp/latest.zip HEAD'
