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

If you're on a Thinkpad W540, check out [my Ubuntu installation guide](http://anthony-zhang.me/blog/thinkpad-w540-linux/) too.

Partially inspired by [Stavros Korokithakis' configuration playbook](https://www.stavros.io/posts/provisioning-your-computer-one-command-awesome/).

Manual steps required beforehand:

* Disable Intel ME with [me_cleaner](https://github.com/corna/me_cleaner). Make sure to take a firmware backup beforehand. As of this writing, the Thinkpad W540 is not supported by Coreboot.
* Install 64-bit Ubuntu 17.10. Check out [official docs](https://tutorials.ubuntu.com/tutorial/tutorial-how-to-verify-ubuntu) for verifying the digital signatures.
* Add BIOS password and disable booting from external devices.

Manual steps required afterward:

* Copy in personal files from backups to `~/Files`.
* Install fonts by copying them to the user fonts directory with `find ~/Files/Fonts -type f -exec cp -t ~/.fonts -i '{}' +` and then running `fc-cache -f -v`.
* Import SSH and GPG public keys.
* Set up Yubikey 4 with GPG keys and touch-to-sign from offline machine.
* Download unit definitions and exchange rates for Qalculate (Qalculate will prompt to do this on first run).
* Download docsets for Zeal.
* Install Rust toolchain via [rustup](https://www.rustup.rs/). Not automatically installed due to unsigned packages.
* Install useful VSCode extensions from verified VSIX files:
    * `ms-python.python`.
    * `PeterJausovec.vscode-docker`.
    * `ms-vscode.cpptools`.
    * `vscodevim.vim`.
    * `CoenraadS.bracket-pair-colorizer`.
    * `alefragnani.bookmarks`.
* Set up custom LibreOffice templates.
* Restore bookmarks and user settings in Firefox. Install useful Firefox extensions: [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/), [Privacy Badger](https://addons.mozilla.org/en-US/firefox/addon/privacy-badger17/).
* Set up calendar reminder to run `run-duplicity-backup` (a custom shell script installed by this project) regularly.
* Install or configure crucial proprietary software (CAD and DSP).
* Hardware tweaks:
    * Color-calibrate display (use the onboard Pantone calibrator).
    * Enable two-finger right-click and three-finger middle-click on the touchpad: `echo 'xinput set-prop 'SynPS/2 Synaptics TouchPad' 'libinput Click Method Enabled' 0 1 # enable two-finger-right-click for touchpad' >> ~/.xinputrc`.
    * Install TLP to get improved battery life and more power controls on Thinkpads: `sudo apt-get install tlp tlp-rdw tp-smapi-dkms acpi-call-dkms`.
    * Run `sudo sysctl -w vm.swappiness=1` to set swapping to the minimum value.
* Update Rhythmbox "Date Added" to match the "Last Modified" time on music files: `perl -0777 -p -i -e 's/<mtime>([0-9]+)<\/mtime>([^<]*)<first-seen>[0-9]+<\/first-seen>/<mtime>\1<\/mtime>\2<first-seen>\1<\/first-seen>/g' ~/.local/share/rhythmbox/rhythmdb.xml`.