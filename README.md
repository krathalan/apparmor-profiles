# apparmor-profiles
AppArmor profiles for various programs and services on Arch Linux.

Table of contents:

1. [Notes about usage](#notes-about-usage)
2. [Abstractions](#abstractions)
3. [Adding local changes](#adding-local-changes)
4. [NVIDIA](#nvidia)
5. [Issues](#issues)
6. [Contributing](#contributing)
7. [Notes about each profile](#notes-about-each-profile)

## Notes about usage
These AppArmor profiles are tested on the following hardware:

- CPUs:
    - Intel 4960K
    - Intel 8250U
    - AMD Ryzen 5600x
    - AMD EPYC 7601
- GPUs:
    - NVIDIA GeForce GTX 980 Ti with proprietary drivers
    - Intel 620 UHD Graphics
- Network adapters:
    - Intel Wireless-AC 9260
    - Intel Wi-Fi 6 AX200
    - Realtek RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
    - Virtio virtual ethernet card
- Bluetooth adapters:
    - Intel Wireless-AC 9260
    - Intel Wi-Fi 6 AX200

I cannot guarantee that these profiles will work on any other hardware. All profiles should work with Xorg on NVIDIA hardware, and with Sway (and probably Xorg) on Intel hardware. It's very possible these profiles will still work with AMD graphics, as it seems AMD graphics share a lot of similar behavior with Intel graphics. If you own an NVIDIA card, please read the NVIDIA section below.

These profiles strive to be fully functional with zero audit log warnings under proper behavior. Functionality is not ignored. If functionality is not explicitly blocked, then it's probably a bug in the profile and should be fixed. Create an issue: https://todo.sr.ht/~krathalan/apparmor-profiles

You should read through [the notes about each profile](#notes-about-each-profile) before using these profiles.

## Installation
I keep a PKGBUILD for Arch Linux in a personal repository. Build and install the package with the following commands:

```
$ git clone https://git.sr.ht/~krathalan/pkgbuilds
$ cd pkgbuilds/krathalans-apparmor-profiles-git/
$ cat PKGBUILD # Always inspect PKGBUILDS before running makepkg!
$ makepkg -i
```

For any other distro, simply copy the profiles in the `profiles/` folder of this repository to `/etc/apparmor.d/`.

Don't forget to rebuild or recopy every so often :)

## Adding local changes
To add local changes without changing the file provided by this repository, use local overrides. See `less /etc/apparmor.d/local/README` for more details. You can see commented examples of local overrides in the `local/` directory in this repository.

## NVIDIA
You may have issues with hardware acceleration on NVIDIA hardware. This is because the nvidia_modprobe profile in /etc/apparmor.d/ is configured incorrectly. Change the profile executable name at the top of the nvidia_modprobe profile file (`/etc/apparmor.d/nvidia_modprobe`) to "/usr/bin/nvidia-modprobe", so the top of the profile looks like this:

```
# vim:syntax=apparmor

#include <tunables/global>

profile nvidia_modprobe /usr/bin/nvidia-modprobe {
  #include <abstractions/base>
  ...

```

Don't forget to enforce!

`$ sudo aa-enforce /etc/apparmor.d/nvidia_modprobe`

You will also have to add `#include <abstractions/krathalans-hwaccel-nvidia>` to the `firefox`, `mpv`, and `code` local profile override files in `/etc/apparmor.d/local`. Alternatively, you can simply copy all files from `local/nvidia` in this repository into `/etc/apparmor.d/local` and run `sudo systemctl reload apparmor.service`.

## Issues
Please file bug reports, requests, etc. at https://todo.sr.ht/~krathalan/apparmor-profiles

## Contributing
Writing AppArmor profiles is fairly easy. "If you know how to use bash, chmod, and grep, you already understand AppArmor and you can probably reverse-engineer the policy by yourself," at 13:25 in the video: https://invidio.us/watch?v=k3kerBRYLhw

Pull requests and issues are welcome. I cannot test for hardware I do not have access to (AMD), so those PRs would be most critical.

To get started writing AppArmor profiles, I highly recommend this video from openSUSE: https://invidio.us/watch?v=o2xa8JYcrmw

You may also find this document incredibly helpful: https://gitlab.com/apparmor/apparmor/wikis/AppArmor_Core_Policy_Reference

---

# Notes about each profile

⚠️ This symbol means you may/will need to add local changes for your specific configuration. You can find more information for the specific profile by clicking on its name or simply scrolling down. You may not have to add any local changes, however -- many profiles work with the default configurations for that program.

- bluetoothd
- [chromium ⚠️](#chromium)
- [code ⚠️](#code)
- [cupsd ⚠️](#cupsd)
- [Discord ⚠️](#discord)
- endlessh
- [epiphany (GNOME Web) ⚠️](#epiphany)
- [evince ⚠️](#evince)
- [Firefox ⚠️](#firefox)
- [gpg-agent ⚠️](#gpg-agent)
- haveged
- [imv ⚠️](#imv)
- [irssi ⚠️](#irssi)
- iwd
- [khard ⚠️](#khard)
- less
- [Lollypop ⚠️](#lollypop)
- [mako ⚠️](#mako)
- [mbsync ⚠️](#mbsync)
- [micro ⚠️](#micro)
- mosh
- [mpv ⚠️](#mpv)
- [nginx ⚠️](#nginx)
- [pash ⚠️](#pash)
- pipewire
- [polybar ⚠️](#polybar)
- [postfix ⚠️](#postfix)
- postgrey
- [radicale ⚠️](#radicale)
- [redshift ⚠️](#redshift)
- rngd
- signal-desktop
- spamc
- [ssh ⚠️](#ssh)
- [ssh-agent ⚠️](#ssh-agent)
- [streamlink ⚠️](#streamlink)
- [swaybg ⚠️](#swaybg)
- [syncthing ⚠️](#syncthing)
- systemd-networkd
- systemd-resolved
- [transmission-cli ⚠️](#transmission-cli)
- [vdirsyncer ⚠️](#vdirsyncer)
- [waybar ⚠️](#waybar)
- wl-copy-paste
- wlsunset
- wob
- xclip
- [xob ⚠️](#xob)
- [youtube-dl ⚠️](#youtube-dl)

### chromium
This profile has been tested with the `ungoogled-chromium` AUR package ONLY, on both Xorg and Sway (with `--enable-features=UseOzonePlatform --ozone-platform=wayland`).

The only directory in the home directory that chromium is allowed to access is `~/{D,d}ownloads/`. You won't be able to, for example, upload things to the web from your Documents directory. You'll need to copy the file to your downloads directory first.

### code
You will need to add local changes to edit files that are not:
- in the base `~` directory (for files like `~/.bashrc`),
- `~/.config/`,
- `~/{D,d}ocuments/`,
- and `~/{G,g}it/`.

You will need to add local changes if your VSCode/ium configuration files are somewhere other than `~/.config/VSCodium/`, `~/.config/Code - OSS`, and `~/.vscode-oss`, or if you use extensions which require files outside of the profile.

This profile will work with both the `code` repo package and the `vscodium-bin` AUR package.
This profile is only allowed to open an AppArmor-confined Firefox when opening a URL.

### cupsd
This profile has only been tested with a local wireless HP printer. Printers from other manufacturers or printers connected via a different interface (e.g. USB, SAMBA, etc.) may not work. Patches accepted.

### Discord
The only directory in the home directory that Discord is allowed to access is `~/{D,d}ownloads/`. You won't be able to, for example, upload things to the web from your Documents directory. You'll need to copy the file to your downloads directory first.

### epiphany
The only directory in the home directory that epiphany is allowed to access is `~/{D,d}ownloads/`. You won't be able to, for example, upload things to the web from your Documents directory. You'll need to copy the file to your downloads directory first.

### evince
You will need to add local changes if you wish to view documents that are not in `~/{D,d}ocuments/` or `~/{D,d}ownloads/`.

### Firefox
This profile has been tested with the `firefox` and `firefox-developer-edition` repo packages, and with OpenGL (default) and WebRender -- on the aforementioned hardware, on both Xorg and Sway. This single profile will apply to all Firefox versions.

The only directories in the home directory that Firefox is allowed to access are `~/{D,d}ownloads/` and `~/.mozilla/`. You won't be able to, for example, upload things to the web from your Documents directory. You'll need to copy the file to your downloads directory first.

### gpg-agent
This profile will only work with the `pinentry-curses` pinentry program. As per the Arch Wiki (https://wiki.archlinux.org/index.php/GPG#pinentry), to use the curses pinentry, add the following to `~/.gnupg/gpg-agent.conf`:
`pinentry-program /usr/bin/pinentry-curses`

You may need to add local changes to allow access to your GPG keys, if you keep them somewhere other than `~/.gnupg/`.

### imv
You will need to add local changes if you wish to view images that are not in `~/{D,d}ownloads/`, `~/{P,p}ictures/`, or `~/{P,p}hotos/`.

### irssi
You may need to add local changes to allow `irssi` to access your configuration files, if they are symlinks to somewhere other than inside `~/.irssi/` or `~/.config/irssi/`.

### khard
You may need to add local changes to allow `khard` to access your configuration files, if you keep them somewhere other than `~/.config/khard/`.
You may need to add local changes to allow `khard` to access your contact storage directory, if you keep it somewhere other than `~/.local/share/contacts`.

### Lollypop
You will need to add local changes if you wish to listen to music in directories other than `~/{M,m}usic/`.

I have not tested the profile for any web features, so they probably will not work.

### mako
You may need to add local changes to allow `mako` to access your configuration file, if it's a symlink to somewhere other than inside `~/.config/mako/`.

### mbsync
You may need to add local changes to allow `mbsync` to access your mail storage directories, if they're somewhere other than `~/.local/share/mail/`.

### micro
You may need to add local changes to allow `micro` to access your configuration files, if there are symlinks to somewhere other than inside `~/.config/micro/`.

Additionally, you may add local changes to be able to view/edit files in directories other than `~/{D,d}ocuments/` and `~/{G,g}it/`.

### mpv
You may need to add local changes to allow `mpv` to acces your configuration file, if it's a symlink to somehwere other than `~/.config/mpv/`.

This profile allows mpv to utilize `youtube-dl` to stream videos and confines it in the `youtube-dl` AppArmor profile in this project. You will need the separate `youtube-dl` profile enabled for this functionality.

This AppArmor profile also works when mpv is invoked by other programs like [streamlink](https://streamlink.github.io/). A streamlink profile is also available.

Use the command line flag `--gpu-context=wayland` for Wayland support. Use the command line flag `--hwdec=auto` for nvdec (NVIDIA) and VA-API (Intel) hardware decoding. You can also tell `mpv` to always use these options [through a config file](https://mpv.io/manual/master/).

### mutt
You may need to add local changes to allow `mutt` to access your configuration files, if there are symlinks to somewhere other than inside `~/.config/mutt/`.

This profile only has support for `micro` and `nano` for composing emails. Pull requests are welcome for other editors.

### nginx
You will need to add local changes to allow `nginx` to access your hosted files (e.g. `index.html`, etc.).
You may need to add local changes to allow `nginx` to access your HTTPS certificates, if you keep them somewhere other than `/etc/letsencrypt/`.

This profile assumes you are running `nginx` as an unpriveleged user via systemd: https://wiki.archlinux.org/index.php/Nginx#Running_unprivileged_using_systemd

### pash
You may need to add local changes to allow `pash` to access your password files and GNUPG files if they're somehwere other than `~/.local/share/pash/` and `~/.gnupg/` respectively.

### polybar
You may need to add local changes to allow `polybar` to access your configuration files, if you keep them somewhere other than `~/.config/polybar/`.

You may need to add local changes to allow `polybar` modules to work which I have not tested. I have tested the following modules to work: i3, xwindow, network, pulseaudio, cpu, date.

### postfix
You may need to add local changes to allow `postfix` to access your HTTPS certificates, if you keep them somewhere other than `/etc/letsencrypt/`.

These profiles may not work depending on your configuration. Patches accepted.

### radicale
You may need to add local changes to allow `radicale` to access your:
- `htpasswd` file, if you keep it somewhere other than `/etc/radicale/`.
- storage directory, if you keep it somewhere other than `/var/lib/radicale/`.
- or HTTPS certificates, if you keep them somewhere other than `/etc/letsencrypt/`.

Make sure you check the user/group permissions on your `htpasswd` file!

### redshift
This profile has been tested to work correctly on Xorg with the `redshift` repo package.

You may need to add local changes to allow `redshift` to access your configuration file, if it's a symlink to somewhere other than `~/.config/redshift/`.

### ssh
This profile will work with [`mosh`, the mobile shell](https://mosh.org/), and with `git` for interacting with remote repositories. There's an AppArmor profile for `mosh` in this repository, and these profiles work together.

You may need to add local changes to allow `ssh` to access your SSH keys, if you keep them somewhere other than `~/.ssh/`.

### ssh-agent
You may need to add local changes to allow `ssh-agent` access to your SSH keys, if you keep them somewhere other than `~/.ssh/`.

### streamlink
You will need to set `mpv` as your default player. You must have the separate `mpv` AppArmor profile from this repository enabled.

### swaybg
You may need to add local changes to allow `swaybg` to access your specified wallpaper, if you keep it somewhere other than `~/{P,p}ictures/{W,w}allpapers/`.

### syncthing
You *will* need to add local changes to allow `syncthing` to access your synced directories.

### transmission-cli
You may need to add local changes to allow `transmission-cli` to access your configuration files, if you keep them somewhere other than `~/.config/transmission*/`.

You will need to add local changes if you wish to download files to any directory other than `~/{D,d}ownloads/`.

This profile applies to all `transmission-*` binaries, including `transmission-daemon` and `transmission-remote`.

### vdirsyncer
You may need to add local changes to allow `vdirsyncer` to access your configuration files, if you keep them somewhere other than `~/.config/vdirsyncer/`.
You may need to add local changes to allow `vdirsyncer` to access your contact storage directory, if you keep it somewhere other than `~/.local/share/contacts`.

### waybar
You may need to add local changes to allow `waybar` to access your configuration files, if you keep them somewhere other than `~/.config/waybar/`.

You may need to add local changes to allow `waybar` modules to work which I have not tested. I have tested the following modules to work: sway/workspaces, sway/mode, sway/window, network, pulseaudio, cpu, clock, tray.

### xob
You may need to add local changes to allow `xob` to access your configuration files, if you keep them somewhere other than `~/.config/xob/`.

### youtube-dl
You will need to add local changes if you wish to download videos to any directory other than `~/{D,d}ownloads/`.

## Unmaintained profiles

- aerc
- Gedit
- Hexchat
- KeepassXC
- mutt
- NetworkManager
- pass
- pulseaudio
- undervolt-py
- wpa_supplicant

These are profiles which I used to keep updated with their packaged versions, but now do not -- most likely because I have found an alternative program (e.g. Hexchat --> irssi) that I have a new AppArmor profile for. If you wish to maintain one of these profiles please submit patches!

Sometimes I will resurrect these profiles if I see fit (e.g. pipewire).
