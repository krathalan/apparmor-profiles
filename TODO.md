# Miscellaneous notes for contributions

## General guidelines
As stated in the readme, profiles should strive to be at least ~95% functional with zero audit log warnings under proper behavior. Sometimes functionality should be blocked in the name of security, such as blocking hardware acceleration for applications which don't really require it.

## TODO
### Explore hardening options
- See abstractions/krathalans-hardening
- Enabled for profiles: firefox, gpg-agent, mosh, ssh, ssh-agent
- Is not enabled for profiles (but should be, pending testing): discord, evince, irssi, less, lollypop, mako, mpv, NetworkManager, pulseaudio, redshift, rngd, streamlink, swaybg, syncthing, transmission-cli, waybar, wpa_supplicant, youtube-dl, bluetoothd, iwd

### Reduce usage of gnome abstraction
<abstractions/gnome> contains a lot of rules which many programs don't need all of. Explore removing this abstraction and using more rules (or perhaps a custom abstraction).

The following profiles use <abstractions/gnome>: discord, firefox, evince, waybar

## Stats
### Most used abstractions
`grep -i abstractions usr.* | awk '{printf "%s\n", $3}' | grep -v "Graphics" | grep -v "Deny" | sort | uniq -c | sort --reverse --general-numeric-sort`

```
     25 <abstractions/base>
      8 <abstractions/krathalans-networking>
      7 <abstractions/openssl>
      7 <abstractions/fonts>
      6 <abstractions/krathalans-common-gui>
      6 <abstractions/audio>
      5 <abstractions/krathalans-hardening>
      5 <abstractions/dconf>
      4 <abstractions/gnome>
      3 <abstractions/wayland>
      3 <abstractions/user-download>
      3 <abstractions/python>
      3 <abstractions/perl>
      2 <abstractions/krathalans-graphics>
      2 <abstractions/bash>
      1 <abstractions/user-tmp>
      1 <abstractions/ssl_keys>
      1 <abstractions/ssl_certs>
      1 <abstractions/nameservice>
      1 <abstractions/gnupg>
      1 <abstractions/dbus-session-strict>
```
