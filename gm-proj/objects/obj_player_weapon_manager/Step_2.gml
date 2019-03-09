/// @description Follow the parent object

// this will change in future to be other.x and other.y

// I think I need to redo this + the weapon rotation and flipping

x = owner.x + object_offset_x;
y = owner.y + object_offset_y; 

var lockdirection = point_direction (x, y, mouse_x, mouse_y);

image_angle = round(lockdirection / 45) * 45;

//image_angle = clamp(image_angle, 90, 270);