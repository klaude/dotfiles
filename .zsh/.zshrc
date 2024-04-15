local BREW_PREFIX='/home/linuxbrew/.linuxbrew'
local ZDOTDIR='/home/me/.zsh'

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

# Functions
#--------------------

# Get the current directory with only the parts I need. Needed to set the 
# current directory in both the prompt and the terminal title.
new_dir() {
  # Return "~" if we're in the home directory
  if [[ "${PWD}" = "${HOME}" ]]; then
    print '~'
    return
  fi

  # Any argument passed in will substitue the home directory for "~". Use this
  # when setting the window and tab title to a less cluttered $PWD.
  if [[ -n "${1}" ]]; then
    print $(echo "${PWD}" | sed "s|^${HOME}|~|")
    return
  fi

  # Otherwise return the last part of the directory. Use this when setting the
  # current directory in the prompt.
  local -a parts=("${(s:/:)PWD}")
  print "${parts[-1]}"
}

# Set the window and tab title
title() {
  print -Pn "\e]2;${1:q}\a" # set window name
  print -Pn "\e]1;${1:q}\a" # set tab name
}

# Set the tab and window title to the current directory
function hook_set_title_current_dir {
  title "$(eval new_dir '1')"
}

# Set the tab and window title to the running process
function hook_set_title_process {
  title "$2"
}

# Connect to an old employer's VPN. It supports push notifications for MFA. I
# keep this around so I don't forget how to do this.
# function myoldcompany_vpn() {
#	  sudo echo -n "ADFS Password: "
#	  read -s REPLY
#	  echo
#	  printf "%s\n%s" "$REPLY" "push" | sudo openconnect --syslog --user=${USER} --passwd-on-stdin $1.myoldcompany.org 2>&1
#	  #printf "%s\n%s" "$REPLY" "push" | sudo openconnect --background --quiet --syslog --user=${USER} --passwd-on-stdin $1.myoldcompany.org 2>&1
# }

# Shell Options
#--------------------
# zshoptions(1)  /  http://zsh.sourceforge.net/Doc/Release/Options.html

# Changing Directories
# setopt auto_pushd        # cd is really pushd
# setopt chase_dots        # Resolve `..` directories to their true location
# setopt chase_links       # Resolve links to their true location
# setopt pushd_ignore_dups # Don't put duplicates on the directory stack
# setopt pushd_minus       # Make `cd -1` go to the previous directory, etc
# setopt pushd_to_home     # pushd with no arguments goes home, like cd

# Completion
setopt auto_name_dirs    # Parameters set to a path can be used as ~param
setopt auto_remove_slash # Remove trailing slash if next char is a word delim
setopt hash_list_all     # Before completion, make sure entire path is hashed
setopt glob_complete     # Expand globs upon completion
setopt complete_in_word  # Completions happen at the cursor's location

# Expansion and Globbing
setopt glob          # Perform filename generation (i.e. the use of the * operator)
setopt extended_glob # Use additional glob operators
setopt glob_dots     # Glob dotfiles
setopt nomatch       # If a glob fails, the command isn't executed
unsetopt caseglob

# History
setopt hist_ignore_all_dups # Ignore all duplicates when writing history
setopt hist_ignore_space    # Ignore commands that begin with spaces
setopt inc_append_history   # Write commands to history file as soon as possible

# Input/Output
setopt correct              # Try to correct the spelling of commands
setopt interactive_comments # Allow comments in interactive shells

# Prompting
setopt prompt_cr    # Print a \r before the prompt
setopt prompt_sp    # Preserve lines that would be covered by the \r
setopt prompt_subst # Substitute in parameter/command/arithmetic expansions

LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.t
az=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31
:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab
=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.ti
f=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.
vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;
35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#
=00;90:*.bak=00;90:*.crdownload=00;90:*.dpkg-dist=00;90:*.dpkg-new=00;90:*.dpkg-old=00;90:*.dpkg-tmp=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:*.swp=00;90:*.tm
p=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:';
export LS_COLORS

# Paths
#--------------------

typeset -U path manpath fpath #cdpath

path=(
  "${HOME}/bin"
  "${BREW_PREFIX}/bin"
  "${BREW_PREFIX}/sbin"
  "/usr/local/bin"
  "/usr/local/sbin"
  ${path}
)

manpath=(
  "${BREW_PREFIX}/share/man"
  "/usr/man"
  "/usr/share/man"
  "/usr/local/share/man"
  "/usr/local/man"
  "/usr/X11R6/man"
  "/opt/man"
  ${manpath}
)

fpath=(
  "${ZDOTDIR}/functions"
  "${BREW_PREFIX}/share/zsh-completions"
  ${fpath}
)

# cdpath=(
#   ${(ef)"$(cat ${ZDOTDIR}/paths/cdpaths 2> /dev/null)"}
#   ${(ef)"$(cat /etc/cdpaths 2> /dev/null)"}
#   ${cdpath}
# )

export path manpath fpath #cdpath

# Aliases
#--------------------

alias ls="ls --color=auto"
alias grep="grep --extended-regexp --no-messages --binary-files=without-match --color"

# Environment
#--------------------

# Core tools
EDITOR="vim"
VISUAL="vim"
PAGER="less"
export EDITOR VISUAL PAGER

# History
#--------------------

HISTSIZE=2000
HISTFILE=${ZDOTDIR}/.history
SAVEHIST=$HISTSIZE
export HISTSIZE HISTFILE SAVEHIST

# Keyboard
#--------------------

if [[ ! -f ${ZDOTDIR}/zkbd/${TERM} ]]; then
  autoload -Uz zkbd
  zkbd
  source ${ZDOTDIR}/zkbd/${TERM}
fi

bindkey -e
[[ -n "${key[Home]}"       ]] && bindkey "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"        ]] && bindkey "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"     ]] && bindkey "${key[Insert]}"     overwrite-mode
[[ -n "${key[Delete]}"     ]] && bindkey "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"         ]] && bindkey "${key[Up]}"         up-line-or-search
[[ -n "${key[Down]}"       ]] && bindkey "${key[Down]}"       down-line-or-search
[[ -n "${key[Left]}"       ]] && bindkey "${key[Left]}"       backward-char
[[ -n "${key[Right]}"      ]] && bindkey "${key[Right]}"      forward-char
[[ -n "${key[Ctrl-Left]}"  ]] && bindkey "${key[Ctrl-Left]}"  backward-word
[[ -n "${key[Ctrl-Right]}" ]] && bindkey "${key[Ctrl-Right]}" forward-word

# Completion
#--------------------

autoload -Uz compinit && compinit -i -d ${ZDOTDIR}/zcompdump

# Tab completion from both ends.
setopt completeinword

zstyle ':completion:*' use-cache true                         # Cache completion to `${ZDOTDIR}/.zcompcache`
zstyle ':completion:*' menu select                            # Make the menu interactive with arrow keys
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'     # Tab completion should be case-insensitive.
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd' # Better completion for killall.

bindkey '^I' menu-expand-or-complete
bindkey '^[[Z' reverse-menu-complete

# Customizations
#--------------------

source ${BREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${BREW_PREFIX}/share/powerlevel10k/powerlevel10k.zsh-theme
source ~/.zsh/.p10k.zsh

# Set the window and tab title to the current running process then the current
# directory.
add-zsh-hook chpwd hook_set_title_current_dir
add-zsh-hook precmd hook_set_title_current_dir
add-zsh-hook preexec hook_set_title_process

# Startup
#--------------------

# Keep Homebrew working!
export HOMEBREW_GITHUB_API_TOKEN="hin hin hin hin"

# Bootstrap asdf
# . ${BREW_PREFIX}/opt/asdf/libexec/asdf.sh

# Bootstrap dotnet
# . ${HOME}/.asdf/plugins/dotnet/set-dotnet-env.zsh
