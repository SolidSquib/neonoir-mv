/// @description Follow Parent

x = owner.x;
y = owner.y;

direction = owner.image_angle;
image_angle = direction;

if ((image_angle > 90) && (image_angle < 270))
{
	image_yscale = -1;
}
else
{
	image_yscale = 1;
}

fire_delay = fire_delay - 1;

if (mouse_check_button(mb_left) && fire_delay < 0)
{
	fire_delay = fire_rate;	
	
	with (instance_create_layer(x, y, "Bullets", obj_bullet))
	{
		speed = other.projectile_speed; // fixed speed it will move		
		direction = other.image_angle; // + random_range(-2, 2); // affects the movement angle
		image_angle = direction; // set the sprite rotation
	}	
}