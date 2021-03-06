echo "its working!"
# tab completion (from turing)
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
# 2nd tab completion (from https://github.com/bobthecow/git-flow-completion/wiki/Install-Bash-git-completion)
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# get current branch in git repo
function parse_git_branch() {
  BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  if [ ! "${BRANCH}" == "" ]
  then
    STAT=`parse_git_dirty`
    echo "[${BRANCH}${STAT}]"
  else
    echo ""
  fi
}

# get current status of git repo
function parse_git_dirty {
  status=`git status 2>&1 | tee`
  dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
  untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
  ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
  newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
  renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
  deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
  bits=''
  if [ "${renamed}" == "0" ]; then
    bits=">${bits}"
  fi
  if [ "${ahead}" == "0" ]; then
    bits="*${bits}"
  fi
  if [ "${newfile}" == "0" ]; then
    bits="+${bits}"
  fi
  if [ "${untracked}" == "0" ]; then
    bits="?${bits}"
  fi
  if [ "${deleted}" == "0" ]; then
    bits="x${bits}"
  fi
  if [ "${dirty}" == "0" ]; then
    bits="!${bits}"
  fi
  if [ ! "${bits}" == "" ]; then
    echo " ${bits}"
  else
    echo ""
  fi
}

export PS1="\u\w\`parse_git_branch\`$ "

# bundler from github
eval "$(rbenv init -)"

#shorten file_path to just current folder
# /Users/rossperry/documents/_turing_projects/notes/ruby-exercises
# /ruby-exercises

PS1='\W: '

# Git branch in prompt.

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

export PATH="/usr/local/opt/mongodb-community@3.6/bin:$PATH"

#open vs code from terminal
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Postgres path
# export PATH="/Applications/Postgres.app/Contents/Versions/12.3/bin:$PATH"
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"




# ========= ALIAS ===========
alias bers='bundle exec rspec'

# ==== GIT =====
alias be='bundle exec'
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gco='git checkout'
alias gp='git push origin HEAD'

# ==== db ====
alias db_reset='rake db:{drop,create,migrate,seed}'

# ==== bash ====
alias bash_reload='source ~/.bash_profile'



# reload terminal command
# $ source ~/.bash_profile

# python 
alias python="python3"
alias pip="pip3"
# Setting PATH for Python 3.9
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.9/bin:${PATH}"
export PATH

export PATH="$HOME/.poetry/bin:$PATH"
