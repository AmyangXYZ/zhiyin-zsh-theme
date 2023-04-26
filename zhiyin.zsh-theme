# Clean, simple, compatible and meaningful.
# Tested on Linux, Unix and Windows under ANSI colors.
# It is recommended to use with a dark background.
# Colors: black, red, green, yellow, *blue, magenta, cyan, and white.
#
# Mar 2013 Yad Smood

# VCS
YS_VCS_PROMPT_PREFIX1=" %{$fg[white]%}on%{$reset_color%} "
YS_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}x"
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}o"

# Git info
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}git${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"

# HG info
local hg_info='$(ys_hg_prompt_info)'
ys_hg_prompt_info() {
	# make sure this is a hg dir
	if [ -d '.hg' ]; then
		echo -n "${YS_VCS_PROMPT_PREFIX1}hg${YS_VCS_PROMPT_PREFIX2}"
		echo -n $(hg branch 2>/dev/null)
		if [ -n "$(hg status 2>/dev/null)" ]; then
			echo -n "$YS_VCS_PROMPT_DIRTY"
		else
			echo -n "$YS_VCS_PROMPT_CLEAN"
		fi
		echo -n "$YS_VCS_PROMPT_SUFFIX"
	fi
}

local exit_code="%(?,,C:%{$fg[red]%}%?%{$reset_color%})"

# Prompt format:
#
# PRIVILEGES USER @ MACHINE in DIRECTORY on git:BRANCH STATE [TIME] C:LAST_EXIT_CODE
# $ COMMAND
#
# For example:
#
# % ys @ ys-mbp in ~/.oh-my-zsh on git:master x [21:47:42] C:0
# $
PROMPT="
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%(#,%{$bg[yellow]%}%{$fg[black]%}%n%{$reset_color%},%{$fg[cyan]%}%n) \
%{$fg[white]%}@ \
%{$fg[green]%}%m \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}%~%{$reset_color%}\
${hg_info}\
${git_info}\
 \
%{$fg[white]%}[%*] $exit_code
%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"


psanimate_stop() {
  touch /tmp/psanimatepid-$$
  PID=`cat /tmp/psanimatepid-$$`
  if [[ ! -z "$PID" ]]
    then
    (kill $PID > /dev/null 2>&1)
  fi
  rm /tmp/psanimatepid-$$
  return 0
}

psanimate() {
  SLEEP_TIMER=${1:-'1'}
  psanimate_stop
  _ps_emoji_animation() {
	counter=0
	increment=true
    S="\033[s"
    U="\033[u"
    while [ : ]
    do
      hex=$(printf "%02X" $counter)
  	  Zhiyin="\uE9${hex}"
      POS="\033[1000D"
      eval echo -ne '$S$POS$Zhiyin $U'

      # Update the counter and check the bounds
      if $increment; then
      ((counter++))
      if [ $counter -eq 17 ]; then
      increment=false
      ((counter--))
      fi
      else
      ((counter--))
      if [ $counter -eq -1 ]; then
      increment=true
      ((counter++))
      fi
      fi

      sleep $SLEEP_TIMER
    done
  }
  (_ps_emoji_animation & ; echo "$!" > /tmp/psanimatepid-$$)
  return 0
}

function pscleanup {
  echo "Cleaning the animation stuff"
  psanimate_stop
  unset PS_TASK_OVER
}

trap pscleanup EXIT