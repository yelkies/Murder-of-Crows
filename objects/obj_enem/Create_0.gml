/// @description Insert description here
// You can write your code in this editor
enum enem_Stats {
	stam_Max = 2.5,
	stam_Gain_Rate = 0.1,
	hp_Max = 100,
	move_Spd
	
}
HPtimer = 300;
playerList = []
wanderReset = 0
stam_Current = enem_Stats.stam_Max;
combo_Current = "";
setup = true
Hp = enem_Stats.hp_Max;
attackTimer = 30;
in_Combat = false;
combat_Timer = 0;
dmg_Values = [0];
stat_Effects = {};
force_x = 0;
force_y = 0;



vision = function()
{
	sight = collision_line(x,y,obj_plyr.x, obj_plyr.y, all, false, true);
	//show_debug_message(sight)
}

takeDamage = function(damage)
{
	//scr_enemFear(damage);
}

Apply_Stat_Effects = function(_stat_effect)
{
	var Decrement_Time = function()
	{
		stat_Effects[$ effect_key] -= 1;
		
		
		if stat_Effects[$ effect_key] <= 0 
		{
		call_cancel(call_id); 
		struct_remove(stat_Effects, effect_key);
		}
		
	}
	
	var _bound_id = {effect_key: _stat_effect, stat_Effects: stat_Effects, call_id: -1}
	var _bound = method(_bound_id, Decrement_Time);
	
	_bound_id.call_id = call_later(1, time_source_units_seconds, _bound, true);
}

dummyState = function()
{
	//Hp = 999999999999;
	
}

idleState = function()
{
	enum idleBehavior {STILL, WANDER, PATROL}
//	show_debug_message("Idle")
	switch Behavior
	{
	case "STILL":
	break;
	
	case "WANDER":
	if (wanderReset <= 0)
		{
		randomize()
		movex = round(random_range(-1,1));
		movey = round(random_range(-1,1));
		wanderReset = random_range(1,3) * 60;
		}
		moveSpd = 0.5;
		move_and_collide(movex * moveSpd,movey * moveSpd,all);
		wanderReset -= 1;
	
	break;
	
	case "PATROL":
	break;
	}
	
	if (sight == obj_plyr.id) && (distance_to_object(sight) <= 15*15)
	{
		state = followState;
	}
}

followState = function()
{
	moveSpd += 0.1;
	moveSpd = clamp(moveSpd,0,3)
	//show_debug_message("Follow")
	move_towards_point(obj_plyr.x,obj_plyr.y, moveSpd)
	
	if (sight != obj_plyr.id) || (distance_to_object(sight) > 15*15)
	{
		speed = 0;
		state = idleState;
	}
	
	if distance_to_object(sight) < 15*3
	{
		speed = 0;
		currentCombo = ""
		state = attackState;
	}
}

attackState = function()
{
	closeRange = (distance_to_object(obj_plyr) <= 15*3);
	farRange = (distance_to_object(obj_plyr) > 15*3) && (distance_to_object(obj_plyr) <= 15*7);
	range = closeRange - farRange;
	action = "N";
	attackTimer--
	if attackTimer <= 0
	{
		switch range //attacks based of player distance
	{
		case 1: //close
		action = attack_Logic();
		break;
		
		case -1: //far
		action = "D"
		break;
		
		case 0: //too far, leave attackState
		//show_debug_message("Dummy")
		state = followState;
		exit
		break;
		
	}
	if (action != undefined) && (pauseStamina = false) //performs stamina and attack scripts
	{	
		//show_debug_message(staminaEffects())
		scr_enemStamina(action)
		staminaEffects();
		currentCombo += action;
		if struct_get(_general_moveset, currentCombo) == undefined //resets current combo if combo is not found
		{
		currentCombo = string_char_at(currentCombo, string_length(currentCombo));
		}
		//show_debug_message(currentCombo)
		//action = scr_enemStamina(action)
	}
	else // transistions to fear state
	{
		fearSurge = 15
		state = fearState;
	}
	attackTimer = 30;
	}
}


fearState = function()
{
	move_towards_point(obj_plyr.x,obj_plyr.y, -moveSpd / moveSpd) //edit this out aftr testing
	fearSurge --	
	if (currentStamina <= maxStamina) && (fearSurge <= 0)
	{
		currentStamina += maxStamina * (respiration / 15);
		staminaWorth += maxStamina * (respiration / 15);
		staminaWorth = clamp(staminaWorth,-1,1)
		fearSurge = 15;
	}
	if (currentStamina > maxStamina)
	{
		state = attackState;
	}
	
}

state = dummyState;

