     #__            __
    #/ /  ___ ____ / /  ________
 #_ / _ \/ _ `(_-</ _ \/ __/ __/
#(_)_.__/\_,_/___/_//_/_/  \__/

# Interactive only from this point forward
	[ -z "$PS1" ] && return

# internal bashrc functions
	__function_defined() {
		declare -f -F $1 > /dev/null
		return $?
	}

# cd is followed by ls automatically
	function cd {
		builtin cd "$@" > /dev/null && ls -hNF --color=auto --group-directories-first
	}

# Shell custom setup
	stty -ixon                               # unlock <C-S> and <C-Q> from N/XOFF flow control
	shopt -s autocd > /dev/null 2> /dev/null # Allows cd into directory by typing only the directory name.
	shopt -s globstar                        # Allows recursive globbing with **, **/ for dirs only
	shopt -s dirspell                        # Attempt spell correct on directories during completion
	shopt -s cdspell                         # Attempt spell correhon arguent to cd
	shopt -s cdable_vars                     # E.g. export foo="$HOME/foo"; cd /; cd foo
	shopt -s nocaseglob;                     # Caseo-insensitive globbing
	set -o noclobber                         # Prevent file overwrite on stdout redirect (use `>|` to force)
	PROMPT_DIRTRIM=2                         # Automatically trim long paths in prompt

# Tab Completion
	bind Space:magic-space                   # expand cmd history on trailing space, e.g. !!<space> is expanded
	bind "set completion-ignore-case on"     # Perform file completion in a case insensitive fashion
	bind "set completion-map-case on"        # Treat hyphens and underscores as equivalent
	bind "set show-all-if-ambiguous on"      # Display matches for ambiguous patterns at first tab press
	bind "set mark-symlinked-directories on" # Immediately add a trailing slash when autocompleting symlinks to directories

# Bash History
	shopt -s histappend         # Append to the history file, don't overwrite it
	shopt -s cmdhist            # Save multi-line commands as one command
	PROMPT_COMMAND='history -a' # Record each line as it gets issued
	HISTSIZE=50000
	HISTFILESIZE=10000
	HISTCONTROL="erasedups:ignoreboth"                                        # Avoid duplicate entries
	export HISTIGNORE="&:[ ]*:exit:la:pushd:popd:dirs:ls:bg:fg:history:clear" # Don't record some commands
	HISTTIMEFORMAT='%F %T '                                                   # Use standard ISO 8601 timestamp

# Enable incremental history search with up/down arrows (inc. Readline)[codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/]
	bind '"\e[A": history-search-backward'
	bind '"\e[B": history-search-forward'
	bind '"\e[C": forward-char'
	bind '"\e[D": backward-char'

# Setting bash prompt. Capitalizes username and host if root user
	if [ "$EUID" -ne 0 ]
		then export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
		else export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]ROOT\[$(tput setaf 2)\]@\[$(tput setaf 4)\]$(hostname | awk '{print toupper($0)}') \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
	fi

export GPG_TTY=$(tty)

# System Maintainence
	alias programs="(pacman -Qet && pacman -Qm) | sort -u" # List installed programs
	alias orphans="pacman -Qdt" # List orphan programs
	alias psref="gpg-connect-agent RELOADAGENT /bye" # Refresh gpg

# Some aliases
	alias q="exit"
	alias p="pacman --color always"
	alias sp="sudo pacman --color always"
	alias y="yaourt"
	alias SS="sudo systemctl"
	alias v="vim"
	alias sv="sudo vim"
	alias r="ranger"
	alias sr="sudo ranger"
	alias ka="killall"
	alias mkd="mkdir -pv"
	alias rf="source ~/.bashrc"
	alias refresh="shortcuts.sh && source ~/.bashrc" # Refresh shortcuts manually and reload bashrc
	alias bw="wal -i ~/.config/wall.png" # Rerun pywal
	alias dirs="dirs -v"

# git aliases (alias all git aliases globally with g prefix e.g. 'gs' and 'gca')
	alias g="git"
	complete -o bashdefault -o default -o nospace -F __git_wrap__git_main g
	for galias in `git --list-cmds=alias`; do
		alias g$galias="git $galias"
	done
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/completions/git
		for galias in `git --list-cmds=alias`; do
			complete_func=_git_$(__git_aliased_command $galias)
			__function_defined $complete_fnc && __git_complete g$galias $complete_func
		done
	fi

# Alternative to rm that moves files to hidden trash folder
	function trash {
		mkdir ~/.trash > /dev/null 2> /dev/null; mv "$@" ~/.trash
	}

# Adding color
	alias ls='ls -hNF --color=auto --group-directories-first'
	alias la='ls -hNaF --color=auto --group-directories-first'
	alias cat="highlight --out-format=xterm256 --force" #Color cat - print file with syntax highlighting.
	alias grep="grep --color=always" # Color highlight match.

# Youtube
	alias yt="youtube-viewer -C -7 --results=42"
	alias yts="youtube-viewer -C -7 --results=42 -SV"
	alias ytd="youtube-dl --add-metadata -ic" # Download video link
	alias yta="youtube-dl --add-metadata -xic" # Download only audio
	alias ethspeed="speedometer -r enp0s25"
	alias wifispeed="speedometer -r wlp3s0"

# Utils
	alias urlencode="perl -MURI::Escape -le 'print uri_escape <STDIN>'"

source ~/.shortcuts
