#!/bin/bash

WORK_DIR=`dirname $0`

zenity --title="smarthosts for *nix" --info --text="更新到最新的hosts"


gksu $WORK_DIR/smarthosts_nix.bash
