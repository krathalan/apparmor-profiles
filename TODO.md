# Miscellaneous notes for contributions

## General guidelines
As stated in the readme, profiles should strive to be at least ~95% functional with zero audit log warnings under proper behavior. Sometimes functionality should be blocked in the name of security, such as blocking hardware acceleration for applications which don't really require it.

## TODO
### Explore hardening options
- See abstractions/krathalans-hardening
- Enabled for profiles: bluetoothd, evince, firefox, gpg-agent, iwd, mosh, NetworkManager, NetworkManager//resolvconf, NetworkManager//systemctl, pass, pulseaudio, ssh, ssh-agent, waybar, wpa_supplicant
- Is not enabled for profiles (but should be, pending testing): all

## Stats
### Most used abstractions
`grep -i abstractions profiles/* | awk '{printf "%s\n", $3}' | grep -v "Graphics" | grep -v "Deny" | sort | uniq -c | sort --reverse --general-numeric-sort`

```
     29 <abstractions/base>
     15 <abstractions/krathalans-hardening>
      9 <abstractions/krathalans-networking>
      7 <abstractions/fonts>
      6 <abstractions/krathalans-common-gui>
      5 <abstractions/dconf>
      5 <abstractions/audio>
      4 <abstractions/bash>
      3 <abstractions/wayland>
      3 <abstractions/user-tmp>
      3 <abstractions/user-download>
      3 <abstractions/python>
      3 <abstractions/perl>
      2 <abstractions/krathalans-hwaccel>
      2 <abstractions/gnupg>
      1 <abstractions/ssl_keys>
      1 <abstractions/ssl_certs>
      1 <abstractions/openssl>
      1 <abstractions/dbus-session-strict>
```
