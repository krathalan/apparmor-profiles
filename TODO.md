# Miscellaneous notes for contributions

## General guidelines
As stated in the readme, profiles should strive to be at least ~95% functional with zero audit log warnings under proper behavior. Sometimes functionality should be blocked in the name of security, such as blocking hardware acceleration for applications which don't really require it.

## TODO
### Explore hardening options
- See abstractions/krathalans-hardening
- Enabled for profiles: discord, firefox, gpg-agent, mosh, ssh, ssh-agent
- Is not enabled for profiles (but should be, pending testing): all

### Reduce usage of gnome abstraction
<abstractions/gnome> contains a lot of rules which many programs don't need all of. Explore removing this abstraction and using more rules (or perhaps a custom abstraction).

The following profiles use <abstractions/gnome>: evince, waybar

## Stats
### Most used abstractions
`grep -i abstractions usr.* | awk '{printf "%s\n", $3}' | grep -v "Graphics" | grep -v "Deny" | sort | uniq -c | sort --reverse --general-numeric-sort`

```
     25 <abstractions/base>
      9 <abstractions/krathalans-networking>
      8 <abstractions/fonts>
      7 <abstractions/krathalans-common-gui>
      6 <abstractions/krathalans-hardening>
      6 <abstractions/audio>
      5 <abstractions/dconf>
      3 <abstractions/wayland>
      3 <abstractions/user-download>
      3 <abstractions/python>
      3 <abstractions/perl>
      2 <abstractions/user-tmp>
      2 <abstractions/openssl>
      2 <abstractions/krathalans-graphics>
      2 <abstractions/gnome>
      2 <abstractions/bash>
      1 <abstractions/ssl_keys>
      1 <abstractions/ssl_certs>
      1 <abstractions/nameservice>
      1 <abstractions/gnupg>
      1 <abstractions/dbus-session-strict>
```
