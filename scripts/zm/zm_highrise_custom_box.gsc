#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zombies\_zm_weapons;
#include maps\mp\zombies\_zm_weapon_locker;
#include maps\mp\zm_highrise_gamemodes;
#include maps\mp\zm_highrise_sq;
#include maps\mp\zombies\_zm_banking;
#include maps\mp\zm_highrise_fx;
#include maps\mp\zm_highrise_ffotd;
#include maps\mp\zm_highrise_utility;
#include maps\mp\zombies\_zm;
#include maps\mp\animscripts\zm_death;
#include maps\mp\zm_highrise_amb;
#include maps\mp\zm_highrise_elevators;
#include maps\mp\zombies\_load;
#include maps\mp\gametypes_zm\_spawning;
#include maps\mp\zm_highrise_classic;
#include maps\mp\zombies\_zm_ai_leaper;
#include maps\mp\zm_highrise;
#include maps\mp\_sticky_grenade;
#include maps\mp\zombies\_zm_weap_bowie;
#include maps\mp\zombies\_zm_weap_cymbal_monkey;
#include maps\mp\zombies\_zm_weap_claymore;
#include maps\mp\zombies\_zm_weap_ballistic_knife;
#include maps\mp\zombies\_zm_weap_slipgun;
#include maps\mp\zombies\_zm_weap_tazer_knuckles;
#include maps\mp\zm_highrise_achievement;
#include maps\mp\zombies\_zm_zonemgr;
#include maps\mp\zm_highrise_distance_tracking;
#include maps\mp\zombies\_zm_laststand;
#include maps\mp\gametypes_zm\_zm_gametype;
#include maps\mp\zombies\_zm_devgui;
#include maps\mp\zombies\_zm_buildables;
#include maps\mp\zombies\_zm_audio;
#include maps\mp\zombies\_zm_perks;
#include character\c_highrise_player_farmgirl;
#include character\c_highrise_player_oldman;
#include character\c_highrise_player_engineer;
#include character\c_highrise_player_reporter;
#include maps\mp\zombies\_zm_equipment;
#include maps\mp\zombies\_zm_unitrigger;
#include maps\mp\zombies\_zm_chugabud;

init()
{

	add_zombie_weapon( "uzi_zm", "uzi_upgraded_zm", &"ZOMBIE_WEAPON_UZI", 1500, "wpck_smg", "", undefined );
    add_zombie_weapon( "thompson_zm", "thompson_upgraded_zm", &"ZMWEAPON_THOMPSON_WALLBUY", 1500, "wpck_smg", "", 800 );
    add_zombie_weapon( "blundergat_zm", "blundergat_upgraded_zm", &"ZOMBIE_WEAPON_BLUNDERGAT", 500, "wpck_shot", "", undefined, 1 );
    add_zombie_weapon( "blundersplat_zm", "blundersplat_upgraded_zm", &"ZOMBIE_WEAPON_BLUNDERGAT", 500, "wpck_shot", "", undefined );
    add_zombie_weapon( "ak47_zm", "ak47_upgraded_zm", &"ZOMBIE_WEAPON_AK47", 500, "wpck_mg", "", undefined, 1 );
    add_zombie_weapon( "minigun_alcatraz_zm", "minigun_alcatraz_upgraded_zm", &"ZOMBIE_WEAPON_RPD", 50, "wpck_mg", "", undefined, 1 );
    add_zombie_weapon( "bouncing_tomahawk_zm", "upgraded_tomahawk_zm", &"ZOMBIE_WEAPON_SATCHEL_2000", 2000, "", "", undefined, 1 );

    include_weapons();

}

main()
{

	add_zombie_weapon( "uzi_zm", "uzi_upgraded_zm", &"ZOMBIE_WEAPON_UZI", 1500, "wpck_smg", "", undefined );
    add_zombie_weapon( "thompson_zm", "thompson_upgraded_zm", &"ZMWEAPON_THOMPSON_WALLBUY", 1500, "wpck_smg", "", 800 );
    add_zombie_weapon( "blundergat_zm", "blundergat_upgraded_zm", &"ZOMBIE_WEAPON_BLUNDERGAT", 500, "wpck_shot", "", undefined, 1 );
    add_zombie_weapon( "blundersplat_zm", "blundersplat_upgraded_zm", &"ZOMBIE_WEAPON_BLUNDERGAT", 500, "wpck_shot", "", undefined );
    add_zombie_weapon( "ak47_zm", "ak47_upgraded_zm", &"ZOMBIE_WEAPON_AK47", 500, "wpck_mg", "", undefined, 1 );
    add_zombie_weapon( "bouncing_tomahawk_zm", "upgraded_tomahawk_zm", &"ZOMBIE_WEAPON_SATCHEL_2000", 2000, "", "", undefined, 1 );
    add_zombie_weapon( "minigun_alcatraz_zm", "minigun_alcatraz_upgraded_zm", &"ZOMBIE_WEAPON_RPD", 50, "wpck_mg", "", undefined, 1 );

    include_weapons();

}

custom_add_weapons()
{


}

include_weapons()
{
	include_weapon("blundergat_zm");
    include_weapon("ray_gun_upgraded_zm");
    include_weapon("uzi_zm");
    include_weapon("thompson_zm");
    include_weapon("minigun_alcatraz_zm");
    include_weapon("blundersplat_zm");
    include_weapon("ak47_zm");

    // broken weapons
    //include_weapon("bouncing_tomahawk_zm");
}