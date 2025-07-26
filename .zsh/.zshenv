#!/usr/bin/env zsh

# Disable Global RCs
#--------------------
# Prevents zsh from reading config files from /etc, except for /etc/zshenv

unsetopt global_rcs

export XDG_DATA_DIRS="${XDG_DATA_DIRS}:/usr/local/share:/usr/share:/var/lib/flatpak/exports/share:/home/me/.local/share/flatpak/exports/share"
