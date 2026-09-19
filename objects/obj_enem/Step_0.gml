/// @description Insert description here
// You can write your code in this editor
vision()
state()
//show_debug_message(scr_enemStamina("N"))
//show_debug_message(staminaEffects(scr_enemStamina("N")))
randomize()
//scr_enemStamina("N")
//if place_meeting(x,y,obj_plyr_attack_projectile) && (obj_plyr_eins.attacking == true)
//{
//	obj_plyr_eins.attacking = false
//	Hp -= obj_plyr_eins.attackDamage
//	HPtimer = 300;
//}
HPtimer--
//show_debug_message(HPtimer)
if HPtimer <= 0 
{
	Hp = enem_Stats.hp_Max;
	HPtimer = 300;
	in_Combat = false;
}
Perform_Status_Effects(stat_Effects);
if (Hp <= 0)
{
	show_debug_message("dead");
	instance_destroy();
}

if in_Combat{
	combat_Timer ++;
}
else{
	combat_Timer = 0;
}

if (force_x != 0 || force_y != 0)
{
    move_and_collide(force_x,force_y, obj_testObj); // now safe, player isn't overlapping every frame
    force_x *= force_friction;
    force_y *= force_friction;
    if (abs(force_x) < 0.1) force_x = 0;
    if (abs(force_y) < 0.1) force_y = 0;
}

//struct_foreach(stat_Effects, function(_status, _time)
//{
//    var _captured = {
//        status: _status,
//        time: _time,
//        effects: stat_Effects
//    };

//    call_later(1, time_source_units_seconds, method(_captured, function()
//    {
//        effects[$ status] -= 1;
//    }));
//});