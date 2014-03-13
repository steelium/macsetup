# go up n directories
function up() {
  str=""
  count=0
  if [ $# -eq 0 ]
  then
    cd ..
    return 0
  fi

  while [ "$count" -lt "$1" ];
  do
    str=$str"../"
    let count=count+1
  done
  cd $str
}

function mcd() {
  mkdir -p "$1" && cd "$1";
}

function removeSwpRecursive() {
  echo "Removing swp files"
  find . -name "*.swp" | xargs -I {} rm -v {}
}

alias adbrr='adb root && adb wait-for-device && adb remount'
function diffchanges() {
  git diff $1 -- `git diff --name-status --oneline $1 | grep "^M" | cut -f 2`
}

#Git aliases
alias "gs=git status"
alias "gst=git status"
alias "ga=git add"
alias "gb=git branch"
alias "gba=git branch -a"
alias "gchk=git checkout"
alias "gc=git commit -v"
alias "gca=git commit -va"
alias "gd=git diff"
alias "gf=git fetch"
alias "gpl=git pull"
alias "gp=git push"
alias "gru=git remote update"
alias "gr=git rebase"
alias "gh=git help"
alias "gdt=git difftool"
alias "gmt=git mergetool"
alias "gg=git log --decorate=short --graph"
alias "gl=git log --decorate=short"
alias "gcp=git cherry-pick"
alias "gash=git stash"

alias "grep=grep --color=auto"

alias base64encode='python -c "import base64,sys; base64.encode(sys.stdin,sys.stdout);"'
alias base64decode='python -c "import base64,sys; base64.decode(sys.stdin,sys.stdout);"'

bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward
bind '"\e[C"':forward-char
bind '"\e[D"':backward-char

# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
function json() {
    if [ -t 0 ]; then # argument
        python -mjson.tool <<< "$*" | pygmentize -l javascript
    else # pipe
        python -mjson.tool | pygmentize -l javascript
    fi
}

