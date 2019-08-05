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
### KeepassXC
This profile assumes you keep your database file in `~/documents/`. If you do not, edit the file to where you store your database. KeepassXC does not need access to your whole home directory.

### Lollypop
This profile assumes you keep your music in `~/music`. If you do not, edit the file to where you store your database. Lollypop does not need access to your whole home directory.

I have not tested the profile for any web features, so they probably will not work.

### mpv
From the top of the mpv AppArmor profile:

```
# Please note: you may have issues with hardware decoding. This is because the nvidia_modprobe profile in
# /etc/apparmor.d/ is not configured correctly. Change the profile executable at the top of the
# nvidia_modprobe profile file (/etc/apparmor.d/nvidia_modprobe) to /usr/bin/nvidia-modprobe.

# Then rename the nvidia_modprobe file to usr.bin.nvidia-modprobe:
# $ sudo mv /etc/apparmor.d/nvidia_modprobe /etc/apparmor.d/usr.bin.nvidia-modprobe
# Don't forget to enforce!
# $ sudo aa-enforce /etc/apparmor.d/*
```

This AppArmor profile also allows mpv to utilize youtube-dl. I have also verified that this AppArmor profile works when mpv is invoked by other programs (like [streamlink](https://streamlink.github.io/)).

Use the command line flag `--gpu-context=wayland` for Wayland support.

Use the command line flag `--hwdec=auto` for nvdec (NVIDIA) and VA-API (Intel) hardware decoding.

## Contributing
Pull requests and issues are welcome. I cannot test for hardware I do not have access to (AMD), so those PRs would be most critical.
