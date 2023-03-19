# Pakfiles

## Naming

The .pk3 naming convention for this project is:
`zZz_XMAS_EVENT_v<year>_pak<id>.pk3`

e.g.: 
```
zZz_XMAS_EVENT_v23_pak0.pk3
zZz_XMAS_EVENT_v23_pak1.pk3
etc...
```

## Pak breakdown

Paks should be limited to 1024 files maximum and be <128 MB each for ease of downloading. Files should be split into the following paks:

### pak0

- Effects (fx)
- Graphics (gfx)
- Sounds
- Soundaliases
- Shaders (scripts/shadertypes)
- Vehicles
- Weapons
- xmodels, xmodelparts, xmodelsurfs

### pak1

- Environment maps (env)
- Levelshots
- Maps
- Map scripts
- Textures

### pak2 (if necessary)

- Environment maps (env)
- Levelshots
- Maps
- Map scripts
- Textures
