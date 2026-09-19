/// @description Insert description here
// You can write your code in this editor
draw_self()

//draw_line(x,y,obj_plyr_eins.x, obj_plyr_eins.y)

//draw_circle_color(x,y,15*8,c_blue,c_blue,true)
//draw_circle_color(x,y,15*4,c_red,c_red,true)

//draw_line_color(45,215,45+(currentStamina*10),215, c_red, c_red)
//draw_line_color(45,215,45+(minStamina*10),215, c_lime, c_lime)
//draw_line_color(45+(minStamina*10), 212, 45+(minStamina*10), 218,c_lime, c_lime)

draw_text(x-50,y-25, stat_Effects);
draw_text(x,y+25, Hp);
draw_sprite(hp_skull, clamp(25-floor(Hp/4),0,24), 200, 50);


