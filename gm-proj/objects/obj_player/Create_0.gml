/// @description Character Variables
// You can write your code in this editor

speed_horizontal = 0;
speed_vertical = 0;
speed_walk = 2;
character_gravity = 0.1;
character_jump = -1;
cover_snapdistance = 6;

enum movementstate {none, idle, running, air}
character_crouching = false;
currentmovementstate = movementstate.idle;
currentcovertype = covertype.none;
currentcoverinstance = noone;

weaponmanager = instance_create_layer(x, y, "Weapon", obj_player_weapon_manager);
weaponmanager.owner = id;