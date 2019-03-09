/// @description Equip Pistol

instance_destroy(currentweapon);
currentweapon = instance_create_layer(x, y, "Weapon", obj_weapon_gun_pistol);
currentweapon.owner = id;
