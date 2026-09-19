interact_tiles = layer_tilemap_get_id("camera_Screen");

//free
moveSpd = base_spd;
diagSpd = base_spd * (sqrt(2) / 2);
stam_Current = 100;
canDash = true;

stat_Effects = {};

//attack
combo_Current = ""
attackDamage = 0;
hitByAttack = ds_list_create();

//____________________________________________________________________________________________________________________

//states
freeState = function()
{
	// WASD and arrow key movement
	move_and_collide(xspd * moveSpd, yspd * moveSpd, all);
	
	
	//show_debug_message([image_xscale, _facing])

	
	if grapple // grapple state
	{
		grapplePoint = collision_line(x,y,mouse_x,mouse_y, all, false, true); //scan for grapplable surface
		
		// If surface is found, go go gadget grapple hook!
		if grapplePoint != noone 
		{
			grappleDirection = point_direction(x,y, grapplePoint.x, grapplePoint.y);
			grappleSpd = moveSpd * 8;
			state = grappleState;
		}
		
	}
	
	struct_foreach(attackStruct, function(_character, _action) //attack state
	{
		if _action // if Lclick, Rclick, R, Shift
		{
		
			ATimer = 24; // Sets combat timer
			attackState(); // Performs the initial attack before entering attack state for longer combos
			state = attackState;
		}
	});
}

dashState = function()
{
	canDash = false; // Toggle dash delay
	var dash_dir = point_direction(0,0,xspd,yspd) // Dash in direction player is already moving in
	// !!! Fix so that when player is idle, the dash input causes player to dash in direction the character is facing !!!
	
	// Force calculations. Force applied in step event
	force_x += lengthdir_x(22.5, dash_dir);
	force_y += lengthdir_y(22.5, dash_dir);	
	force_friction = 0.5;
	
	
	call_later(0.5,time_source_units_seconds, function(){canDash = true;},false) // Dash delay 
	state = freeState; // return to free state
}

grappleState = function()
{
	move_towards_point(grapplePoint.x, grapplePoint.y, grappleSpd); //move towards target
	if distance_to_object(grapplePoint) <= grappleSpd	//slowing down
	{
		speed = distance_to_object(grapplePoint) 
	}
	if distance_to_object(grapplePoint) <= 1 //stopping
	{
		speed = 0
		state = freeState;
	}
	return ("but"); // vaginuenly what does this do?
}

deadState = function()
{
	//lmao, u dead as fuck
}

attackState = function()
{
	move_and_collide(xspd * moveSpd, yspd * moveSpd, all); // Allows for movement while in attack state.  Needs to be tweaked, but I would like something similar to hollow knigth combat

	if (xspd != 0) image_xscale = abs(image_xscale) * xspd;
	
	ATimer--;
	var perform_attack = struct_foreach(attackStruct, function(_character, _action) // accesses the attack struct in Step event
		{
//--------------------------- FINDING MOVE SET AND EXECUTING ATTACK ---------------------------------------------------------
		if _action
		{
			combo_Current += _character;
			
			if GetMoveset(name, combo_Current) == "None"
			{
			combo_Current = string_char_at(combo_Current, string_length(combo_Current));
			output = GetMoveset(name, combo_Current);
			}else
			{
			output = GetMoveset(name, combo_Current)
			}
			
//-------------------------- APPLYING DAMAGE, ANIMATION, AND HIT EFFECTS -----------------------------------------------------			
			var attackDamage = struct_get(output,"dmg");				//damage
			
			if struct_exists(output, "status_effects")					//status effects
			var status_effects = struct_get(output, "status_effects")	//|
			else status_effects = {};									//|
			
			if struct_exists(output, "projectile")						//projectiles
			var projectile = struct_get(output, "projectile")			//|
			else projectile = -1;										//|
			
			if struct_exists(output, "kb")								//knockback
			var kb = struct_get(output, "kb")							//|
			else kb = 0;												//|
			
			if struct_exists(output, "thrust")							//How mmuch the player moves
			var thrust = struct_get(output, "thrust")					//|
			else thrust = 0;											//|
			
			sprite_index = asset_get_index(struct_get(output,"anim") + _facing);	//attack animation
			mask_index = asset_get_index(struct_get(output,"hb") + _facing);		//hitbox
	
//------------------------- APPLYING D.A.HE TO COLLIDING OBJECT (ENEMIES) -----------------------------------------------------------
			
			// if the data type of the "projectile" variable is "ref" (a reference to an object),
			// meaning that "projectile" is actually set to something and not just -1,
			// it spawns the projectile at the player's location
			if typeof(projectile) == "ref" instance_create_layer(x,y,"Instances", projectile); 
			
			// If thrust is any number other than 0, the player moves when they attack
			if (thrust != 0)
						{
							var _forceDir = point_direction(x,y,x+xspd,y+yspd);
							force_x = lengthdir_x(thrust, _forceDir);
							force_y = lengthdir_y(thrust, _forceDir);
							force_friction = 0.5;
						}
			
		
			// a ds_list is similar to an array, but it's easier to do simple manipulations
			// this function checks for enemies hit by the attack hitbox and adds them to the ds list
			// the list is iterated over and the damage and attack effects are applied using a with() statement
			ds_list_clear(hitByAttack);
			var hitByAttackNow = ds_list_create();
			var hits = instance_place_list(x,y,obj_enem,hitByAttackNow,false);
			if (hits > 0)
			{
				for (var i = 0; i < hits; i++)
				{
				var hitID = hitByAttackNow[| i];
				if (ds_list_find_index(hitByAttack, hitID) == -1)
				{
					ds_list_add(hitByAttack,hitID);
					with (hitID)
					{
						Hp -= attackDamage;
						HPtimer = 300;
						in_Combat = true;
						takeDamage(attackDamage);
						if (kb > 0)
						{
							// knockback effects are applied
							var _forceDir = point_direction(other.x, other.y, x, y);
							force_x += lengthdir_x(kb, _forceDir);
							force_y += lengthdir_y(kb, _forceDir);
							force_friction = 0.5; // friction can be tuned for different types of floor
						}
						// status effects are stored in structs for each and every instance {Status type : Time}
						// If the instance being attaacked as the status efect in the struct already, then time is added
						struct_foreach(status_effects, function(_status, _time)
						{
							if struct_exists(stat_Effects, _status) 
							struct_set(stat_Effects,_status, struct_get(stat_Effects,_status) + _time) 
							else 
							{
								struct_set(stat_Effects, _status, _time);
								Apply_Stat_Effects(_status);
							}
						})
					
					}
				}
				
				}}
			
			ATimer = 24;
			
	
		}
	});

	if ATimer <= 0 {
	combo_Current = ""
	ATimer = 0;
	state = freeState;
	}
}
state = freeState;




