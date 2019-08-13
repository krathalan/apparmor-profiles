# AppArmor profile for mako notification daemon for Wayland
# Version of mako profiled: 1.4
# Homepage: https://gitlab.com/krathalan/apparmor-profiles
# Copyright 2019 (C) krathalan; Licensed under GPLv3

#include <tunables/global>

profile mako /usr/bin/mako {
  #include <abstractions/base>
  #include <abstractions/fonts>

  #include <abstractions/krathalans-common-gui>
  
  # Shared memory
  owner /dev/shm/mako* rw,
  
  # Config file
  owner @{HOME}/.config/mako/** r,
  # Config file at ~/.config/mako/config is a symlink to this file
  owner @{HOME}/documents/config/mako-config r,
}
