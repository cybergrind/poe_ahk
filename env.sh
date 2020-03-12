#!/bin/env bash

export WINE_BASE='Proton-5.2-GE-2'
export STEAM_COMPAT_DATA_PATH=/home/kpi/games/SteamLibrary/steamapps/compatdata/238960
export WINEPREFIX="${STEAM_COMPAT_DATA_PATH}/pfx"
export WINEESYNC=1
export WINE="/home/kpi/.local/share/Steam/compatibilitytools.d/${WINE_BASE}/dist/bin/wine"
export AHK="${STEAM_COMPAT_DATA_PATH}/pfx/drive_c/Program Files/AutoHotkey/AutoHotkey.exe"
