#####################
# ZSH configuration #
#####################

# setup oh-my-zsh
ZSH_THEME=agnoster
DISABLE_AUTO_UPDATE=true

# setup zgen and use it to install oh-my-zsh and zsh-completions
source /usr/share/zgen/zgen.zsh
if ! zgen saved; then
    zgen oh-my-zsh
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/wd
    zgen oh-my-zsh plugins/command-not-found
    zgen load zsh-users/zsh-completions src
    zgen save
fi

# setup powerline
PATH="$HOME/.local/bin:$PATH"
source /usr/share/powerline/bindings/zsh/powerline.zsh

# setup zsh-syntax-highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# misc. config options
source ~/Dropbox/000-configuration/SCRIPTS_CONFIG.sh

# generally useful aliases
alias 'c=cat'
alias 'l=ls -l --all --human-readable --color'
alias 'clip=xclip -selection c'
alias 's=grep --line-number --dereference-recursive --binary-files=without-match'
alias 'f=find -name'
alias 'disk-usage=du -shc'
alias 'network-status=sudo netstat -peanut'
alias 'shell-history=fc -li 1' # shell history with dates
alias 'changed-files=find . -type f -print0 | xargs -0 stat --format "%Z :%z %n" | sort -nr | cut -d: -f2- | head -n 50' # most recently changed 50 files in the current folder
alias 'flatten=mv ./*/**/*(.D) .'
alias 'notif=notify-send "Completed!" "The long-running operation just completed"'
alias 'docker-clean-logs=sudo sh -c "truncate -s 0 /var/lib/docker/containers/*/*-json.log"'

# useful archiving aliases
alias 'archive-tgz=tar --create --gzip --verbose --file' # `archive-tgz TGZ_FILE_TO_CREATE FILES*`
alias 'archive-tar=tar --create --verbose --file' # `archive-tgz TAR_FILE_TO_CREATE FILES*`
alias 'archive-zip=zip -v' # `archive-zip ZIP_FILE_TO_CREATE FILES*`
alias 'unarchive-tgz=tar --extract --gzip --verbose --file' # `unarchive-tgz TGZ_FILE_TO_EXTRACT`
alias 'unarchive-tar=tar --extract --verbose --file' # `unarchive-tar TAR_FILE_TO_EXTRACT`
alias 'unarchive-zip=unzip -v' # `unarchive-zip ZIP_FILE_TO_EXTRACT`

# useful Git aliases; short for fast, efficient Git workflow (based on actual usage history of git commands)
alias 'gl=git log --graph --all --decorate --date=local'
alias 'gp=git push'
alias 'gph=git push origin HEAD'
alias 'gpf=git push --force-with-lease origin HEAD'
alias 'gcl=git clone'
alias 'gf=git fetch --all'
alias 'gu=git pull'
alias 'gur=git pull --rebase'
alias 'gb=git branch'
alias 'gbd=git branch --delete'
alias "gbl=git for-each-ref refs/heads --color=always --sort -committerdate --format='%(HEAD)%(color:reset);%(color:yellow)%(refname:short)%(color:reset);%(contents:subject);%(color:green)(%(committerdate:relative))%(color:blue);<%(authorname)>' | column -t -s ';'"  # show branches ordered by most recently modified
alias 'gs=git status'
alias 'gsh=git show'
alias 'gd=DELTA_FEATURES=side-by-side git diff'
alias 'gdc=DELTA_FEATURES=side-by-side git diff --cached'
alias 'gdw=git diff'
alias 'gdcw=git diff --cached'
alias 'gdt=git difftool --dir-diff --tool=meld --no-prompt'
alias 'gdtc=git difftool --cached --dir-diff --tool=meld --no-prompt'
alias 'ga=git add'
alias 'gau=git add --update'
alias 'gc=git commit'
alias 'gcm=git commit -m'
alias 'gk=git checkout'
alias 'gkb=git checkout -b'
alias 'gr=git reset'
alias 'grh=git reset --hard'
alias 'grm=git rm'
alias 'grb=git rebase'
alias 'grbi=git rebase --interactive'
alias 'gt=git tag -s'
alias 'gt=git tag --list'
alias 'grem=git remote'
alias 'gh=git stash'
alias 'ghp=git stash pop'
alias 'ghl=git stash list'
alias 'ghist=git log --follow -p --stat --' # show the full history of a file, including renames and diffs for each change
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

# arduino-specific aliases
alias 'arduino-nano-verify=arduino-cli compile --fqbn arduino:avr:nano --warnings all'
alias 'arduino-nano-upload=arduino-cli compile --fqbn arduino:avr:nano --upload --port /dev/ttyUSB0'

# random generation
alias rand-token='echo $(head -c 16 /dev/urandom | xxd -p -c1000)'
alias rand-password='grep -v "['"'"'A-Z]" /usr/share/dict/american-english | shuf -n5 | paste -sd " " -'

# development-mode postgres, stores all data in the current directory under "__POSTGRESQL_DATA__", run it in one terminal then connect in another using `psql postgresql://postgres:postgres@localhost:5432/postgres`
alias 'devpostgres=docker run -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -v $(pwd)/__POSTGRESQL_DATA__:/var/lib/postgresql/data --network host postgres'

# user-specific aliases
alias 'run-hdd-backup=rsync --archive --verbose --human-readable --progress --update --delete --exclude=node_modules --exclude=Dropbox/.vscode --exclude=__pycache__ --exclude=.mypy_cache --exclude=.transformers --exclude=venv --exclude=vendor "/home/az/Dropbox" "/media/az/Backup"'
alias 'run-usb-backup=rsync --archive --verbose --human-readable --progress --update --delete --exclude=node_modules --exclude=Dropbox/.vscode --exclude=__pycache__ --exclude=.mypy_cache --exclude=.transformers --exclude=venv --exclude=vendor "/home/az/Dropbox" "/media/az/BackupUSB"'
alias 'sync-hyplabs-gdrive=rclone copy --progress hyplabs: ~/Dropbox/Hypotenuse/GDrive --drive-alternate-export'
alias 'notif-listen=while true; do if [ -f .devenv-notify ]; then rm .devenv-notify; notify-send "Completed!" "The long-running operation just completed"; fi; sleep 3; done'  # supports the `notif` command in devenv, which just does `touch .devenv-notify`
alias 'clip-listen=while true; do if [ -f .devenv-clipboard ]; then cat .devenv-clipboard | xclip -selection c; rm .devenv-clipboard; notify-send "Copied!" "Value was copied to clipboard"; fi; sleep 3; done'  # supports the `notif` command in devenv, which just does `tee $HOME/app/.devenv-clipboard`

source /home/az/.config/broot/launcher/bash/br
