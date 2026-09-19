//resolution
#macro resWidth 480 //camera size
#macro resHeight 270 //camera size
#macro resScale 2 //window size

//camera smoothness
#macro camSmooth 0.1

//viewport shit
view_enabled = true;
view_visible[0] = true;

//set the camera
camera = camera_create_view(obj_plyr_eins.x, obj_plyr_eins.y, resWidth, resHeight);
view_set_camera(0, camera);

//window and application size
window_set_size(resWidth * resScale, resHeight * resScale);
surface_resize(application_surface, resWidth * resScale, resHeight * resScale);

display_set_gui_size(resWidth, resHeight);

//center window
var displayWidth = display_get_width();
var displayHeight = display_get_height();

var windowWidth = resWidth * resScale;
var windowHeight = resHeight * resScale;

window_set_position(displayWidth/2 - windowWidth/2, displayHeight/2 - windowHeight/2);

