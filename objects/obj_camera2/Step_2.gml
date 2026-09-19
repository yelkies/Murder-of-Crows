var camX = camera_get_view_x(camera);
var camY = camera_get_view_y(camera);

var targetX = obj_plyr.x - resWidth/2;
var targetY = obj_plyr.y - resHeight/2;

targetX = clamp(targetX, 0, room_width - resWidth);
targetY = clamp(targetY, 0, room_height - resHeight);

camX = lerp(camX, targetX, camSmooth);
camY = lerp(camY, targetY, camSmooth);

camera_set_view_pos(camera, camX, camY);



