# apparmor-profiles

AppArmor profiles for various user applications.

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

I cannot guarantee that these profiles will work on any other hardware. All profiles should work with Xorg on NVIDIA hardware and with Sway (and probably Xorg) on Intel hardware.

⚠️ This symbol means you may/will need to edit the profile for your specific configuration. You can find more information for the specific program in the "Notes about each profile" section.

### Tested profiles
- Firefox
- KeepassXC ⚠️
- Lollypop ⚠️
- mpv ⚠️

### New and somewhat untested profiles
- bluetoothd
- discord
- gpg-agent ⚠️
- evince ⚠️
- hexchat
- iwd
- less
- mako ⚠️
- NetworkManager
- pipewire
- pulseaudio
- redshift ⚠️
- rngd
- ssh-agent ⚠️
- streamlink
- swaybg ⚠️
- syncthing ⚠️
- waybar ⚠️
- youtube-dl ⚠️

## Notes about each profile
### discord
This profile assumes you only want to upload files from `~/{D,d}ownloads`. If you do not, edit the file. Discord does not need access to your whole home directory.

Streamer mode and showing any currently playing games/music/etc. will not work as `ptrace` is completely disabled in this profile, as Discord tries to run `ptrace` on every program running on your machine. `ptrace` is an extremely dangerous capability. From the [`ptrace` manpage](http://man7.org/linux/man-pages/man2/ptrace.2.html):

```
The ptrace() system call provides a means by which one process (the
"tracer") may observe and control the execution of another process
(the "tracee"), and examine and change the tracee's memory and
registers.  It is primarily used to implement breakpoint debugging
and system call tracing.
```

### Firefox
From the top of the profile:

```
# Please note: you may have issues with hardware acceleration on NVIDIA hardware. 
# This is because the nvidia_modprobe profile in /etc/apparmor.d/ is configured 
# incorrectly. Change the profile executable name at the top of the 
# nvidia_modprobe profile file (/etc/apparmor.d/nvidia_modprobe) to 
# /usr/bin/nvidia-modprobe.

# Then rename the nvidia_modprobe file to usr.bin.nvidia-modprobe:
# $ mv /etc/apparmor.d/nvidia_modprobe /etc/apparmor.d/usr.bin.nvidia-modprobe
# Don't forget to enforce!
# $ aa-enforce /etc/apparmor.d/*
```

This profile has only been tested on Arch Linux with the standard `firefox` package as well as the AUR package `firefox-nightly`, and only with WebRender (on the aforementioned hardware). This single profile will apply to both Firefox and Firefox Nightly.

You will need to edit this file if your Firefox Nightly files are somewhere other than `/opt/firefox-nightly` (e.g. if you just download the binary from Mozilla's website).

The only directories in the home directory that Firefox is allowed to access are `~/{D,d}ownloads` and `~/.mozilla`. You won't be able to, for example, upload things to the web from your Documents directory. You'll need to copy the file to your downloads directory first.

### gpg-agent ⚠️
This profile has only been tested with the gtk2 pinentry program. You may need to edit the profile to allow access to your GPG keys, if you keep them somewhere other than `~/.gnupg`.

### evince ⚠️
This profile assumes you only want to view documents in `~/{D,d}ocuments/` and `~/{D,d}ownloads`. If you do not, edit the file. Evince does not need access to your whole home directory.

### KeepassXC ⚠️
This profile assumes you keep your database file in `~/{D,d}ocuments/`. If you do not, edit the file to where you store your database. KeepassXC does not need access to your whole home directory. Please keep isolated backups of your database files.

### Lollypop ⚠️
This profile assumes you keep your music in `~/{M,m}usic`. If you do not, edit the file to where you store your database. Lollypop does not need access to your whole home directory.

I have not tested the profile for any web features, so they probably will not work.

### mako ⚠️
You may need to edit the profile to allow `mako` to access your configuration file, if it's a symlink to somewhere other than inside `~/.config/mako/`.

### mpv ⚠️
You may need to edit the profile to allow `mpv` to acces your configuration file, if it's a symlink to somehwere other than `~/.config/mpv`.

This profile allows mpv to utilize `youtube-dl` to stream videos and confines it in the `youtube-dl` AppArmor profile in this project. You will need the separate `youtube-dl` profile enabled for this functionality. I have also verified that this AppArmor profile works when mpv is invoked by other programs like [streamlink](https://streamlink.github.io/).

Use the command line flag `--gpu-context=wayland` for Wayland support. Use the command line flag `--hwdec=auto` for nvdec (NVIDIA) and VA-API (Intel) hardware decoding. You can also tell `mpv` to always use these options [through a config file](https://mpv.io/manual/master/).

From the top of the profile:
```
# Please note: you may have issues with hardware decoding on NVIDIA hardware. 
# This is because the nvidia_modprobe profile in /etc/apparmor.d/ is configured 
# incorrectly. Change the profile executable name at the top of the 
# nvidia_modprobe profile file (/etc/apparmor.d/nvidia_modprobe) to 
# /usr/bin/nvidia-modprobe.

# Then rename the nvidia_modprobe file to usr.bin.nvidia-modprobe:
# $ mv /etc/apparmor.d/nvidia_modprobe /etc/apparmor.d/usr.bin.nvidia-modprobe
# Don't forget to enforce!
# $ aa-enforce /etc/apparmor.d/*
```

### redshift ⚠️
This profile has been tested to work correctly on Sway with the `redshift-wlr-gamma-control` AUR package.

You may need to edit the profile to allow `redshift` to access your configuration file, if it's a symlink to somewhere other than `~/.config/redshift/redshift.conf`.

### ssh-agent ⚠️
You may need to edit the profile to allow access to your SSH keys, if you keep them somewhere other than `~/.ssh`.

### streamlink
You will need to set `mpv` as your default player and have the separate `mpv` AppArmor profile from this repository enabled.

### swaybg ⚠️
From the top of the profile: 
```
# Please note: you may need to edit this file to specify the location of your
# wallpaper!
```

### syncthing ⚠️
From the top of the profile:
```
# Please note: you will need to edit this file to allow syncthing to access your
# personal synced directories.
```

### waybar ⚠️
From the top of the profile:
```
# Please note: this is an AppArmor profile for my personal setup and is only 
# meant to be used with the modules I use, so may prevent some modules from 
# loading on your setup. You will need to write your own personal rules if you 
# use different modules.

# Modules tested to work: sway/workspaces, sway/mode, sway/window, network,
# pulseaudio, cpu, clock, tray
```

### youtube-dl ⚠️
The only directory in the home directory youtube-dl is allowed to access is the `~/{D,d}ownloads` directory. Edit this profile if you prefer to download your videos elsewhere.

## Contributing
Writing AppArmor profiles is fairly easy. Pull requests and issues are welcome. I cannot test for hardware I do not have access to (AMD), so those PRs would be most critical.

To get started writing AppArmor profiles, I highly recommend this video from openSUSE: https://invidio.us/watch?v=o2xa8JYcrmw

"If you know how to use bash, chmod, and grep, you already understand AppArmor and you can probably reverse-engineer the policy by yourself," at 13:25 in the video: https://invidio.us/watch?v=k3kerBRYLhw

You may also find this document incredibly helpful: https://gitlab.com/apparmor/apparmor/wikis/AppArmor_Core_Policy_Reference
