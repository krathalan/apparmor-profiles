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

I cannot guarantee that these profiles will work on any other hardware.

All profiles should work with Xorg on NVIDIA hardware and with Wayland (and probably Xorg) on Intel hardware.

⚠️ <--- This symbol means you will need to edit the profile for your specific configuration.

## Tested profiles
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

This complex profile has only been tested with the standard `firefox` package as well as the AUR package `firefox-nightly` on Arch Linux, and only with WebRender (on both Intel and Nvidia hardware, on both Wayland and Xorg). This single profile will apply to both Firefox and Firefox Nightly.

You will need to edit this file if your Firefox Nightly files are somewhere other than `/opt/firefox-nightly` (e.g. if you just download the binary from Mozilla's website).

The only directories in the home directory that Firefox is allowed to access are `~/{D,d}ownloads` and `~/.mozilla`. You won't be able to, for example, upload things to the web from your Documents directory. You'll need to copy the file to your downloads directory first.

### KeepassXC ⚠️
This fairly simple profile assumes you keep your database file in `~/{D,d}ocuments/`. If you do not, edit the file to where you store your database. KeepassXC does not need access to your whole home directory. Please keep isolated backups of your database files.

### Lollypop
This fairly simple profile assumes you keep your music in `~/{M,m}usic`. If you do not, edit the file to where you store your database. Lollypop does not need access to your whole home directory.

I have not tested the profile for any web features, so they probably will not work.

### mpv
This fairly complex profile also allows mpv to utilize youtube-dl. I have also verified that this AppArmor profile works when mpv is invoked by other programs (like [streamlink](https://streamlink.github.io/)).

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

## 🛑 New profiles
These profiles are new, and somewhat untested. Use at your own risk.

### bluetoothd
An extremely simple profile for the [`bluetoothd` executable started by the Systemd service `bluetooth.service`](https://wiki.archlinux.org/index.php/Bluetooth).

### gpg-agent
A relatively simple profile for the [standard `gpg-agent`](https://wiki.archlinux.org/index.php/GPG#gpg-agent). This profile has only been tested with the gtk2 pinentry program. Please keep isolated backups of your GPG keys.

### iwd
An extremely simple profile for the [new NetworkManager wireless backend, `iwd`](https://wiki.archlinux.org/index.php/Iwd).

### mako
An extremely simple profile for the [Wayland-native notification daemon, `mako`](https://github.com/emersion/mako). You may need to edit the profile to allow `mako` to access your configuration file, if it's a symlink to somewhere other than inside `~/.config/mako/`.

### NetworkManager
A relatively simple profile for the [standard `NetworkManager`](https://wiki.archlinux.org/index.php/Networkmanager).

### redshift
This extremely simple profile has been tested to work correctly on Wayland (sway) with the `redshift-wlr-gamma-control` AUR package. 

### ssh-agent
An extremely simple profile for the [standard `ssh-agent`](https://wiki.archlinux.org/index.php/SSH_agent#ssh-agent) (no pinentry). Please keep isolated backups of your ssh keys.

### swaybg ⚠️
An extremely simple profile for the [default sway background setter program, `swaybg`](https://github.com/swaywm/swaybg).

From the top of the profile: 
```
# Please note: you may need to edit this file to specify the location of your
# wallpaper!
```

### syncthing ⚠️
A fairly simple profile for the [decentralized file synchronization application, Syncthing](https://syncthing.net). This profile has not been tested extensively. Please keep isolated backups of your data, regardless of whether or not you use this profile.

From the top of the profile:
```
# Please note: you will need to edit this file to allow syncthing to access your
# personal synced directories.
```

### waybar ⚠️
A fairly simple profile for the [Wayland-native system bar, `waybar`](https://github.com/Alexays/Waybar).

From the top of the profile:
```
# Please note: this is an AppArmor profile for my personal setup and is only 
# meant to be used with the modules I use, so may prevent some modules from 
# loading on your setup. You will need to write your own personal rules if you 
# use different modules.

# Modules tested to work:
#   sway/workspaces, sway/mode, sway/window, network, pulseaudio, cpu, clock
```

### youtube-dl
A fairly simple profile for the [Internet video downloader, `youtube-dl`](https://github.com/ytdl-org/youtube-dl/).

The only directory in the home directory youtube-dl is allowed to access is the `~/{D,d}ownloads` directory. Edit this profile if you prefer to download your videos elsewhere.

## Contributing
Writing AppArmor profiles is fairly easy. Pull requests and issues are welcome. I cannot test for hardware I do not have access to (AMD), so those PRs would be most critical.

To get started writing AppArmor profiles, I highly recommend this video from openSUSE: https://invidio.us/watch?v=o2xa8JYcrmw

"If you know how to use bash, chmod, and grep, you already understand AppArmor and you can probably reverse-engineer the policy by yourself," at 13:25 in the video the video: https://invidio.us/watch?v=k3kerBRYLhw

You may also find this document incredibly helpful: https://gitlab.com/apparmor/apparmor/wikis/AppArmor_Core_Policy_Reference
