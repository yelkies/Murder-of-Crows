/// @description Insert description here
// You can write your code in this editor

if (xspd != 0) _facing = "_side"
else if (yspd < 0) _facing = "_up"
else if (yspd > 0) _facing = "_down";
	
if (xspd < 0) image_xscale = abs(image_xscale) * -1
else if (xspd !=0 || yspd != 0) image_xscale = abs(image_xscale);

sprite_index = asset_get_index(spr_idle + _facing);
mask_index = asset_get_index(spr_idle + _facing);



