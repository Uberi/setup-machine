setup-machine
-------------

[Ansible](https://www.ansible.com/) playbook for development machine configuration, sort of like a turbocharged `dotfiles` repository. Run this on a fresh OS install to get about 95% of the way to my current setup.

Quickstart: run `./run.sh`

Slowstart? fullstart??? run `ansible-playbook -i ANSIBLE_INVENTORY_FILE.ini --ask-become-pass --extra-vars "user_name=USERNAME real_name='NAME' email=EMAIL" main.yml`

Features:

* Installs and configures commonly-used software (e.g., Blender userprefs).
* Verifies software integrity (e.g., GPG signatures for PPAs, checks against hardcoded SHA512 hashes).
* Performs many useful environment tweaks (e.g., keyboard shortcuts, GNOME shell tweaks, login shell).
* Includes a set of scripts for performing incremental, encrypted backups to Amazon S3.

Partially inspired by [Stavros Korokithakis' configuration playbook](https://www.stavros.io/posts/provisioning-your-computer-one-command-awesome/).

Manual steps required beforehand:

* Disable Intel ME with [me_cleaner](https://github.com/corna/me_cleaner). Make sure to take a firmware backup beforehand.
* Install 64-bit Xubuntu 20.04. Check out [official docs](https://tutorials.ubuntu.com/tutorial/tutorial-how-to-verify-ubuntu) for verifying the digital signatures.
* Add BIOS password and disable booting from external devices.
* Install a case and privacy screen - here are links for the Dell XPS 9380 Developer Edition:
    * [3M Gold Privacy Screen, 13.3"](https://www.amazon.ca/gp/product/B003V0ZSOE/)
    * [mCover Hard Shell Case for Dell XPS 9370/9380](https://www.amazon.ca/iPearl-mCover-models-fitting-Ultrabook/dp/B079TZWQKK/)
* Back up LUKS headers for encrypted volumes: `sudo cryptsetup luksHeaderBackup /dev/nvme0n1p3 --header-backup-file 'XPS 13 LUKS Header Backup.img'` (then back up the generated img file to other, accessible places).
* Copy in personal files from backups to `~/Files`.
* Disable Bluetooth at a hardware level if there's a killswitch on the machine, at a BIOS level if the option exists, or at the OS level by running `systemctl disable bluetooth.service`.
* Double check:
    * That swap and root filesystem are encrypted: `sudo dmsetup status`.
    * That LUKS headers are backed up for encrypted volumes.
    * That Bluetooth is unavailable on the system.

Automatic steps:

* Run `./run.sh`.

Manual steps required afterward:

* Install fonts by copying them to the user fonts directory with `mkdir -p ~/.fonts; find ~/Files/Fonts -type f -exec cp -t ~/.fonts -i '{}' +; fc-cache -f -v`.
* Install "Inconsolata-g for Powerline" font and set the terminal font to this one, in order to get Powerline rendering correctly.
* Import SSH and GPG public keys.
* Set up Yubikey 4 with GPG keys and touch-to-sign from offline machine.
* Download docsets for Zeal.
* Install packages that need out-of-band verification:
    * Rust toolchain via [rustup](https://www.rustup.rs/).
    * Google Cloud management via [Google Cloud SDK](https://cloud.google.com/sdk/docs/downloads-apt-get).
    * AWS management via [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html).
* Install and set up useful VSCode extensions from verified VSIX files:
    * `ms-python.python`. Microsoft official.
    * `ms-azuretools.vscode-docker`. Microsoft official.
    * `ms-vscode.cpptools`. Microsoft official.
    * `ms-vscode.vscode-typescript-tslint-plugin`. Microsoft official.
    * `vsciot-vscode.vscode-arduino`. Microsoft official.
    * `golang.go`. Google official.
    * `vscodevim.vim`.
    * `coenraads.bracket-pair-colorizer-2`.
    * `alefragnani.bookmarks`.
    * `adamwalzer.string-converter`.
    * `oliversturm.fix-json`.
    * `gregoire.dance`.
* Restore bookmarks and user settings in Firefox.
* Install useful Firefox extensions (NOTE: only install addons that are part of the [Recommended Extensions Program](https://support.mozilla.org/en-US/kb/recommended-extensions-program)):
    * [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/).
    * [Privacy Badger](https://addons.mozilla.org/en-US/firefox/addon/privacy-badger17/).
    * [Auto Tab Discard](https://addons.mozilla.org/en-US/firefox/addon/auto-tab-discard/).
    * [SingleFile](https://addons.mozilla.org/en-CA/firefox/addon/single-file/).
    * [Facebook Container](https://addons.mozilla.org/en-CA/firefox/addon/facebook-container/).
    * [Firefox Multi-Account Containers](https://addons.mozilla.org/en-CA/firefox/addon/multi-account-containers/).
    * [Stylus](https://addons.mozilla.org/en-CA/firefox/addon/styl-us/).
    * [Feedbro](https://addons.mozilla.org/en-US/firefox/addon/feedbroreader/).
    * [DarkReader](https://addons.mozilla.org/en-US/firefox/addon/darkreader/).
* Configure Firefox options:
    * `network.IDN_show_punycode` should be true (to avoid IDN homoglyph phishing).
    * `webgl.disabled` should be true (to avoid WebGL attack surface).
    * `ui.key.menuAccessKeyFocuses` should be false (to make lone Alt keypresses a no-op, since Diverge 3 keyboard uses a dual-role Enter/Alt key).
    * `browser.sessionstore.warnOnQuit` should be true (to prevent errant Ctrl + Q keypresses from closing the browser).
    * `app.normandy.enabled` should be false (to disable targeted studies and preference rollouts).
    * `dom.serviceWorkers.enabled` should be false (to disable service workers, which often cause caching issues with shitty sites).
* Set up calendar reminder to run `run-restic-backup` (a custom shell script installed by this project) regularly.
* Customise XFCE:
    * In Thunar's `Edit` -> `Configure custom actions` dialog, set the `Open Terminal Here` shortcut to have keyboard shortcut F12.
    * Set up mouse/touchpad options for the current hardware.
* Set up copy of Hypotenuse Labs' Google Drive folder with `rclone config`. The config file, `~/.config/rclone/rclone.conf`, should look like this afterwards:

        [hyplabs]
        type = drive
        client_id = XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX.apps.googleusercontent.com
        client_secret = XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
        scope = drive.readonly
        root_folder_id = 12qUgt4vgb6mG7X8wwBjH_EWZ7If4t7P7
        token = {"access_token":"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX","token_type":"Bearer","refresh_token":"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX","expiry":"2020-07-10T05:53:07.468190874-00:00"}
        team_drive = 

* Set up Geary for email:
    * Add account with GMail over IMAP, must use an [App Password](https://support.google.com/accounts/answer/185833) (don't use GNOME Online Accounts, it requests too many permissions). Make sure it's configured to download "Everything" from IMAP, rather than the default of "Two Weeks".
    * Copy the contents of `~/Files/000-configuration/gmail-geary-data-backup` into `~/.local/share/geary/account_01`, to restore mail data backup and keep the mail data in the backed-up folder. This can't be a symlink due to Firejail restrictions.
* Set up VMs in VirtualBox.
    * Windows VM with Kindle stuff.
    * Whonix VM for Tor stuff.
* Set up Chromium with [Zoom Redirector](https://github.com/arkadiyt/zoom-redirector), [React Developer Tools](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en), and [uBlock Origin](https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm).
* Set up [broot](https://dystroy.org/broot/install/).
* Various other useful tools:
    * FreeCAD: `snap install --beta freecad`
    * Beekeeper Studio: `snap install beekeeper-studio`

Hardware-specific Setup
-----------------------

### Thinkpad W540

* Color-calibrate display (use the onboard Pantone calibrator).
* Enable two-finger right-click and three-finger middle-click on the touchpad: `echo 'xinput set-prop 'SynPS/2 Synaptics TouchPad' 'libinput Click Method Enabled' 0 1 # enable two-finger-right-click for touchpad' >> ~/.xinputrc`.
* Install TLP to get improved battery life and more power controls on Thinkpads: `sudo apt-get install tlp tlp-rdw tp-smapi-dkms acpi-call-dkms`.
* Run `sudo sysctl -w vm.swappiness=1` to set swapping to the minimum value.

### Dell XPS 9380 Developer Edition

I installed Ubuntu and set up the BIOS to require passwords for power-on and changing UEFI settings. To enter the BIOS configuration UI, press F2 during boot.

The laptop comes preloaded with Ubuntu 18.04, pretty much vanilla except for the following additional packages:

```
$ aptitude search "?origin (Canonical) ?installed"
i   dell-service-meta                                                                             - Meta package for dell-service
i A oem-fix-tlp-realtek-lp1819812-blacklistr8153                                                  - Set r8153 to TLP USB blacklist
```

These packages are installed from these sources:

```
$ pwd
/etc/apt/sources.list.d
$ ls
bionic-dell-italia-whl.list  bionic-dell.list  bionic-dell-service.list  bionic-oem.list  google-chrome.list
$ cat bionic-dell-italia-whl.list 
deb http://dell.archive.canonical.com/updates/ bionic-dell-italia-whl public
# deb-src http://dell.archive.canonical.com/updates/ bionic-dell-italia-whl public
$ cat bionic-dell.list 
deb http://dell.archive.canonical.com/updates/ bionic-dell public
# deb-src http://dell.archive.canonical.com/updates/ bionic-dell public
$ cat bionic-dell-service.list 
deb http://dell.archive.canonical.com/updates/ bionic-dell-service public
# deb-src http://dell.archive.canonical.com/updates/ bionic-dell-service public
$ cat bionic-oem.list 
deb http://oem.archive.canonical.com/updates/ bionic-oem public
# deb-src http://oem.archive.canonical.com/updates/ bionic-oem public
```

I chose not to install these Dell-specific packages.

These are the hardware-specific tweaks:

* I enabled S3 sleep mode ("deep") instead of S0 ("s2idle") by adding `mem_sleep_default=deep` to `GRUB_CMDLINE_LINUX_DEFAULT` in `/etc/default/grub`, so it became `GRUB_CMDLINE_LINUX_DEFAULT="quiet splash mem_sleep_default=deep"`. This makes battery consumption much lower when suspended (from [this AskUbuntu answer](https://askubuntu.com/questions/1029474/ubuntu-18-04-dell-xps13-9370-no-longer-suspends-on-lid-close)).
* Since there's no hardware mute button, I added a custom shortcut so that Super + Backslash will run this command to toggle mute, and flash the Capslock LED once if unmuting and twice if muting: `sh -c 'if amixer set Capture toggle | grep -q "\[on\]"; then sudo /usr/bin/capslock-led 10 0.1; else sudo /usr/bin/capslock-led 1010 0.1; fi'`. This uses my custom `capslock-led` script; for more details check out the comments in `files/scripts/capslock-led`.
* Sensors are set up with `sudo sensors-detect`. Afterwards, `sensors` gives the right output. I then installed TLP with `sudo apt-get install tlp tlp-rdw` to get better battery life. This results in the advertised 6 hours of battery life, even with moderately heavy workloads.
* I followed [these instructions](https://unix.stackexchange.com/questions/189675/is-there-a-way-to-adjusts-the-brightness-of-the-monitor) for changing the brightness of an external monitor using `ddccontrol`:
    * Install and load userspace I2C kernel module: `sudo apt-get install i2c-tools ddccontrol; sudo modprobe i2c-dev` (the `ddccontrol` package will configure systemd to load the `i2c-dev` kernel module automatically on boot).
    * Use `sudo i2cdetect -l` to find all I2C devices, there were several lines containing "DDC", which looked like this: `i2c-7	i2c       	DPDDC-B                         	I2C adapter`.
    * Tried each `i2c-<N>` value like `sudo ddccontrol dev:/dev/i2c-<N>`. The only one that didn't give a `DDC/CI at dev:/dev/i2c-<N> is unusable (-1).` error was `sudo ddccontrol dev:/dev/i2c-7` - so `/dev/i2c-7` was the right I2C interface.
    * In the output of `sudo ddccontrol dev:/dev/i2c-7`, the brightness control was listed as `		> id=brightness, name=Brightness, address=0x10, delay=-1ms, type=0`, so `0x10` is the right I2C address.
    * Tried `sudo ddccontrol dev:/dev/i2c-7 -r 0x10 -w 20`, which set the monitor brightness to 20% of maximum, it worked.
    * Set up a shell alias `alias monitor-brightness='sudo ddccontrol dev:/dev/i2c-7 -r 0x10 -w'` to easily adjust this in the future.
* I turned off `Video > Dynamic Brightness Control` in the BIOS settings, since it was constantly changing the whole screen's brightness when part of the screen showed something with a different brightness (e.g., editor is dark gray, autocomplete popup is light gray, so everytime autocomplete shows up, the entire screen gets slightly dimmer).

And some hardware-specific workarounds:

* Sometimes the touchpad stops working after sleeping and then resuming. To fix this when it happens, run `sudo rmmod i2c_hid; sudo modprobe i2c_hid` to reload the I2C HID kernel module.
* Sometimes upon resuming from sleep, the lock screen fails to show up and the mouse can be moved, but nothing responds. In these cases the lock screen is still present, just not visible - type in your password and press Enter, and it should unlock. It may take a few attempts.
