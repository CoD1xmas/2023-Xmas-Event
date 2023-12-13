#!/usr/bin/env bash

echo "Xmas compile.sh script"

FSUFFIX="zZz_XMAS_EVENT_v23_pak"
ZIPSPLIT=134217728 # 128 MiB
PAK=0

# 7z command varies depending on distro
ZIPCOMMAND=`command -v 7z`
if [[ -z "$ZIPCOMMAND" ]]; then
    ZIPCOMMAND=`command -v 7za`
fi
if [[ -z "$ZIPCOMMAND" ]]; then
    ZIPCOMMAND=`command -v 7zz`
fi
if [[ -z "$ZIPCOMMAND" ]]; then
    echo "7zip not available"
    exit
fi

# remove any existing pk3s
if [[ -f "$FSUFFIX$PAK.pk3" ]]; then
    rm *.pk3
fi

echo "Compiling data..."
ZIPOUTPUT=$($ZIPCOMMAND a -tzip "$FSUFFIX$PAK.pk3" "./data/"*) #>/dev/null 2>&1

# read in map list
MAPSRAW=()
while IFS='' read -r L; do
    if [[ "${L:0:1}" == '#' || -z "$L" ]]; then
        continue
    fi

    if [[ ! -d "maps/maps/$L" ]]; then
        echo "Directory (maps/\"$L\") from maplist does not exist"
        continue
    fi

    MAPSRAW+=("$L")
done < maps/maplist

# reverse sort
MAPS=()
readarray -td '' MAPS < <(printf '%s\0' "${MAPSRAW[@]}" | sort -r -z)

echo "Found ${#MAPS[@]} maps in maplist"
echo "Compiling map pk3s..."

# build
i=1
for MAP in "${MAPS[@]}"; do
    MAPSIZE=$(du -s -b "maps/maps/$MAP" | cut -f1)
    printf "%2i / %-2i %-32s %-4s %10d KiB \n" $i ${#MAPS[@]} $MAP "pak$PAK" $(($MAPSIZE / 1024))

    ZIPSIZE=0
    if [[ -f "$FSUFFIX$PAK.pk3" ]]; then
        ZIPSIZE=$(du -s -b "$FSUFFIX$PAK.pk3" | cut -f1)
    fi
    ZIPSIZE=$((ZIPSIZE + "$MAPSIZE"))
    ZIPOUTPUT=$($ZIPCOMMAND a -tzip "$FSUFFIX$PAK.pk3" "./maps/maps/$MAP/"*) #>/dev/null 2>&1

    if [[ "$ZIPSIZE" -gt "$ZIPSPLIT" ]]; then
        PAK=$((PAK + 1))
    fi
    i=$((i+1))
done