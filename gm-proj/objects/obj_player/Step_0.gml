/// @description Get player input and movement

// Get Player Input
key_left = keyboard_check(vk_left) || keyboard_check(ord("A")); // virtual-keyboard left
key_right = keyboard_check(vk_right) || keyboard_check(ord("D")); // virtual-keyboard right
key_jump = keyboard_check_pressed(vk_space); // virtual-keyboard space
key_crouch = keyboard_check_pressed(ord("C"));
key_cover = keyboard_check_pressed(ord("F"));

// Horizontal Movement

if (currentmovementstate != movementstate.none && currentcovertype == covertype.none)
{
	// Calculate Horizontal Movement using Player Input
	
	speed_horizontal = (key_right - key_left) * speed_walk;
	
	// Horizontal Collision
	
	if (place_meeting(x + speed_horizontal, y, obj_floor))
	{
		// This pushes the Player's collision right up to the wall
		
		while(!place_meeting(x + sign(speed_horizontal), y, obj_floor))
		{
			x = x + sign(speed_horizontal);
		}
	
		speed_horizontal = 0;
	}
	
	// Set Movement State
	
	currentmovementstate = speed_horizontal != 0 ? movementstate.running : movementstate.idle;

	// Apply Horizontal Movement Speed

	x = x + speed_horizontal;	
}
else
{
	speed_horizontal = 0;
}

// Vertical Movement

// Calculate Vertical Movement (Gravity)
speed_vertical = speed_vertical + character_gravity;

// Vertical Collision

// On the Floor?
if (place_meeting(x, y + 1, obj_floor))
{
	speed_vertical = 0;	
	
	// Player press Jump?
	if (key_jump && currentmovementstate != movementstate.none)
	{
		speed_vertical = character_jump;		
		currentcovertype = covertype.none;
		
		// If there is an active cover toggle it
		if (currentcoverinstance != noone)
		{
			with(obj_cover_parent) {event_user(1);}
			currentcoverinstance = noone;
		}
	}	
	// Player pressed Crouch?
	// Make sure we are allowed to move and we're not in cover
	else if (key_crouch && currentmovementstate != movementstate.none && currentcovertype == covertype.none)
	{
		character_crouching = !character_crouching;	
	}
	
	// Player Pressed Cover Toggle?
	else if (key_cover && currentmovementstate != movementstate.none && currentmovementstate != movementstate.air)
	{
		// Check for a cover next to the Player
		// If there is one then toggle on/off
		// If there isn't one double check we're not toggled to cover so we can move (incase it is destroyed)
		
		// Are we in range of a cover?
		if (place_meeting(x + (image_xscale * cover_snapdistance), y, obj_cover_parent))
		{
			// Set an Instance reference to the cover
			if (currentcoverinstance == noone)
			{
				currentcoverinstance = obj_cover_parent;
			}
			
			// Player isn't in cover to try to use the Cover if it isn't already being used
			if (currentcovertype == covertype.none && !currentcoverinstance.cover_active)
			{
				// Code used by our collision to get right up to the edge of the Floor/Wall - could be used for Cover
				//while(!place_meeting(x + sign(speed_horizontal), y, obj_floor))
				//{
				//	x = x + sign(speed_horizontal);
				//}
				
				speed_horizontal = 0;					
				currentmovementstate = movementstate.idle;
				currentcovertype = currentcoverinstance.currentcovertype;
				
				with(currentcoverinstance) {event_user(0);}
				
				show_debug_message("A");
			}
			// Player is in cover so exit cover
			else
			{
				//currentmovementstate = movementstate.idle;
				currentcovertype = covertype.none;	
				
				with(currentcoverinstance) {event_user(1);}
				//obj_cover_parent.event_user(1);	
				currentcoverinstance = noone;
				show_debug_message("B");
			}			
		}
		// Double check we're not in Cover when there isn't cover (incase it's destroyed)
		// This could cause us to exit cutscenes etc
		else if (currentcovertype != covertype.none)
		{
			currentcoverinstance = noone;			
			//currentmovementstate = movementstate.none ? movementstate.idle : currentmovementstate;
			currentcovertype = covertype.none;	
			
			show_debug_message("C");
		}
		else
		{
			currentcoverinstance = noone;
			show_debug_message("D");
		}
		
		
		
		
		//if(currentcovertype == covertype.none)
		//{
		//	// scan ahead for a cover
		//	// lock to it
		//	// change movement / cover states
		//	// stop movement
			
		//	if (place_meeting(x + (image_xscale * cover_snapdistance), y, obj_cover_parent))
		//	{
				
				
		//		// Check that the player is next to a cover
				
		//		// Check the Covers height has been set
		//		if (obj_cover_parent.currentcovertype != covertype.none)
		//		{
		//			// check the cover is not active
					
		//			if()
					
		//			speed_horizontal = 0;					
		//			currentmovementstate = movementstate.none;
		//			currentcovertype = obj_cover_parent.currentcovertype;
					
		//			obj_cover_parent.event_user(0);
					
		//			show_debug_message("covertype is not none.");
		//		}
		//		else
		//		{
		//			show_debug_message("covertype is none.");
		//		}
		//	}					
		//}
		//else if(currentcovertype != covertype.none)
		//{
		//	currentmovementstate = movementstate.idle;
		//	currentcovertype = covertype.none;	
		//}
	}
}
else
{	
	currentmovementstate = movementstate.air;
	
	// Vertical Collision	
	if (place_meeting(x, y + speed_vertical, obj_floor))
	{
		// Apply Gravity		
		while(!place_meeting(x, y + sign(speed_vertical), obj_floor))
		{
			y = y + sign (speed_vertical);
		}
	
		speed_vertical = 0;
	}
}

// Apply Vertical Movement Speed (Gravity)

y = y + speed_vertical;

// Set the Sprite
event_user(0);