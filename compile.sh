#!/usr/bin/env bash

set -e

echo "Xmas compile.sh script"

FSUFFIX="zZz_XMAS_EVENT_v23_pak"
ZIPSPLIT=134217728 # 128 MiB
PAK=0

# 7z command varies depending on distro
ZIPCOMMAND=""
EXES=("7z" "7za" "7zz")
for EXE in "${EXES[@]}"; do
    if [[ -x "$(command -v "$EXE")" ]]; then
        ZIPCOMMAND="$(command -v "$EXE")"
        break
    fi
done

if [[ ! -x "$ZIPCOMMAND" ]]; then
    echo "7zip not available"
    exit
fi

echo "Using 7zip ($ZIPCOMMAND)"

# remove any existing pk3s
if [[ -f "$FSUFFIX$PAK.pk3" ]]; then
    rm ./*.pk3
fi

echo "Compiling data..."
"$ZIPCOMMAND" a -tzip "$FSUFFIX$PAK.pk3" "./data/"* >/dev/null 2>&1

# read in map list
MAPSRAW=()
while IFS='' read -r L; do
    if [[ "${L:0:1}" == '#' || -z "$L" ]]; then
        continue
    fi

    if [[ ! -d "maps/maps/$L" ]]; then
        echo "Directory (maps/$L) from maplist does not exist"
        continue
    fi

    MAPSRAW+=("$L")
done < maps/maplist

# reverse sort
MAPS=()
readarray -td '' MAPS < <(printf '%s\0' "${MAPSRAW[@]}" | sort -r -z)

echo "Found ${#MAPS[*]} maps in maplist"
echo "Compiling map pk3s..."

# build
COUNT=1
for MAP in "${MAPS[@]}"; do
    MAPSIZE="$(du -s -b "maps/maps/$MAP" | cut -f1)"
    printf "%2i / %-2i %-32s %-4s %10d KiB \n" $COUNT "${#MAPS[*]}" "$MAP" "pak$PAK" $((MAPSIZE / 1024))

    ZIPSIZE=0
    if [[ -f "$FSUFFIX$PAK.pk3" ]]; then
        ZIPSIZE="$(du -s -b "$FSUFFIX$PAK.pk3" | cut -f1)"
    fi
    ZIPSIZE=$((ZIPSIZE + MAPSIZE))
    "$ZIPCOMMAND" a -tzip "$FSUFFIX$PAK.pk3" "./maps/maps/$MAP/"* >/dev/null 2>&1

    if [[ "$ZIPSIZE" -gt "$ZIPSPLIT" ]]; then
        PAK=$((PAK + 1))
    fi
    COUNT=$((COUNT + 1))
done

sha1sum "$FSUFFIX"*.pk3