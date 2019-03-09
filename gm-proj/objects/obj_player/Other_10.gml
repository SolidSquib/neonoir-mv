/// @description Set Player Sprite

// sprite_index (change Sprites)
// image_index (change Sprite Frame)
// image_speed (change playback speed)

// Character is in the air
if (currentmovementstate = movementstate.air)
{
	sprite_index = spr_player_air_toggle;	
	image_speed = 0;
	
	// Falling
	if (sign(speed_vertical) > 0)
	{
		image_index = 1;
	}
	// Jumping
	else
	{
		image_index = 0;
	}
}
else
{
	image_speed = 1;
	
	// Character is not in Cover
	if (currentcovertype = covertype.none)
	{
		//  Character is Idle
		if (speed_horizontal == 0)
		{
			sprite_index = character_crouching ? spr_player_crouching_idle : spr_player_standing_idle;
		}
		// Character is Moving
		else
		{
			sprite_index = character_crouching ? spr_player_crouching_run : spr_player_standing_run;
		}		
	}
	// Character is in Cover
	else
	{
		// The Cover is Tall
		if (currentcovertype == covertype.tallCover)
		{
			sprite_index = spr_player_standing_cover;
		}
		// The Cover is Short
		else
		{
			sprite_index = spr_player_crouching_cover;
		}
	}
}

// Flip the Sprite left / right
if (speed_horizontal != 0)
{
	image_xscale = sign(speed_horizontal);
}
