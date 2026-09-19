rightKey = keyboard_check(vk_right) || keyboard_check(ord("D"));
leftKey = keyboard_check(vk_left) || keyboard_check(ord("A"));
downKey = keyboard_check(vk_down) || keyboard_check(ord("S"));
upKey = keyboard_check(vk_up) || keyboard_check(ord("W"));
lAtk = mouse_check_button_pressed(mb_left);
hAtk = mouse_check_button_pressed(mb_right);
dAtk = keyboard_check_pressed(ord("R"));
dash = keyboard_check_pressed(vk_shift);
grapple = mouse_check_button_pressed(mb_middle);
attackStruct =
{
	"L" : lAtk,
	"H" : hAtk,
	"D" : dAtk
}
xspd = rightKey - leftKey;
yspd = downKey - upKey;

if (xspd != 0) and (yspd != 0){
	moveSpd = diagSpd;
} else {
	moveSpd = base_spd
}

if (canDash && dash) state = dashState;
if (hp <= 0) state = deadState;
state();

if (force_x != 0 || force_y != 0)
{
    move_and_collide(force_x,force_y, obj_testObj); 
    force_x *= force_friction;
    force_y *= force_friction;
    if (abs(force_x) < 0.1) force_x = 0;
    if (abs(force_y) < 0.1) force_y = 0;
}