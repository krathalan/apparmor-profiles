# Miscellaneous notes for contributions

## General guidelines
As stated in the readme, profiles should strive to be at least ~95% functional with zero audit log warnings under proper behavior. Sometimes functionality should be blocked in the name of security, such as blocking hardware acceleration for applications which don't really require it.

## TODO
### Explore hardening options
- See abstractions/krathalans-hardening
- Enabled for profiles: firefox, gpg-agent, mosh, ssh, ssh-agent
- Is not enabled for profiles (but should be, pending testing): discord, evince, irssi, less, lollypop, mako, mpv, NetworkManager, pulseaudio, redshift, rngd, streamlink, swaybg, syncthing, transmission-cli, waybar, wpa_supplicant, youtube-dl, bluetoothd, iwd

### Reduce usage of nameservice abstraction
<abstractions/nameservice> contains a lot of rules which many programs don't need all of. Explore removing this abstraction and using more rules (or perhaps a custom network abstraction) for the following profiles: discord, firefox, irssi, NetworkManager, streamlink, syncthing, transmission-cli, youtube-dl

## Stats
### Most used abstractions
`grep -i abstractions usr.* | awk '{printf "%s\n", $3}' | grep -v "Graphics" | grep -v "Deny" | sort | uniq -c | sort --general-numeric-sort`

```
      1 <abstractions/dbus-session-strict>
      1 <abstractions/gnupg>
      1 <abstractions/ssl_certs>
      1 <abstractions/ssl_keys>
      1 <abstractions/user-tmp>
      2 <abstractions/bash>
      2 <abstractions/krathalans-graphics>
      3 <abstractions/perl>
      3 <abstractions/python>
      3 <abstractions/user-download>
      3 <abstractions/wayland>
      4 <abstractions/gnome>
      5 <abstractions/dconf>
      5 <abstractions/krathalans-hardening>
      6 <abstractions/audio>
      6 <abstractions/krathalans-common-gui>
      7 <abstractions/fonts>
      7 <abstractions/openssl>
      8 <abstractions/nameservice>
     25 <abstractions/base>
```
