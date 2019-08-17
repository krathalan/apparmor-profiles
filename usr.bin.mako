# AppArmor profile for mako notification daemon for Wayland
# Version of mako profiled: 1.4
# Homepage: https://gitlab.com/krathalan/apparmor-profiles
# Copyright 2019 (C) krathalan; Licensed under GPLv3

#include <tunables/global>

profile mako /usr/bin/mako {
  #include <abstractions/base>
  #include <abstractions/fonts>

  # Icons, themes, etc
  #include <abstractions/krathalans-common-gui>

  # Include user overrides for possible symlinked config files
  #include <local/usr.bin.mako>
 
  # Shared memory
  owner /dev/shm/mako* rw,
  
  # Config file
  owner @{HOME}/.config/mako/** r,
}
