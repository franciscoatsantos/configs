# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"



###################### Personal
# General stuff
alias c='clear'
# Configuration files
alias zrc='code ~/.zshrc'
alias sz='source ~/.zshrc'
alias python='python3'
######################  Valispace
alias sv='source env/bin/activate'
#alias svStaging='source ~/Valispace/vali/staging/bin/activate'
alias cv='cdv;sv;code .'
#Workspace Vali
alias cdv='cd ~/valispace/repos/vali/backend'
alias cdf='cd ~/valispace/repos/vali/frontend'
# Workspace Engine
alias cde='cd ~/valispace/repos/valiengine/backend/'
# Start PostSQL
alias vp='sudo service postgresql start'
alias db='sudo su postgres;psql -U postgres'
# Restart Redis
alias rs='sudo service redis-server restart'
# Start PostSQL & Redis
alias vs='vp;rs'
# Migrate
alias mg='python manage.py migrate'

######################  Workspace
# Old Workers
#alias wk='sv;cdv;python manage.py runworker app notifications heavy'
# New Celery Workers
alias wk='cdv;celery -A vali.settings worker -B'
alias be='cdv;python manage.py runserver'
alias fe='cdf;npm start'
alias vd='cdv;python manage.py debug'

# Valiengine
alias eng='cde;python manage.py runserver 8002'
alias engwk='cde;celery -A settings worker'

#alias wkStaging='svStaging;cdv;celery -A vali.settings worker -B'
#alias beStaging='svStaging;cdv;python manage.py runserver'
#alias feStaging='svStaging;cd ~/Valispace/vali/vali/vali/frontend;npm start'
#alias vdStaging='svStaging;cdv;python manage.py debug'

#### Funtion to load python env
function load_venv(){
  ## Default path to virtualenv in your projects
  DEFAULT_ENV_PATH="./env"

  ## If env folder is found then activate the vitualenv
  function activate_venv() {
#    echo "Check"
    if [[ -f "${DEFAULT_ENV_PATH}/bin/activate" ]] ; then
      source "${DEFAULT_ENV_PATH}/bin/activate"
      echo "Activating ${VIRTUAL_ENV}"
    fi
  }
 # echo $VIRTUAL_ENV
  if [[ -z "$VIRTUAL_ENV" ]] ; then
    activate_venv
  else
    ## check the current folder belong to earlier VIRTUAL_ENV folder
    # if yes then do nothing
    # else deactivate then run a new env folder check
#       echo "else"
      parentdir="$(dirname ${VIRTUAL_ENV})"
      if [[ "$PWD"/ != "$parentdir"/* ]] ; then
        echo "Deactivating ${VIRTUAL_ENV}"
        deactivate
        activate_venv
      fi
  fi
}


# auto activate virtualenv
# Modified solution based on https://stackoverflow.com/questions/45216663/how-to-automatically-activate-virtualenvs-when-cding-into-a-directory/56309$
function cd() {
  builtin cd "$@"

  load_venv
}
export PATH="/opt/homebrew/opt/python@3.10/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


# Load Angular CLI autocompletion.
source <(ng completion script)
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export DOCKER_DEFAULT_PLATFORM=linux/amd64
