plugins=(git)

function gc {
  tag=$(echo $(current_branch) | grep -oh '[A-Z]\{2,3\}-[0-9]\{1,6\}')

  if [ "$tag" != "" ]; then
    msg="[$tag] $1"
  else
    msg=$1
    echo "Warning: No task tag found in branch name"
  fi

  git commit -m "$msg"
  echo "Commit message: $msg"
}

function ggpf {
  HUSKY_SKIP_HOOKS=1 g push --force-with-lease origin $(current_branch)
}

function gitignore {
  outfile='.gitignore'

  if [ -f $outfile ]; then
    outfile='.gitignore-copy'
  fi

  curl https://raw.githubusercontent.com/github/gitignore/master/Node.gitignore -o $outfile
}

function opencovreport {
  dir=${1:-.}
  (open $dir/coverage/lcov-report/index.html)
}

function tw {
  yarn run build:tailwind
}

function shorten {
  (cd ~/url-shortener && \
    node alias.js $@ && \
    git add . && \
    git commit -m "feat: Add alias for '$1'" && \
    git push -u origin main)
}

alias zshrc="code ~/.zshrc"

alias gs="git status"
alias gl="git log --oneline"

alias yae="yarn add --exact"
alias yade="yarn add --exact --dev"

alias l="exa --long --header --git"

alias y="yarn"
alias d="yarn run dev"
alias t="yarn run test"
alias tc="yarn run typecheck"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export PATH="/usr/local/go/bin:$PATH"
