/// @description Insert description here
// You can write your code in this editor

// This is done last basically
// by doing this we make sure we draw the bullet before getting rid of it
// otherwise it would destroy before it looks like it's overlapping
// this is an exception

// I could do this with Add Event -> Collision

if (place_meeting(x, y, obj_floor))
{
	instance_destroy();
}
else if (place_meeting(x, y, obj_cover_parent))
{
	if(obj_cover_parent.cover_active)
	{
		instance_destroy();
	}
}