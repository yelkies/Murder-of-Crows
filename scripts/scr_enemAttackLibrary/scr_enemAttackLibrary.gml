// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function GetEnemyAttackLibrary(_name, _combo) 
{
		
	// create movesets here
	var _general_moveset = {
		L : ["Light1",3],
		LL : ["Light2",4],
		"H" : ["Heavy1",8],
		"D" : ["Dash1",5],
		"E" : ["Evade",0]
		}
		
	var _eins_moveset = {
		L: "teet"
	}
		
		
	// add created movesets and object names to this struct
		movesets = {
		"obj_plyr_eins": _eins_moveset,
		"general": _general_moveset,
	}
	
	
	
	
	
	// movesets are obtain through code below
	combo = _combo
	MovesetName = _name
	generalMoveSet = _general_moveset
	if interateEnemMovesets(MovesetName, movesets) != undefined 
	{
	_returnSet = interateEnemMovesets(MovesetName, movesets)
	}else
	{
		_returnSet = generalMoveSet
	}
	
	if _returnSet[$ _combo] == undefined {
		_returnSet = generalMoveSet;
	 	if _returnSet[$ _combo] == undefined {
		returnSet = "None";
		}
	}
	else 
	returnSet = _returnSet[$ _combo]
	
return returnSet;
}

//function interateEnemMovesets(_name, movesets){
//	name = _name
//	output = undefined
//	struct_foreach(movesets, function(identity, moveset){
//		if (identity == name){
//		output = moveset
//	}
//	})
//	return output
//}