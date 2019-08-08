# apparmor-profiles

AppArmor profiles for various user applications.

## Notes about usage
These AppArmor profiles have been verified to work on the following hardware:

1. CPUs:
    1. Intel 4960K
    2. Intel 8250U
2. GPUs:
    1. NVIDIA GeForce GTX 980 Ti
    2. Intel 620 UHD Graphics

I cannot guarantee that these profiles will work on any other hardware.

All profiles should work with Xorg on NVIDIA hardware and with Wayland (and probably Xorg) on Intel hardware.

## Notes about each profile
### Firefox Nightly
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

This profile has only been tested with the AUR package `firefox-nightly` on Arch Linux, and only with WebRender (on both Intel and Nvidia hardware, on both Wayland and Xorg). You will need to edit this file if your Firefox Nightly files are somewhere other than `/opt/firefox-nightly`.

The only files in the home directory that Firefox is allowed to access are `~/{D,d}ownloads` and `~/.mozilla`. You won't be able to, for example, upload things to the web from your Documents directory. You'll need to copy the file to your downloads directory first.

### gpg-agent
A relatively simple profile for the standard `gpg-agent`. This profile has only been tested with the gtk2 pinentry program.

### KeepassXC
This profile assumes you keep your database file in `~/{D,d}ocuments/`. If you do not, edit the file to where you store your database. KeepassXC does not need access to your whole home directory.

### Lollypop
This profile assumes you keep your music in `~/{M,m}usic`. If you do not, edit the file to where you store your database. Lollypop does not need access to your whole home directory.

I have not tested the profile for any web features, so they probably will not work.

### mako
A profile for the Wayland-native notification daemon, `mako`.

### mpv
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

This AppArmor profile also allows mpv to utilize youtube-dl. I have also verified that this AppArmor profile works when mpv is invoked by other programs (like [streamlink](https://streamlink.github.io/)).

Use the command line flag `--gpu-context=wayland` for Wayland support.

Use the command line flag `--hwdec=auto` for nvdec (NVIDIA) and VA-API (Intel) hardware decoding.

### redshift
Very much a work-in-progress profile. Not ready for usage.

### ssh-agent
An extremely simple profile for the standard `ssh-agent` (no pinentry).

### swaybg
A relatively simple profile for the default sway background setter program `swaybg`.

### waybar
From the top of the profile:
```
# Please note:
#   This is an AppArmor profile for my personal setup and is only meant to be
#   used with the modules I use, so may prevent some modules from loading on
#   your setup. You will need to write your own personal rules if you use
#   different modules.

# Modules tested to work:
#   sway/workspaces, sway/mode, sway/window, network, pulseaudio, cpu, clock
```

## Contributing
Pull requests and issues are welcome. I cannot test for hardware I do not have access to (AMD), so those PRs would be most critical.
