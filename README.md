# apparmor-profiles

AppArmor profiles for various user applications. Only tested on Arch Linux.

## Notes about usage
These AppArmor profiles have been verified to work on the following hardware:

- CPUs:
    - Intel 4960K
    - Intel 8250U
- GPUs:
    - NVIDIA GeForce GTX 980 Ti
    - Intel 620 UHD Graphics
- Network/Bluetooth cards:
	- Intel Wireless-AC 9260

I cannot guarantee that these profiles will work on any other hardware. All profiles should work with Xorg on NVIDIA hardware and with Sway (and probably Xorg) on Intel hardware. If you own an NVIDIA card, please read the NVIDIA section below.

However, it's very possible these profiles will still work with AMD graphics, as it seems AMD graphics share a lot of similar behavior with Intel graphics.

These profiles strive to be at least ~95% functional with zero audit log warnings under proper behavior. Functionality is not ignored; rather sometimes it's blocked in the interest of security. See notes about profiles such as discord below, or click [here](#discord). If functionality is not explicitly blocked, then it's probably a bug in the profile and should be fixed. Create an issue.

## Abstractions
Many profiles for GUI applications (like Firefox, KeepassXC, Lollypop etc.) require access to common files, like icons, themes, fonts, and so on. To ease the burden of maintenance and to reduce policy error, these rules have been put into an abstraction. Move the `krathalans-common-gui` file in the `abstractions/` folder in this repository to `/etc/apparmor.d/abstractions/` and `sudo systemctl reload apparmor.service`.

Many profiles for GUI applications WILL NOT WORK if you do not have this abstraction loaded.

Additionally, Firefox and mpv require the `krathalans-graphics` abstraction to be in `/etc/apparmor.d/abstractions/` for hardware acceleration and hardware video decoding. See the NVIDIA section below if you own an NVIDIA card.

## NVIDIA
You may have issues with hardware acceleration on NVIDIA hardware. This is because the nvidia_modprobe profile in /etc/apparmor.d/ is configured incorrectly. Change the profile executable name at the top of the nvidia_modprobe profile file (`/etc/apparmor.d/nvidia_modprobe`) to "/usr/bin/nvidia-modprobe".

Then rename the nvidia_modprobe file to usr.bin.nvidia-modprobe:

`# mv /etc/apparmor.d/nvidia_modprobe /etc/apparmor.d/usr.bin.nvidia-modprobe`

Don't forget to enforce!

`# aa-enforce /etc/apparmor.d/usr.bin.nvidia-modprobe`

You will also have to copy BOTH `abstractions/krathalans-graphics` and `abstractions/krathalans-graphics-nvidia` profiles to `/etc/apparmor.d/abstractions` and `#include` the NVIDIA file in the Firefox and MPV AppArmor profiles. Adding NVIDIA rules to a profile makes the profile much less secure, so this should be done for NVIDIA users only.

---

⚠️ This symbol means you may/will need to edit the profile for your specific configuration. You can find more information for the specific profile by clicking on its name or simply scrolling down.

Don't be afraid though -- many profiles work with default configurations.

### Tested profiles
- bluetoothd
- [discord ⚠️](#discord)
- [evince ⚠️](#evince)
- [Firefox ⚠️](#firefox)
- [gpg-agent ⚠️](#gpg-agent)
- iwd
- [KeepassXC ⚠️](#keepassxc)
- less
- [Lollypop ⚠️](#lollypop)
- [mako ⚠️](#mako)
- [mpv ⚠️](#mpv)
- NetworkManager
- pulseaudio
- [redshift ⚠️](#redshift)
- rngd
- [ssh-agent ⚠️](#ssh-agent)
- [streamlink ⚠️](#streamlink)
- [swaybg ⚠️](#swaybg)
- [syncthing ⚠️](#syncthing)
- [waybar ⚠️](#waybar)

### New and somewhat untested profiles
- [irssi ⚠️](#irssi)
- [youtube-dl ⚠️](#youtube-dl)

### Unmaintained profiles
- hexchat (check out irssi!)
- pipewire

## Notes about each profile
### discord
This profile assumes you only want to upload files from `~/{D,d}ownloads`. If you do not, edit the file. Discord does not need access to your whole home directory.

This profile intentionally does not enable hardware acceleration due to the deeper level of system access hardware acceleration requires, the [insecurity of modern graphics drivers](https://security.stackexchange.com/questions/182501/modern-linux-gpu-driver-security?answertab=votes#tab-top), and the reluctance to give proprietary software deeper system access than it truly needs.

Streamer mode and showing any currently playing games/music/etc. will not work as `ptrace` is completely disabled in this profile, as Discord tries to run `ptrace` on every program running on your machine. `ptrace` is an extremely dangerous capability. From the [`ptrace` manpage](http://man7.org/linux/man-pages/man2/ptrace.2.html):

```
The ptrace() system call provides a means by which one process (the
"tracer") may observe and control the execution of another process
(the "tracee"), and examine and change the tracee's memory and
registers.  It is primarily used to implement breakpoint debugging
and system call tracing.
```

### Firefox
This profile has been tested with the standard `firefox` package as well as the AUR package `firefox-nightly`, and with OpenGL (default) and WebRender -- on the aforementioned hardware, on both Xorg and Sway. This single profile will apply to both Firefox and Firefox Nightly.

You will need to edit this file if your Firefox Nightly files are somewhere other than `/opt/firefox-nightly` (e.g. if you just download the binary from Mozilla's website).

The only directories in the home directory that Firefox is allowed to access are `~/{D,d}ownloads` and `~/.mozilla`. You won't be able to, for example, upload things to the web from your Documents directory. You'll need to copy the file to your downloads directory first.

### gpg-agent
This profile has only been tested with the gtk2 pinentry program. You may need to edit the profile to allow access to your GPG keys, if you keep them somewhere other than `~/.gnupg`.

### evince
This profile assumes you only want to view documents in `~/{D,d}ocuments/` and `~/{D,d}ownloads`. If you do not, edit the file. Evince does not need access to your whole home directory.

### irssi
You may need to edit the profile to allow `irssi` to access your configuration files, if they are symlinks to somewhere other than inside `~/.irssi/`.

### KeepassXC
This profile assumes you keep your database file in `~/{D,d}ocuments/`. If you do not, edit the file to where you store your database. KeepassXC does not need access to your whole home directory.

### Lollypop
This profile assumes you keep your music in `~/{M,m}usic`. If you do not, edit the file to where you store your database. Lollypop does not need access to your whole home directory.

I have not tested the profile for any web features, so they probably will not work.

### mako
You may need to edit the profile to allow `mako` to access your configuration file, if it's a symlink to somewhere other than inside `~/.config/mako/`.

### mpv
You may need to edit the profile to allow `mpv` to acces your configuration file, if it's a symlink to somehwere other than `~/.config/mpv`.

This profile allows mpv to utilize `youtube-dl` to stream videos and confines it in the `youtube-dl` AppArmor profile in this project. You will need the separate `youtube-dl` profile enabled for this functionality.

This AppArmor profile also works when mpv is invoked by other programs like [streamlink](https://streamlink.github.io/). A streamlink profile is also available.

Use the command line flag `--gpu-context=wayland` for Wayland support. Use the command line flag `--hwdec=auto` for nvdec (NVIDIA) and VA-API (Intel) hardware decoding. You can also tell `mpv` to always use these options [through a config file](https://mpv.io/manual/master/).

### redshift
This profile has been tested to work correctly on Xorg with the regular `redshift` package and on Sway with the `redshift-wlr-gamma-control` AUR package.

You may need to edit the profile to allow `redshift` to access your configuration file, if it's a symlink to somewhere other than `~/.config/redshift/redshift.conf`.

### ssh-agent
You may need to edit the profile to allow access to your SSH keys, if you keep them somewhere other than `~/.ssh`.

### streamlink
You will need to set either `mpv` or `vlc` as your default player. If you choose `mpv`, you must have the separate `mpv` AppArmor profile from this repository enabled. If you choose `vlc`, I have not written an AppArmor profile for it yet, so streamlink will execute `vlc` unconfined (less secure).

### swaybg
From the top of the profile:
```
# Please note: you may need to edit this file to specify the location of your
# wallpaper!
```

### syncthing
From the top of the profile:
```
# Please note: you will need to edit this file to allow syncthing to access your
# personal synced directories.
```

### waybar
From the top of the profile:
```
# Please note: this is an AppArmor profile for my personal setup and is only
# meant to be used with the modules I use, so may prevent some modules from
# loading on your setup. You will need to write your own personal rules if you
# use different modules.

# Modules tested to work: sway/workspaces, sway/mode, sway/window, network,
# pulseaudio, cpu, clock, tray
```

### youtube-dl
The only directory in the home directory youtube-dl is allowed to access is the `~/{D,d}ownloads` directory. Edit this profile if you prefer to download your videos elsewhere.

## Contributing
Writing AppArmor profiles is fairly easy. Pull requests and issues are welcome. I cannot test for hardware I do not have access to (AMD), so those PRs would be most critical.

To get started writing AppArmor profiles, I highly recommend this video from openSUSE: https://invidio.us/watch?v=o2xa8JYcrmw

"If you know how to use bash, chmod, and grep, you already understand AppArmor and you can probably reverse-engineer the policy by yourself," at 13:25 in the video: https://invidio.us/watch?v=k3kerBRYLhw

You may also find this document incredibly helpful: https://gitlab.com/apparmor/apparmor/wikis/AppArmor_Core_Policy_Reference

### Addendum: what is /etc/machine-id?
> Because it's possible to forward things like D-Bus, the X11 $DISPLAY, etc. over the network, two processes might be aware of each other over such a connection but not be running on the same machine and therefore be unable to share resources. The machine ID lets them check for that, so you can properly handle things like "I'm going to send a message to the screensaver in my display to not activate, I don't care if it's the same machine" vs. "I'm going to send a message to the terminal in my display to open a new tab, but only if it's actually on the same machine, otherwise I should start a new terminal". (These days I think that definition should be updated to "container" instead of "kernel": if you're running separate logical machines inside the same kernel with separate PIDs etc., they should have separate machine IDs.)

> systemd and (IIRC) cloud-init use it to run once-per-machine tasks on machines that could come from images: if you want to prep a number of machines in advance, do the install, then change the machine ID. At boot time, startup scripts will say "Oh, this machine ID has not been initialized yet" and do things, and then not do them on the next boot.

https://web.archive.org/web/20190813022810/https://news.ycombinator.com/item?id=19529708
