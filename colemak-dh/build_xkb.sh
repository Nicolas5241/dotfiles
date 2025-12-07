#!/usr/bin/bash

dirname=$(dirname "$0")
"$dirname/klfc" "$dirname/colemak.json" "$dirname/altgr_colemak.jso"n "$dirname/extend.json" --xkb "$dirname/xkb" --combine-mods
