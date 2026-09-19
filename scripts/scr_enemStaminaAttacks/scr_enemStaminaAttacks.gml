// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_enemStamina(_input)
{
	if _input != "N"
	{
	//show_debug_message(_input)
	}
	pauseStamina = false
if (obj_enem_test.setup)
{
maxStamina = obj_enem_test.stats._maxStamina;
respiration = obj_enem_test.stats._respiration;
gainStamina = 0;
staminaWorth = 0;
currentStamina = maxStamina;
MaxDangerlvl = 10;
dangerlvl = 0
minStamina = 0;
returnValue = 0;
obj_enem_test.setup = false
}

	input = string_char_at(_input,string_length(_input))
	_input_moveset = {
		D : 3.5,
		H : 2.4,
		E : 2.7,
		L : 1
		}
		
	gainStamina--	
	if (currentStamina <= maxStamina) && (gainStamina <= 0)
	{
		currentStamina += maxStamina * (respiration / 100);
		staminaWorth += maxStamina * (respiration / 100);
		staminaWorth = clamp(staminaWorth,-1,1)
		gainStamina = 15;
	}
	
	struct_foreach(_input_moveset,function(_code, _exhaust)
	{
		if (input == _code)
		{
			if (currentStamina - _exhaust > minStamina) 
			{
			currentStamina -= _exhaust
			returnValue = currentStamina;
			staminaWorth -= _exhaust
			staminaWorth = clamp(staminaWorth,-1,1)
			}
			else
			{
			returnValue = minStamina;
			}
		}
	})
	if staminaWorth >= 0 dangerlvl -= 2;
	dangerlvl = clamp(dangerlvl,0,MaxDangerlvl)
		
return returnValue
}

function staminaEffects()
{
	//minimum stamina change from danger level going up
	dangerlvl++
	dangerlvl = clamp(dangerlvl,0,MaxDangerlvl)
	HPdangerlvl = obj_enem_test.Hp / obj_enem_test.MaxHp
	HPdangerlvl = round(HPdangerlvl * 10) / 10
	Staminadangerlvl = 1 - dangerlvl/MaxDangerlvl
	dangerPercent = 1 - ((Staminadangerlvl * 0.33) + (HPdangerlvl * 0.67))
	minStamina = (maxStamina * dangerPercent) / 2
	
	return currentStamina
	
}

function attackChooser(_input, _currentCombo)
{
	availableMoves = []
	availableCombos = []
	
	_general_moveset = { //test moveset. replace with enemy moveset function later
		"L" : ["Light1",3],
		"LL" : ["Light2",4],
		"LLH" : ["Light2",4],
		"LLHL" : ["Light2",4],
		"LLL" : ["Light2",4],
		"LLLL" : ["Light2",4],
		"H" : ["Heavy1",8],
		"HH" : ["Heavy1",8],
		"HHH" : ["Heavy1",8],
		"HHL" : ["Heavy1",8],
		"HD" : ["Heavy1",8],
		"HE" : ["Heavy1",8],
		"HL" : ["Heavy1",8],
		"D" : ["Dash1",5],
		"DL" : ["Dash1",5],
		"DLD" : ["Dash1",5],
		"DLL" : ["Dash1",5],
		"DD" : ["Dash1",5],
		"E" : ["Evade",0]
		}
	//show_debug_message(_currentCombo)
	currentCombo = _currentCombo
	struct_foreach(_general_moveset, function(_combo, _output){ // sets availableCombos to next avaible combos
	if string_length(_combo) = string_length(currentCombo) + 1 && string_starts_with(_combo, currentCombo)
	{
	array_insert(availableCombos,-1, _combo)
	}
	})
		
	struct_foreach(_input, function(_code, _exhaust){ //sets availableMoves to moves that fit within stamina contraints
	if (currentStamina - _exhaust > minStamina)// && (_returnValue == "")
	{
		 array_insert(availableMoves,-1,_code)
	}
	})
		
	array_foreach(availableCombos, function(_combo){ // adds additional move chances for each availableCombo
	
	array_insert(availableMoves, -1, string_char_at(_combo,string_length(_combo)))
	array_insert(availableMoves, -1, string_char_at(_combo,string_length(_combo)))
	array_insert(availableMoves, -1, string_char_at(_combo,string_length(_combo)))
	})
	//show_debug_message(availableMoves)
	//show_debug_message(currentStamina)
	if array_length(availableMoves) > 0 //returns next attack
	{
	return availableMoves[irandom_range(0,array_length(availableMoves)-1)]
	}
}
