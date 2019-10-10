RED=$'\1'$(tput setaf 1)$'\2'
GREEN=$'\1'$(tput setaf 2)$'\2'
YELLOW=$'\1'$(tput setaf 11)$'\2'
CYAN=$'\1'$(tput setaf 14)$'\2'
MAGENTA=$'\1'$(tput setaf 5)$'\2'
BLUE=$'\1'$(tput setaf 4)$'\2'
NC=$'\1'$(tput sgr0)$'\2'
color () { echo -e "${1}${2}${NC}"; }
red () { color ${RED} ${1}; }
green () { color ${GREEN} ${1}; }
yellow () { color ${YELLOW} ${1}; }
cyan () { color ${CYAN} ${1}; }
magenta () { color ${MAGENTA} ${1}; }

is_git_branch () { [[ -d .git ]] || git rev-parse --git-dir > /dev/null 2>&1; }
function get_git_branch () { git branch 2>/dev/null | cut -f 2 -d ' '; }

function prompt () {
  local exit_status=$?
  if [[ ${exit_status} == 0 ]]; then
    local return_status_smiley="$(green ":)")"
  else
    local return_status_smiley="$(red ":(")"
  fi
  local dir_info=""
  if is_git_branch; then
    dir_info="$(yellow "git")"
    dir_info="${dir_info}:$(magenta "("$(get_git_branch)")")"
    dir_info="${dir_info}:$(cyan "//"$(git rev-parse --show-prefix))"
  else
    dir_info="$(cyan $(dirs))"
  fi
  echo "[ ${dir_info} ${return_status_smiley} ] $ "
}

export PS1='$(prompt)'
