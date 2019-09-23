# Profiles

⚠️ This symbol means you may/will need to add local changes for your specific configuration. You can find more information for the specific profile by clicking on its name or simply scrolling down. You may not have to add any local changes, however -- many profiles work with default configurations.

### Tested profiles
- bluetoothd
- [evince ⚠️](#evince)
- [Firefox ⚠️](#firefox)
- [gpg-agent ⚠️](#gpg-agent)
- [irssi ⚠️](#irssi)
- iwd
- less
- [Lollypop ⚠️](#lollypop)
- [mako ⚠️](#mako)
- mosh
- [mpv ⚠️](#mpv)
- NetworkManager
- [pass ⚠️](#pass)
- pulseaudio
- [redshift ⚠️](#redshift)
- rngd
- [ssh ⚠️](#ssh)
- [ssh-agent ⚠️](#ssh-agent)
- [streamlink ⚠️](#streamlink)
- [swaybg ⚠️](#swaybg)
- [syncthing ⚠️](#syncthing)
- [waybar ⚠️](#waybar)
- [youtube-dl ⚠️](#youtube-dl)

### New and somewhat untested profiles
- [transmission-cli ⚠️](#transmission-cli)
- wpa_supplicant

## Notes about each profile
### evince
This profile assumes you only want to view documents in `~/{D,d}ocuments/` and `~/{D,d}ownloads`. If you do not, add local changes. Evince does not need access to your whole home directory.

### Firefox
This profile has been tested with the standard `firefox` package as well as the AUR package `firefox-nightly`, and with OpenGL (default) and WebRender -- on the aforementioned hardware, on both Xorg and Sway. This single profile will apply to both Firefox and Firefox Nightly.

You will need to add local changes if your Firefox Nightly files are somewhere other than `/opt/firefox-nightly` (e.g. if you just download the binary from Mozilla's website).

The only directories in the home directory that Firefox is allowed to access are `~/{D,d}ownloads` and `~/.mozilla`. You won't be able to, for example, upload things to the web from your Documents directory. You'll need to copy the file to your downloads directory first.

### gpg-agent
This profile will only work with the `pinentry-curses` pinentry program.

You may need to add local changes to allow access to your GPG keys, if you keep them somewhere other than `~/.gnupg`.

### irssi
You may need to add local changes to allow `irssi` to access your configuration files, if they are symlinks to somewhere other than inside `~/.irssi/`.

### Lollypop
This profile assumes you keep your music in `~/{M,m}usic`. If you do not, add local changes. Lollypop does not need access to your whole home directory.

I have not tested the profile for any web features, so they probably will not work.

### mako
You may need to add local changes to allow `mako` to access your configuration file, if it's a symlink to somewhere other than inside `~/.config/mako/`.

### mpv
You may need to add local changes to allow `mpv` to acces your configuration file, if it's a symlink to somehwere other than `~/.config/mpv`.

This profile allows mpv to utilize `youtube-dl` to stream videos and confines it in the `youtube-dl` AppArmor profile in this project. You will need the separate `youtube-dl` profile enabled for this functionality.

This AppArmor profile also works when mpv is invoked by other programs like [streamlink](https://streamlink.github.io/). A streamlink profile is also available.

Use the command line flag `--gpu-context=wayland` for Wayland support. Use the command line flag `--hwdec=auto` for nvdec (NVIDIA) and VA-API (Intel) hardware decoding. You can also tell `mpv` to always use these options [through a config file](https://mpv.io/manual/master/).

### pass
You may need to add local changes to allow `pass` to access your password files and GNUPG files if they're somehwere other than `~/.password-store` and `~/.gnupg` respectively.

### redshift
This profile has been tested to work correctly on Xorg with the regular `redshift` package and on Sway with the `redshift-wlr-gamma-control` AUR package.

You may need to add local changes to allow `redshift` to access your configuration file, if it's a symlink to somewhere other than `~/.config/redshift/redshift.conf`.

### ssh
This profile will work with [`mosh`, the mobile shell](https://mosh.org/), and with `git` for interacting with remote repositories.

This profile will work using `ssh` in the traditional way to "ssh into" remote machines, but `mosh` will give you terminfo support for any terminal on the host without having to install it on the remote machine; not to mention better connection stability, connection through sleep/hibernate, etc. There's an AppArmor profile for `mosh` in this repository, and these profiles work together.

You may need to add local changes to allow `ssh` to access your SSH keys, if you keep them somewhere other than `~/.ssh`.

### ssh-agent
You may need to add local changes to allow `ssh-agent` access to your SSH keys, if you keep them somewhere other than `~/.ssh`.

### streamlink
You will need to set either `mpv` or `vlc` as your default player. If you choose `mpv`, you must have the separate `mpv` AppArmor profile from this repository enabled. If you choose `vlc`, I have not written an AppArmor profile for it yet, so streamlink will execute `vlc` unconfined (less secure).

### swaybg
You may need to add local changes to allow `swaybg` to access your specified wallpaper, if you keep it somewhere other than `~/{P,p}ictures/{W,w}allpapers/`.

### syncthing
You *will* need to add local changes to allow `syncthing` to access your synced directories.

### transmission-cli
You may need to add local changes to allow `transmission-cli` to access your configuration files, if you keep them somewhere other than `~/.config/transmission*`.

This profile assumes you only want to download files to `~/{D,d}ownlads`.

This profile applies to all `transmission-*` binaries, including `transmission-daemon` and `transmission-remote`.

### waybar
You may need to add local changes to allow `waybar` modules to work which I have not tested. I have tested the following modules to work: sway/workspaces, sway/mode, sway/window, network, pulseaudio, cpu, clock, tray.

### youtube-dl
The only directory in the home directory youtube-dl is allowed to access is the `~/{D,d}ownloads` directory. Add local changes if you prefer to download your videos elsewhere.
