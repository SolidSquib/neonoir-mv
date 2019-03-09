/// @description Weapon Input + Fire

// This could be put into step 

// Happens every frame before the other Step Types
// Putting this here makes the gun "lag" slightly behind the Player
// It is meant to give it "weight" but if we dont want this we can move it to a later Step Type

// Follow the Player Object

//x = obj_player.x + object_offset_x;
//y = obj_player.y + object_offset_y; 

//image_angle = point_direction (x, y, mouse_x, mouse_y);

//Firing 

//fire_delay = fire_delay - 1;

//if (mouse_check_button(mb_left) && fire_delay < 0)
//{
//	fire_delay = fire_rate;	
	
//	with (instance_create_layer(x, y, "Bullets", obj_bullet))
//	{
//		speed = other.projectile_speed; // fixed speed it will move		
//		direction = other.image_angle; // + random_range(-2, 2); // affects the movement angle
//		image_angle = direction; // set the sprite rotation
//	}	
//}