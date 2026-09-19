// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information


	
function GetMoveset(_name, _combo) 
{
	_cha = sprite_get_name(asset_get_index(_name).defaultSpr)
	// create movesets here
	var _general_moveset = { // name, damage, sprite, hitbox
		"L": {name:"Light1",	dmg:3,	anim:spr_plyr_eins_attack_L1_side,	hb:spr_plyr_eins_attack_L1_hb_side},
		"H" : {name:"Heavy1",	dmg:8,	anim:spr_plaho_A1,	hb:_cha},
		"D" : {name:"Dash1",	dmg:5,	anim:_cha + "_attack_L3",	hb:_cha + "_attack_L3_hb", thrust:22.5},
		"E" : {name:"Evade",	dmg:0,	anim:spr_plaho_4,	hb:_cha},
		"LL": {name:"Light2",	dmg:4,	anim:_cha + "_attack_L3",	hb:_cha + "_attack_L3_hb", status_effects:{"Buttsex" : 20}},
		"LH": {name:"LightHeavy1", dmg:8, anim:spr_plaho_5, hb:_cha},
		"DL": {name:"DashLight1", dmg:10, anime:spr_plaho_6, hb:_cha},
		"LLL" : {name:"Light3",	dmg:5, anim:_cha + "_attack_L3", hb:_cha + "_attack_L3_hb"},
		"LLHH": {}
		}
		
	var _eins_moveset = {
		L : {name:"teet",	dmg:3,	anim:_cha + "_attack_L3",	hb:_cha + "_attack_L3_hb", kb: 7.5, status_effects:{"Fever" : 10}},
		HL : {name:"Bite",	dmg:8,	anim:spr_plaho_7,	hb:_cha, status_effects:{"Fever" : 10}, projectile: obj_plyr_attack_projectile},
		"DLD" : {name:"DLD", dmg:12, anim:spr_plaho_3, hb:_cha},
		"HH" : {name:"1-inch punch", dmg:20, anim:spr_plaho_1, hb:_cha},
		"EH" : {name:"Sudden stop", dmg:7, anim:spr_plaho_2, hb:_cha}
	}
		
		
	// add created movesets and object names to this struct
		movesets = {
		"obj_plyr_eins": _eins_moveset,
		"general": _general_moveset,
	}
	
	
	
	
	
	// movesets are obtained through code below
	generalMoveSet = _general_moveset //sets generalMoveset variable to the general moveset
	if struct_exists(movesets, _name)		//if a struct exists with the instance's name...
	{
		var instance_move_set = struct_get(movesets, _name); //a variable is set to the struct
		
		if struct_exists(instance_move_set, _combo)
		{  //if a combo(string combination) exists within the struct....
			var combo_move = struct_get(instance_move_set, _combo) // the combo move is confirmed and returned
		}
		else
		{
			var instance_move_set = struct_get(movesets, "general"); //if no combo is found, we switch to the general moveset
			
			if struct_exists(instance_move_set, _combo)		// the general moveset is scanned for the combo
			{
				var combo_move = struct_get(instance_move_set, _combo) //if found, the combo move is confirmed and returned
			}
			else
			{
				var combo_move = "None" //if no combo(string combonation) is found in either moveset, "none" is returned to reset the combo
			}
		}
	}
	else
	{
		var instance_move_set = struct_get(movesets, "general");
		
		if struct_exists(instance_move_set, _combo)
		{
			var combo_move = struct_get(instance_move_set, _combo)
		}
		else
		{
			var combo_move = "None"
		}
	}
	
	return combo_move
	}
