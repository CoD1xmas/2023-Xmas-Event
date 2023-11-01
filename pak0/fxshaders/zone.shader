ui/assets/background_mask
{
	nopicmip
	nomipmaps
	{
		map clamp ui/assets/background_mask.tga
		blendFunc GL_SRC_ALPHA GL_ONE_MINUS_SRC_ALPHA
		rgbGen vertex
	}
}

textures/BattleRoyal/gas/zone_gas1
{
	qer_editorimage textures/BattleRoyal/gas/zone_gas1.tga
    	sort    additive
	polygonoffset
	surfaceparm nonsolid
	surfaceparm trans
	surfaceparm noshadow
	{
		map textures/BattleRoyal/gas/zone_gas1.tga
		blendFunc blend
		rgbGen exactvertex
		tcMod scale 0.25 0.35
		tcMod scroll 0.02 -0.002
	}

	{
		map textures/BattleRoyal/gas/zone_gas1.tga
		blendFunc blend
		rgbGen exactvertex
		tcMod scale 0.1 0.25
		tcMod scroll 0.008 -0.008
	}

	{
		map textures/BattleRoyal/gas/zone_gas1.tga
		blendFunc blend
		rgbGen exactvertex
		tcMod scale -0.25 -0.35
		tcMod scroll -0.04 0.01
	}

	{
		map textures/BattleRoyal/gas/zone_gas1.tga
		blendFunc blend
		rgbGen exactvertex
		tcMod scale -0.1 -0.25
		tcMod scroll -0.01 0.01
	}

	{
		map textures/BattleRoyal/gas/zone_gas2.tga
		blendFunc blend
		rgbGen exactvertex
		tcMod scale 0.2 0.2
		tcMod scroll 0.055 -0.04
	}

}

textures/BattleRoyal/gas/gas_effect
{
	qer_editorimage textures/BattleRoyal/gas/gas_effect.tga
    	sort    additive
	polygonoffset
	surfaceparm nonsolid
	surfaceparm trans
	surfaceparm noshadow
	{
		map textures/BattleRoyal/gas/gas_effect.tga
		blendFunc blend
		rgbGen exactvertex
		tcMod scale -0.1 -0.25
		tcMod scroll -0.01 0.01
	}

	{
		map textures/BattleRoyal/gas/zone_gas1.tga
		blendFunc blend
		rgbGen exactvertex
		tcMod scale 0.25 0.35
		tcMod scroll 0.02 -0.002
	}

	{
		map textures/BattleRoyal/gas/zone_gas1.tga
		blendFunc blend
		rgbGen exactvertex
		tcMod scale 0.1 0.25
		tcMod scroll 0.008 -0.008
	}
}
