# apparmor-profiles
AppArmor profiles for various programs and services on Arch Linux.

Table of contents:  
1. [Notes about usage](#notes-about-usage)
2. [Abstractions](#abstractions)
3. [Adding local changes](#adding-local-changes)
4. [NVIDIA](#nvidia)
5. [Issues](#issues)
6. [Contributing](#contributing)

## Notes about usage
These AppArmor profiles have been tested on the following hardware:

- CPUs:
    - Intel 4960K
    - Intel 8250U
- GPUs:
    - NVIDIA GeForce GTX 980 Ti with proprietary drivers
    - Intel 620 UHD Graphics
- Network adapters:
    - Intel Wireless-AC 9260 (iwd and wpa_supplicant)
    - Broadcom BCM4360 (wpa_supplicant)
- Bluetooth adapters (bluetoothd):
    - Intel Wireless-AC 9260
    - Broadcom BCM20702A0

I cannot guarantee that these profiles will work on any other hardware. All profiles should work with Xorg on NVIDIA hardware and with Sway (and probably Xorg) on Intel hardware. However, it's very possible these profiles will still work with AMD graphics, as it seems AMD graphics share a lot of similar behavior with Intel graphics. If you own an NVIDIA card, please read the NVIDIA section below.

These profiles strive to be at least ~95% functional with zero audit log warnings under proper behavior. Functionality is not ignored. If functionality is not explicitly blocked, then it's probably a bug in the profile and should be fixed. Create an issue.

You should read through [the notes in `profiles/README.md`](profiles#profiles) before using these profiles.

## Abstractions
Many profiles require access to common files: icons, themes, and fonts for GUI applications; hardware acceleration resources; networking resources; and so on. To ease the burden of maintenance and to reduce policy error, many rules have been put into abstractions. Copy all files in the `abstractions/` folder in this repository to `/etc/apparmor.d/abstractions/`, then run  
`$ sudo systemctl reload apparmor.service`

Many profiles WILL NOT WORK if you do not have all abstractions loaded.

## Adding local changes
To add local changes without changing the file provided by this repository, use local overrides. See `less /etc/apparmor.d/local/README` for more details. You can see examples of local overrides in the `local/` directory in this repository.

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

You will also have to add `#include <abstractions/krathalans-hwaccel-nvidia>` to the Firefox, MPV, and VSCodium local profile override files in `/etc/apparmor.d/local`. Alternatively, you can simply copy all files from `local/nvidia` in this repository into `/etc/apparmor.d/local` and run `sudo systemctl reload apparmor.service`.

## Issues
Please file bug reports, requests, etc. at https://todo.sr.ht/~krathalan/apparmor-profiles

## Contributing
Writing AppArmor profiles is fairly easy. "If you know how to use bash, chmod, and grep, you already understand AppArmor and you can probably reverse-engineer the policy by yourself," at 13:25 in the video: https://invidio.us/watch?v=k3kerBRYLhw

Pull requests and issues are welcome. I cannot test for hardware I do not have access to (AMD), so those PRs would be most critical. Also, see [TODO.md](TODO.md).

To get started writing AppArmor profiles, I highly recommend this video from openSUSE: https://invidio.us/watch?v=o2xa8JYcrmw

You may also find this document incredibly helpful: https://gitlab.com/apparmor/apparmor/wikis/AppArmor_Core_Policy_Reference
