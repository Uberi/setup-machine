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
    zgen save
fi

# setup powerline
PATH="$HOME/.local/bin:$PATH"
source /usr/share/powerline/bindings/zsh/powerline.zsh

# setup zsh-syntax-highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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

# useful archiving aliases
alias 'archive-tgz=tar --create --gzip --verbose --file' # `archive-tgz TGZ_FILE_TO_CREATE FILES*`
alias 'archive-tar=tar --create --verbose --file' # `archive-tgz TAR_FILE_TO_CREATE FILES*`
alias 'archive-zip=zip -v' # `archive-zip ZIP_FILE_TO_CREATE FILES*`
alias 'unarchive-tgz=tar --extract --gzip --verbose --file' # `unarchive-tgz TGZ_FILE_TO_EXTRACT`
alias 'unarchive-tar=tar --extract --verbose --file' # `unarchive-tar TAR_FILE_TO_EXTRACT`
alias 'unarchive-zip=unzip -v' # `unarchive-zip ZIP_FILE_TO_EXTRACT`

# useful Git aliases; short for fast, efficient Git workflow
alias 'gl=git log --graph --all --decorate'
alias 'gp=clip ~/Desktop/GitHub-token.txt && git push'
alias 'gcl=clip ~/Desktop/GitHub-token.txt && git clone'
alias 'gf=git fetch --all'
alias 'gu=git pull'
alias 'gur=git pull --rebase'
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
alias 'gt=git tag -s'

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