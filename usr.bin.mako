# AppArmor profile for mako notification daemon for Wayland
# Homepage: https://gitlab.com/krathalan/apparmor-profiles
# Copyright 2019 (C) krathalan; Licensed under GPLv3

#include <tunables/global>

profile mako /usr/bin/mako {
  #include <abstractions/base>
  #include <abstractions/fonts>
  
  # Application icons
  /usr/share/icons/** r,
  /usr/share/mime/** r,
  owner @{HOME}/.local/share/mime/** r,
  
  # Shared memory
  owner /dev/shm/mako* rw,
  
  # Config file
  owner @{HOME}/.config/mako/** r,
  # Config file at ~/.config/mako/config is a symlink to this file
  owner @{HOME}/documents/config/mako-config r,
  
  # Deny unnecessary permissions
  deny /usr/share/fonts/** w,
  deny /usr/share/pixmaps/ r,
}
