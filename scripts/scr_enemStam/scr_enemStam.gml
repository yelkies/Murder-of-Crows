stam_Max = enem_Stats.stam_Max;
stam_Gain_Timer = 0;
stam_Gain = enem_Stats.stam_Gain_Rate;

stam_Current = stam_Max;


function scr_enemStam(){


stam_Gain_Timer = 0;
stam_Current = stam_Max;

//stam_Gain_Timer++

if (stam_Gain_Timer > 30) {
	
	stam_Current += stam_Gain * stam_Max;
	stam_Current = clamp(stam_Current, 0, stam_Max);
	
	stam_Gain_Timer = 0;

}



stam_Current -= stam_Loss("D");

}

input = "";

function stam_Loss(_input){
stam_Loss_Final = 0;
input = _input;

struct_foreach(_input_moveset,function(_code, _loss)
	{
		
		if (stam_Current - _loss > 0) & (input == _code)
			{	
			stam_Loss_Final = _loss;

			}
		else
			{
			show_debug_message("nah")
			}
		
	})

 
 }
	
function attack_Logic(){
	
	held_Actions = {};
	held_Combos = {};
	held_Combos_List = [];
	_input_moveset = {
		D : 3.5,
		H : 2.4,
		E : 2.7,
		L : 1
		}
		
	_combo_Moveset = { //test moveset. replace with enemy moveset function later
		"L" : ["Light1",3],
		"LL" : ["Light2",4],
		"LH" : ["LH Mix",4],
		"LLH" : ["L2H Mix",4],
		"LLL" : ["Light3",4],
		"LLLL" : ["Bullet Punch",4],
		"H" : ["Heavy1",8],
		"HH" : ["Heavy2",8],
		"HHH" : ["Judge, Jury, Executioner",8],
		"HHL" : ["H2L Mix",8],
		"HD" : ["Spring Punch",8],
		"HE" : ["Heavy Weave",8],
		"HL" : ["Follow-up",8],
		"D" : ["Dash1",5],
		"DL" : ["Engage",5],
		"DLD" : ["Disengage",5],
		"DLL" : ["Engage2",5],
		"DD" : ["Dash2",5],
		"E" : ["Evade",0]
		}
	
	struct_foreach(_input_moveset, function(_code, _loss){    //parse through attack types and log stamina costs
	
		if (stam_Current - _loss > 0){
		
			struct_set(held_Actions, _code, _loss)
		
			}
		})
		
	struct_foreach(held_Actions, function(_code, _loss){
	
		if struct_exists(_combo_Moveset, combo_Current + _code){
		full_Combo = combo_Current + _code;
		struct_set(held_Combos, full_Combo, struct_get(_combo_Moveset, full_Combo));
		array_insert(held_Combos_List, -1, full_Combo);
		}
		else{
		 array_insert(held_Combos_List, -1, "Null");
		}
	})
	
	return struct_get(held_Combos, held_Combos_List[random(array_length(held_Combos_List))])
}

function scr_enemFear(damage){
	
	array_insert(dmg_Values,-1,damage);
	dmg_Sum = 0;
	array_foreach(dmg_Values, function(value){
		
		dmg_Sum += value;
		
	});
		
	dps = dmg_Sum/((combat_Timer/60) + 1);
	fear = (dps / MaxHp) * (1/2) + (1 - stam_Current/stam_Max) * (1/2);
}

function scr_fearReset(){
	
	dmg_Values = [0];
	
}