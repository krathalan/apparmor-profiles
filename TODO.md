# Miscellaneous notes for contributions

## General guidelines
As stated in the readme, profiles should strive to be at least ~95% functional with zero audit log warnings under proper behavior. Sometimes functionality should be blocked in the name of security, such as blocking hardware acceleration for applications which don't really require it.

## TODO
### Explore hardening options
- See abstractions/krathalans-hardening
- Enabled for profiles: discord, firefox, gpg-agent, mosh, pass, ssh, ssh-agent, waybar
- Is not enabled for profiles (but should be, pending testing): all

## Stats
### Most used abstractions
`grep -i abstractions usr.* | awk '{printf "%s\n", $3}' | grep -v "Graphics" | grep -v "Deny" | sort | uniq -c | sort --reverse --general-numeric-sort`

```
     26 <abstractions/base>
     11 <abstractions/krathalans-hardening>
     10 <abstractions/krathalans-networking>
      8 <abstractions/fonts>
      7 <abstractions/krathalans-common-gui>
      6 <abstractions/audio>
      5 <abstractions/dconf>
      3 <abstractions/wayland>
      3 <abstractions/user-tmp>
      3 <abstractions/user-download>
      3 <abstractions/python>
      3 <abstractions/perl>
      3 <abstractions/bash>
      2 <abstractions/krathalans-graphics>
      2 <abstractions/gnupg>
      1 <abstractions/ssl_keys>
      1 <abstractions/ssl_certs>
      1 <abstractions/openssl>
      1 <abstractions/dbus-session-strict>
```
