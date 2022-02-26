# apparmor-profiles
AppArmor profiles for various programs and services on Arch Linux.

Table of contents:

1. [Hardware](#hardware)
2. [Installation](#installation)
3. [Adding local overrides](#adding-local-overrides)
4. [NVIDIA](#nvidia)
5. [Issues](#issues)
6. [Contributing](#contributing)
7. [Notes](#notes)

## Hardware
These AppArmor profiles are tested on the following hardware:

- CPUs:
    - Intel 4960K/8250U
    - AMD Ryzen 5600x/EPYC 7601
- GPUs:
    - NVIDIA GeForce GTX 980 Ti with proprietary drivers
    - Intel 620 UHD Graphics
- Network adapters:
    - Intel Wireless-AC 9260/Wi-Fi 6 AX200
    - Realtek RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
    - Virtio virtual ethernet card
- Bluetooth adapters:
    - Intel Wireless-AC 9260/Wi-Fi 6 AX200

I cannot guarantee that these profiles will work on any other hardware. All profiles should work with Xorg on NVIDIA hardware, and with Sway (and probably Xorg) on Intel hardware. It's very possible these profiles will still work with AMD graphics, as it seems AMD graphics share a lot of similar behavior with Intel graphics. If you own an NVIDIA card, please read the NVIDIA section below.

These profiles strive to be fully functional with zero audit log warnings under normal usage. Functionality is not ignored. If functionality is not explicitly blocked, then it's probably a bug in the profile and should be fixed. Create an issue: https://github.com/krathalan/apparmor-profiles/issues

You should read through [the notes](#notes) before using these profiles.

## Installation
Get `krathalans-apparmor-profiles-git` from the AUR: https://aur.archlinux.org/packages/krathalans-apparmor-profiles-git/

For any other distro, simply copy the files in the `profiles/` folder of this repository to `/etc/apparmor.d/`, and the files in the `abstractions/` folder of this repository to `/etc/apparmor.d/abstractions`.

Don't forget to rebuild or recopy every so often :)

## Adding local overrides
To add local overrides without changing the files provided by this repository, use local overrides. See `less /etc/apparmor.d/local/README` for more details. You can see commented examples of local overrides in the `local/` directory in this repository.

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
Please file bug reports, requests, etc. at https://github.com/krathalan/apparmor-profiles/issues

## Contributing
Writing AppArmor profiles is fairly easy. "If you know how to use bash, chmod, and grep, you already understand AppArmor and you can probably reverse-engineer the policy by yourself," at 13:25 in the video: https://invidio.us/watch?v=k3kerBRYLhw

Pull requests and issues are welcome. I cannot test for hardware I do not have access to (AMD), so those PRs would be most critical.

To get started writing AppArmor profiles, I highly recommend this video from openSUSE: https://invidio.us/watch?v=o2xa8JYcrmw

You may also find this document incredibly helpful: https://gitlab.com/apparmor/apparmor/wikis/AppArmor_Core_Policy_Reference

# Notes

## Profiles that should work with Zero Configuration™

- bluetoothd
- haveged
- iwd
- less
- mosh
- pipewire
- postgrey
- rngd
- signal-desktop
- spamc
- systemd-networkd
- systemd-resolved
- wl-copy-paste
- wlsunset
- wob
- xclip

## Profiles which have config files that may be symlinks

If you use a program like GNU `stow` to manage your dotfiles via symlinks, you may run in to issues using these AppArmor profiles. You will need to [add local overrides](#adding-local-overrides) to allow that program to access the real location of your config file(s) that the symlink(s) point to. For example, I keep my dotfiles at `~/documents/config/...` and use `stow` to keep them in `~/.config`. For the polybar profile, I have the file `/etc/apparmor/local/polybar` with the following snippet: 

```
# Config file at ~/.config/polybar/config is a symlink to this file
owner @{HOME}/documents/config/xorg-config/.config/polybar/config r,
```

See [adding local overrides](#adding-local-overrides) for more information.

- irssi
- khard
- mako
- micro
- mpv
- polybar
- redshift
- transmission-cli
- vdirsyncer
- waybar
- xob

## Profiles which only allow r/w in ~/{D,d}ownloads

The only directory (apart from program-specific config or data directories, such as those in `~/.config`) in the home directory that these profiles are allowed to read and write to is `~/{D,d}ownloads/`. You won't be able to, for example, upload things to the web from your `~/Documents` directory. You'll need to copy the file to your `~/{D,d}ownloads/` directory first, or [add local overrides](#adding-local-overrides).

- chromium
- discord
- firefox
- transmission-cli

## Other miscellaneous notes

You can find more information for the specific profile by clicking on its name. You may not have to add any local overrides, however -- many profiles work with the default configurations for that program.

- [chromium](#chromium)
- [code](#code)
- [evince](#evince)
- [Firefox](#firefox)
- [gpg-agent](#gpg-agent)
- [imv](#imv)
- [khard](#khard)
- [mbsync](#mbsync)
- [micro](#micro)
- [mpv](#mpv)
- [nginx](#nginx)
- [pash](#pash)
- [polybar](#polybar)
- [postfix](#postfix)
- [radicale](#radicale)
- [ssh](#ssh)
- [ssh-agent](#ssh-agent)
- [streamlink](#streamlink)
- [swaybg](#swaybg)
- [syncthing](#syncthing)
- [transmission-cli](#transmission-cli)
- [vdirsyncer](#vdirsyncer)
- [waybar](#waybar)

### chromium
This profile has been tested with the `ungoogled-chromium` AUR package ONLY, on both Xorg and Sway (with `--enable-features=UseOzonePlatform --ozone-platform=wayland`).

### code
You will need to [add local overrides](#adding-local-overrides) to edit files that are not:
- in the base `~` directory (for files like `~/.bashrc`),
- `~/.config/`,
- `~/{D,d}ocuments/`,
- and `~/{G,g}it/`.

You will need to [add local overrides](#adding-local-overrides) if your VSCode/ium configuration files are somewhere other than `~/.config/VSCodium/`, `~/.config/Code - OSS`, and `~/.vscode-oss`, or if you use extensions which require files outside of the profile.

This profile will work with both the `code` repo package and the `vscodium-bin` AUR package.
This profile is only allowed to open an AppArmor-confined Firefox when opening a URL.

### evince
You will need to [add local overrides](#adding-local-overrides) if you wish to view documents that are not in `~/{D,d}ocuments/` or `~/{D,d}ownloads/`. You will also need to add overrides if you wish to edit or save documents.

### Firefox
This profile has been tested with the `firefox` and `firefox-developer-edition` repo packages, on WebRender -- on the aforementioned hardware, on both Xorg and Sway. This single profile will apply to all Firefox versions.

### gpg-agent
This profile will only work with the `pinentry-curses` pinentry program. As per the Arch Wiki (https://wiki.archlinux.org/index.php/GPG#pinentry), to use the curses pinentry, add the following to `~/.gnupg/gpg-agent.conf`:
`pinentry-program /usr/bin/pinentry-curses`

You may need to [add local overrides](#adding-local-overrides) to allow access to your GPG keys, if you keep them somewhere other than `~/.gnupg/`.

### imv
You will need to [add local overrides](#adding-local-overrides) if you wish to view images that are not in `~/{D,d}ownloads/`, `~/{P,p}ictures/`, or `~/{P,p}hotos/`.

### khard
You may need to [add local overrides](#adding-local-overrides) to allow `khard` to access your contact storage directory, if you keep it somewhere other than `~/.local/share/contacts`.

### mbsync
You may need to [add local overrides](#adding-local-overrides) to allow `mbsync` to access your mail storage directories, if they're somewhere other than `~/.local/share/mail/`.

### micro

Additionally, you may [add local overrides](#adding-local-overrides) to be able to view/edit files in directories other than `~/{D,d}ocuments/` and `~/{G,g}it/`.

### mpv
This profile allows mpv to utilize `yt-dlp` to stream videos.

This AppArmor profile also works when mpv is invoked by other programs like [streamlink](https://streamlink.github.io/). A streamlink profile is also available.

Use the command line flag `--gpu-context=wayland` for Wayland support. Use the command line flag `--hwdec=auto` for hardware decoding. You can also tell `mpv` to always use these options [through a config file](https://mpv.io/manual/master/).

### nginx
You will need to [add local overrides](#adding-local-overrides) to allow `nginx` to access your hosted files (e.g. `index.html`, etc.).
You may need to [add local overrides](#adding-local-overrides) to allow `nginx` to access your HTTPS certificates, if you keep them somewhere other than `/etc/letsencrypt/`.

This profile assumes you are running `nginx` as an unprivileged user via systemd: https://wiki.archlinux.org/index.php/Nginx#Running_unprivileged_using_systemd

### pash
You may need to [add local overrides](#adding-local-overrides) to allow `pash` to access your password files and GNUPG files if they're somehwere other than `~/.local/share/pash/` and `~/.gnupg/` respectively.

### polybar
You may need to [add local overrides](#adding-local-overrides) to allow `polybar` modules to work which I have not tested. I have tested the following modules to work: i3, xwindow, network, pulseaudio, cpu, date.

### postfix
You may need to [add local overrides](#adding-local-overrides) to allow `postfix` to access your HTTPS certificates, if you keep them somewhere other than `/etc/letsencrypt/`.

These profiles may not work depending on your configuration. Patches accepted.

### radicale
You may need to [add local overrides](#adding-local-overrides) to allow `radicale` to access your:
- `htpasswd` file, if you keep it somewhere other than `/etc/radicale/`.
- storage directory, if you keep it somewhere other than `/var/lib/radicale/`.
- or HTTPS certificates, if you keep them somewhere other than `/etc/letsencrypt/`.

Make sure you check the user/group permissions on your `htpasswd` file!

### ssh
This profile will work with [`mosh`, the mobile shell](https://mosh.org/), and with `git` for interacting with remote repositories. There's an AppArmor profile for `mosh` in this repository, and these profiles work together.

You may need to [add local overrides](#adding-local-overrides) to allow `ssh` to access your SSH keys, if you keep them somewhere other than `~/.ssh/`.

### ssh-agent
You may need to [add local overrides](#adding-local-overrides) to allow `ssh-agent` access to your SSH keys, if you keep them somewhere other than `~/.ssh/`.

### streamlink
You will need to set either `mpv` or `vlc` as your default player. You must have the separate `mpv` AppArmor profile from this repository enabled.

### swaybg
You may need to [add local overrides](#adding-local-overrides) to allow `swaybg` to access your specified wallpaper, if you keep it somewhere other than `~/{P,p}ictures/{W,w}allpapers/`.

### syncthing
You *will* need to [add local overrides](#adding-local-overrides) to allow `syncthing` to access your synced directories.

### transmission-cli

This profile applies to all `transmission-*` binaries, including `transmission-daemon` and `transmission-remote`.

### vdirsyncer
You may need to [add local overrides](#adding-local-overrides) to allow `vdirsyncer` to access your contact storage directory, if you keep it somewhere other than `~/.local/share/contacts`.

### waybar
You may need to [add local overrides](#adding-local-overrides) to allow `waybar` modules to work which I have not tested. I have tested the following modules to work: sway/workspaces, sway/mode, sway/window, network, pulseaudio, cpu, clock, tray.

# Unmaintained profiles

- aerc
- cupsd
- epiphany
- Gedit
- Hexchat
- KeepassXC
- Lollypop
- mutt
- pass
- pipewire (until it is stable)
- pulseaudio
- wpa_supplicant
- youtube-dl (soon to be replaced by a `yt-dlp` profile)

These are profiles which I used to keep updated with their packaged versions, but now do not -- most likely because:

1. I have found an alternative program (e.g. Hexchat -> irssi, pulseaudio -> pipewire) that I have a new AppArmor profile for, or
2. I find extremely cumbersome and difficult to maintain an AppArmor profile of, either because the program is extremely complex (e.g. cupsd), or because of other reasons (e.g. epiphany, because it cannot be AppArmor-ed with the WebKit sandbox enabled, and because it changes so frequently and so bizarrely that I find it difficult to keep up)

If you wish to maintain one of these profiles please submit patches!

Sometimes I will resurrect these profiles if I see fit (in the case of pipewire).
