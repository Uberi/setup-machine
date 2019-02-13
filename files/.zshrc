#####################
# ZSH configuration #
#####################

# setup zgen and use it to install oh-my-zsh and zsh-completions
source /usr/share/zgen/zgen.zsh
if ! zgen saved; then
    zgen oh-my-zsh
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/command-not-found
    zgen load zsh-users/zsh-completions src
    zgen load lukechilds/zsh-nvm
    zgen save
fi

# setup oh-my-zsh
DISABLE_AUTO_UPDATE=true

# setup powerline
PATH="$HOME/.local/bin:$PATH"
source /usr/share/powerline/bindings/zsh/powerline.zsh

# setup zsh-syntax-highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# misc. config options
source ~/Dropbox/000-configuration/SCRIPTS_CONFIG.sh

# setup thefuck
eval "$(thefuck --alias)"

# setup virtualenvwrapper
export WORKON_HOME=~/.virtualenvwrapper
mkdir --parents "$WORKON_HOME"
source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
alias 'va=mkvirtualenv "--python=$(which python3)" ${PWD##*/}' # create virtualenv for current folder name
alias 'v+=workon ${PWD##*/}' # activate virtualenv for current folder name
alias 'v-=deactivate' # deactivate currently activated virtualenv

# generally useful aliases
alias 'l=ls -l --all --human-readable'
alias 'clip=xclip -selection c'
alias 's=grep --line-number --dereference-recursive --binary-files=without-match'
alias 'f=find -name'
alias 'disk-usage=du -shc'
alias 'network-status=sudo netstat -peanut'
alias 'shell-history=fc -li 1' # shell history with dates
alias 'changed-files=find . -type f -print0 | xargs -0 stat --format "%Z :%z %n" | sort -nr | cut -d: -f2- | head -n 50' # most recently changed 50 files

# useful archiving aliases
alias 'archive-tgz=tar --create --gzip --verbose --file' # `archive-tgz TGZ_FILE_TO_CREATE FILES*`
alias 'archive-tar=tar --create --verbose --file' # `archive-tgz TAR_FILE_TO_CREATE FILES*`
alias 'archive-zip=zip -v' # `archive-zip ZIP_FILE_TO_CREATE FILES*`
alias 'unarchive-tgz=tar --extract --gzip --verbose --file' # `unarchive-tgz TGZ_FILE_TO_EXTRACT`
alias 'unarchive-tar=tar --extract --verbose --file' # `unarchive-tar TAR_FILE_TO_EXTRACT`
alias 'unarchive-zip=unzip -v' # `unarchive-zip ZIP_FILE_TO_EXTRACT`

# useful Git aliases; short for fast, efficient Git workflow
alias 'gl=git log --graph --all --decorate'
alias 'gp=echo $GITHUB_PASS | clip && git push'
alias 'gpgl=echo $GITLAB_PASS | clip && git push'
alias 'gcl=echo $GITHUB_PASS | clip && git clone'
alias 'gclgl=echo $GITLAB_PASS | clip && git clone'
alias 'gf=echo $GITHUB_PASS | clip && git fetch --all'
alias 'gfgl=echo $GITLAB_PASS | clip && git fetch --all'
alias 'gu=echo $GITHUB_PASS | clip && git pull'
alias 'gugl=echo $GITLAB_PASS | clip && git pull'
alias 'gur=echo $GITHUB_PASS | clip && git pull --rebase'
alias 'gurgl=echo $GITLAB_PASS | clip && git pull --rebase'
alias 'gb=git branch'
alias 'gs=git status'
alias 'gd=git diff'
alias 'gdc=git diff --cached'
alias 'ga=git add'
alias 'gau=git add --update'
alias 'gc=git commit'
alias 'gcm=git commit -m'
alias 'gk=git checkout'
alias 'gr=git reset'
alias 'grb=git rebase'
alias 'gt=git tag -s'
alias 'groot=cd $(git rev-parse --show-toplevel)'  # go to root level of the current git repo
alias 'gbranches=git for-each-ref --sort=-authordate --format "%(authordate:iso) %(align:left,25)%(refname:short)%(end) %(subject)" refs/heads'

# ssh-agent management - use `gssh` in a shell to start a shell-specific SSH-agent, it will get cleaned up automatically when the shell stops
alias 'gssh=eval "$(ssh-agent -s)"; ssh-add ~/.ssh/id_rsa'
function cleanup_ssh_agent {
    # remove ssh-agent instance if present
    if [ -n "$SSH_AUTH_SOCK" ] ; then
        eval `/usr/bin/ssh-agent -k`
        echo 'Cleaning up ssh-agent for this terminal.'
    fi
}
trap cleanup_ssh_agent EXIT

# useful GPG aliases; they aren't necessarily shorter, but they're easier to remember and can be tab completed
alias 'gpg-import=gpg --keyserver keyserver.ubuntu.com --recv-keys' # `gpg-import KEY_IDENTIFIER`
alias 'gpg-search=gpg --keyserver keyserver.ubuntu.com --search-keys' # `gpg-search KEY_IDENTIFIER`
alias 'gpg-verify=gpg --verify' # `gpg-verify SIGNATURE_FILE SIGNED_FILE`
alias 'gpg-edit-key=gpg --edit-key' # `gpg-edit-key KEY_IDENTIFIER`
alias 'gpg-sign=gpg --sign' # `gpg-sign`, then enter message, press Enter then Ctrl+D
alias 'gpg-encrypt=gpg --encrypt --armor -r' # `gpg-encrypt KEY_IDENTIFIER` (KEY_IDENTIFIER is for the recipient), then enter message, press Enter and Ctrl+D
alias 'gpg-decrypt=gpg --decrypt' # `gpg-decrypt`, then enter message, press Enter and Ctrl+D
alias 'gpg-check-signature=gpg --verify' # `gpg-check-signature SIGNATURE_FILE`, or `gpg-check-signature SIGNATURE_FILE DATA_FILE` if `SIGNATURE_FILE` is not just `DATA_FILE.asc`
alias 'gpg-list=gpg --fingerprint --fingerprint --list-keys' # `gpg-list`, or gpg-list KEY_IDENTIFIER
alias 'gpg-send=gpg --keyserver keyserver.ubuntu.com --send-keys' # gpg-send KEY_IDENTIFIER
alias 'gpg-show=gpg --fingerprint --fingerprint' # gpg-show KEY_IDENTIFIER
alias 'gpg-delete=gpg --delete-keys' # gpg-delete KEY_IDENTIFIER

# user-specific aliases
alias 'run-hdd-backup=rsync --archive --verbose --human-readable --progress --update --delete "/home/az/Dropbox" "/media/az/Backup"'
alias 'run-usb-backup=rsync --archive --verbose --human-readable --progress --update --delete "/home/az/Dropbox" "/media/az/BackupUSB"'
alias 'sync-music=rsync --archive  --verbose --human-readable --progress --update --delete "/home/az/Dropbox/Music" "/media/az/Windows8_OS/Users/mozilla/Desktop"'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/az/google-cloud-sdk/path.zsh.inc' ]; then source '/home/az/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/az/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/az/google-cloud-sdk/completion.zsh.inc'; fi

# added by Miniconda3 installer
export PATH="/home/az/miniconda3/bin:$PATH"