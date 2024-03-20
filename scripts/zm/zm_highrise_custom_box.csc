#include clientscripts\mp\_utility;
#include clientscripts\mp\_filter;
#include clientscripts\mp\zombies\_zm_perk_electric_cherry;
#include clientscripts\mp\zombies\_zm_perk_vulture;
#include clientscripts\mp\zombies\_zm_weapons;
#include clientscripts\mp\zombies\_zm_utility;
#include clientscripts\mp\zm_highrise_ffotd;
#include clientscripts\mp\zm_highrise_classic;
#include clientscripts\mp\zm_highrise_fx;
#include clientscripts\mp\zm_highrise_amb;
#include clientscripts\mp\zombies\_zm_perks;
#include clientscripts\mp\zm_highrise_sq;
#include clientscripts\mp\_visionset_mgr;
#include clientscripts\mp\zombies\_zm;
#include clientscripts\mp\_sticky_grenade;
#include clientscripts\mp\zombies\_zm_weap_cymbal_monkey;
#include clientscripts\mp\zombies\_zm_weap_slipgun;
#include clientscripts\mp\zombies\_zm_weap_tazer_knuckles;
#include clientscripts\mp\zombies\_zm_equip_springpad;
#include clientscripts\mp\_fx;
#include clientscripts\mp\_audio;
#include clientscripts\mp\zm_buried_ffotd;
#include clientscripts\mp\zm_buried_sq;
#include clientscripts\mp\zombies\_zm_perk_divetonuke;
#include clientscripts\mp\zm_buried_fx;
#include clientscripts\mp\zm_buried_buildables;
#include clientscripts\mp\zm_buried_classic;
#include clientscripts\mp\zm_buried_maze;
#include clientscripts\mp\zm_buried_amb;
#include clientscripts\mp\zombies\_zm_turned;
#include clientscripts\mp\zm_buried_turned_street;
#include clientscripts\mp\zm_buried_grief_street;
#include clientscripts\mp\zombies\_zm_weap_time_bomb;
#include clientscripts\mp\zombies\_zm_weap_slowgun;
#include clientscripts\mp\zombies\_zm_ai_ghost;
#include clientscripts\mp\zombies\_zm_equip_turbine;
#include clientscripts\mp\zombies\_zm_equip_subwoofer;
#include clientscripts\mp\zombies\_zm_equip_headchopper;

init()
{

    //level.zombiemode_using_electric_cherry_perk = 1;

	include_weapon("blundergat_zm");
    include_weapon("ray_gun_upgraded_zm");
    include_weapon("uzi_zm");
    include_weapon("thompson_zm");
    include_weapon("minigun_alcatraz_zm");
    include_weapon("blundersplat_zm");
    include_weapon("ak47_zm");
    include_weapon("bouncing_tomahawk_zm");

     if ( getdvar( #"createfx" ) == "on" )
        return;
	
}

main()
{
    // Electric Cherry
    enable_electric_cherry_perk_for_level();
    clientscripts\mp\_visionset_mgr::vsmgr_register_visionset_info( "zm_electric_cherry", 9000, 1, "zm_electric_cherry", "zm_electric_cherry" );
 	
    // Vulture
    enable_vulture_perk_for_level();

    // Deadshot
    level.zombiemode_using_deadshot_perk = 1;

    // PhD Flopper
    level.zombiemode_using_divetonuke_perk = 1;
    enable_divetonuke_perk_for_level();

    // FX
    level._effect["fx_zm_nuked_exp_perk_impact_int_shockwave"] = loadfx( "explosions/fx_zm_nuked_exp_perk_impact_int_shockwave" );

    // Box
    include_weapon("blundergat_zm");
    include_weapon("ray_gun_upgraded_zm");
    include_weapon("uzi_zm");
    include_weapon("thompson_zm");
    include_weapon("minigun_alcatraz_zm");
    include_weapon("blundersplat_zm");
    include_weapon("ak47_zm");

    //broken weapons
    //include_weapon("bouncing_tomahawk_zm");
	
}

enable_electric_cherry_perk_for_level()
{
    clientscripts\mp\zombies\_zm_perks::register_perk_clientfields( "specialty_grenadepulldeath", ::electric_cherry_client_field_func, ::electric_cherry_code_callback_func );
    clientscripts\mp\zombies\_zm_perks::register_perk_init_thread( "specialty_grenadepulldeath", ::init_electric_cherry );
}

init_electric_cherry()
{
    registerclientfield( "allplayers", "electric_cherry_reload_fx", 9000, 2, "int", ::electric_cherry_reload_attack_fx, 0 );
    level._effect["electric_cherry_explode"] = loadfx( "maps/zombie_alcatraz/fx_alcatraz_electric_cherry_down" );
    level._effect["electric_cherry_reload_small"] = loadfx( "maps/zombie_alcatraz/fx_alcatraz_electric_cherry_sm" );
    level._effect["electric_cherry_reload_medium"] = loadfx( "maps/zombie_alcatraz/fx_alcatraz_electric_cherry_player" );
    level._effect["electric_cherry_reload_large"] = loadfx( "maps/zombie_alcatraz/fx_alcatraz_electric_cherry_lg" );
    level._effect["tesla_shock"] = loadfx( "maps/zombie/fx_zombie_tesla_shock" );
    level._effect["tesla_shock_secondary"] = loadfx( "maps/zombie/fx_zombie_tesla_shock_secondary" );
}

electric_cherry_client_field_func()
{
    registerclientfield( "toplayer", "perk_electric_cherry", 9000, 1, "int", undefined, 0, 1 );
}

electric_cherry_code_callback_func()
{
    setupclientfieldcodecallbacks( "toplayer", 1, "perk_electric_cherry" );
}

electric_cherry_reload_attack_fx( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( isdefined( self.electric_cherry_reload_fx ) )
        stopfx( localclientnum, self.electric_cherry_reload_fx );

    if ( newval == 1 )
        self.electric_cherry_reload_fx = playfxontag( localclientnum, level._effect["electric_cherry_reload_small"], self, "tag_origin" );
    else if ( newval == 2 )
        self.electric_cherry_reload_fx = playfxontag( localclientnum, level._effect["electric_cherry_reload_medium"], self, "tag_origin" );
    else if ( newval == 3 )
        self.electric_cherry_reload_fx = playfxontag( localclientnum, level._effect["electric_cherry_reload_large"], self, "tag_origin" );
    else
    {
        if ( isdefined( self.electric_cherry_reload_fx ) )
            stopfx( localclientnum, self.electric_cherry_reload_fx );

        self.electric_cherry_reload_fx = undefined;
    }
}

enable_vulture_perk_for_level()
{
    level.zombies_global_perk_client_callback = ::vulture_global_perk_client_callback;
    clientscripts\mp\zombies\_zm_perks::register_perk_clientfields( "specialty_nomotionsensor", ::vulture_client_field_func, ::vulture_code_callback_func );
    clientscripts\mp\zombies\_zm_perks::register_perk_init_thread( "specialty_nomotionsensor", ::init_vulture );
    init_vulture();
    onplayerconnect_callback( ::vulture_setup_on_player_connect );
}

init_vulture()
{
    registerclientfield( "toplayer", "vulture_perk_toplayer", 12000, 1, "int", ::vulture_callback_toplayer, 0, 1 );
    registerclientfield( "actor", "vulture_perk_actor", 12000, 2, "int", ::vulture_callback_actor, 0, 0 );
    registerclientfield( "scriptmover", "vulture_perk_scriptmover", 12000, 4, "int", ::vulture_callback_scriptmover, 0, 0 );
    registerclientfield( "zbarrier", "vulture_perk_zbarrier", 12000, 1, "int", ::vulture_vision_mystery_box, 0, 0 );
    registerclientfield( "toplayer", "sndVultureStink", 12000, 1, "int", ::sndvulturestink );
    registerclientfield( "world", "vulture_perk_disable_solo_quick_revive_glow", 12000, 1, "int", ::vulture_disable_solo_quick_revive_glow, 0, 0 );
    registerclientfield( "toplayer", "vulture_perk_disease_meter", 12000, 5, "float", ::vulture_callback_stink_active, 0, 1 );
    setupclientfieldcodecallbacks( "toplayer", 1, "vulture_perk_disease_meter" );
    clientscripts\mp\_visionset_mgr::vsmgr_register_overlay_info_style_filter( "vulture_stink_overlay", 12000, 31, 0, 0, "generic_filter_zombie_perk_vulture", 0 );
    level._effect["vulture_perk_zombie_stink"] = loadfx( "maps/zombie/fx_zm_vulture_perk_stink" );
    level._effect["vulture_perk_zombie_stink_trail"] = loadfx( "maps/zombie/fx_zm_vulture_perk_stink_trail" );
    level._effect["vulture_perk_bonus_drop"] = loadfx( "misc/fx_zombie_powerup_vulture" );
    level._effect["vulture_drop_picked_up"] = loadfx( "misc/fx_zombie_powerup_grab" );
    level._effect["vulture_perk_wallbuy_static"] = loadfx( "maps/zombie/fx_zm_vulture_wallbuy_rifle" );
    level._effect["vulture_perk_wallbuy_dynamic"] = loadfx( "maps/zombie/fx_zm_vulture_glow_question" );
    level._effect["vulture_perk_machine_glow_doubletap"] = loadfx( "maps/zombie/fx_zm_vulture_glow_dbltap" );
    level._effect["vulture_perk_machine_glow_juggernog"] = loadfx( "maps/zombie/fx_zm_vulture_glow_jugg" );
    level._effect["vulture_perk_machine_glow_revive"] = loadfx( "maps/zombie/fx_zm_vulture_glow_revive" );
    level._effect["vulture_perk_machine_glow_speed"] = loadfx( "maps/zombie/fx_zm_vulture_glow_speed" );
    level._effect["vulture_perk_machine_glow_marathon"] = loadfx( "maps/zombie/fx_zm_vulture_glow_marathon" );
    level._effect["vulture_perk_machine_glow_mule_kick"] = loadfx( "maps/zombie/fx_zm_vulture_glow_mule" );
    level._effect["vulture_perk_machine_glow_pack_a_punch"] = loadfx( "maps/zombie/fx_zm_vulture_glow_pap" );
    level._effect["vulture_perk_machine_glow_vulture"] = loadfx( "maps/zombie/fx_zm_vulture_glow_vulture" );
    level._effect["vulture_perk_mystery_box_glow"] = loadfx( "maps/zombie/fx_zm_vulture_glow_mystery_box" );
    level._effect["vulture_perk_powerup_drop"] = loadfx( "maps/zombie/fx_zm_vulture_glow_powerup" );
    level._effect["vulture_perk_zombie_eye_glow"] = loadfx( "misc/fx_zombie_eye_vulture" );
    level.perk_vulture = spawnstruct();
    level.perk_vulture.array_stink_zombies = [];
    level.perk_vulture.array_stink_drop_locations = [];
    level.perk_vulture.players_with_vulture_perk = [];
    level.perk_vulture.vulture_vision_fx_list = [];
    level.perk_vulture.clientfields = spawnstruct();
    level.perk_vulture.clientfields.scriptmovers = [];
    level.perk_vulture.clientfields.scriptmovers[0] = ::vulture_stink_fx;
    level.perk_vulture.clientfields.scriptmovers[1] = ::vulture_drop_fx;
    level.perk_vulture.clientfields.scriptmovers[2] = ::vulture_drop_pickup;
    level.perk_vulture.clientfields.scriptmovers[3] = ::vulture_powerup_drop;
    level.perk_vulture.clientfields.actors = [];
    level.perk_vulture.clientfields.actors[1] = ::vulture_eye_glow;
    level.perk_vulture.clientfields.actors[0] = ::vulture_stink_trail_fx;
    level.perk_vulture.clientfields.toplayer = [];
    level.perk_vulture.clientfields.toplayer[0] = ::vulture_toggle;
    level.perk_vulture.disable_solo_quick_revive_glow = 0;

    if ( !isdefined( level.perk_vulture.custom_funcs_enable ) )
        level.perk_vulture.custom_funcs_enable = [];

    if ( !isdefined( level.perk_vulture.custom_funcs_disable ) )
        level.perk_vulture.custom_funcs_disable = [];

    level.zombie_eyes_clientfield_cb_additional = ::vulture_eye_glow_callback_from_system;
}

vulture_setup_on_player_connect( localclientnumber )
{
    player = getlocalplayer( localclientnumber );
    player vulture_on_player_connect( localclientnumber );
}

vulture_on_player_connect( localclientnumber )
{
    if ( is_createfx_active() )
        return;

    clientscripts\mp\_filter::init_filter_indices();
    map_material_helper( self, "generic_filter_zombie_perk_vulture" );
    self vulture_vision_init( localclientnumber, 1 );
    register_perk_clientfield_names_with_corresponding_perks();
}

vulture_add_custom_func_on_enable( func )
{
    if ( !isdefined( level.perk_vulture.custom_funcs_enable ) )
        level.perk_vulture.custom_funcs_enable = [];

    level.perk_vulture.custom_funcs_enable[level.perk_vulture.custom_funcs_enable.size] = func;
}

vulture_add_fx_to_client_array( localclientnumber, n_fx_id, str_special )
{
    if ( isdefined( str_special ) && isdefined( level.perk_vulture.fx_array[localclientnumber].fx_list_special ) )
        level.perk_vulture.fx_array[localclientnumber].fx_list_special[str_special] = n_fx_id;

    level.perk_vulture.fx_array[localclientnumber].fx_list[level.perk_vulture.fx_array[localclientnumber].fx_list.size] = n_fx_id;
}

vulture_add_custom_func_on_disable( func )
{
    if ( !isdefined( level.perk_vulture.custom_funcs_disable ) )
        level.perk_vulture.custom_funcs_disable = [];

    level.perk_vulture.custom_funcs_disable[level.perk_vulture.custom_funcs_disable.size] = func;
}

vulture_code_callback_func()
{
    setupclientfieldcodecallbacks( "toplayer", 1, "perk_vulture" );
}

vulture_client_field_func()
{
    registerclientfield( "toplayer", "perk_vulture", 12000, 2, "int", level.zombies_global_perk_client_callback, 0, 1 );
}

vulture_eye_glow( localclientnumber, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( newval )
    {
        self thread _zombie_eye_glow_think();
        self _zombie_eye_glow_enable( localclientnumber );
    }
    else
        self _zombie_eye_glow_disable( localclientnumber );
}

vulture_eye_glow_callback_from_system( localclientnumber, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( !newval )
        self _zombie_eye_glow_disable( localclientnumber );
}

vulture_callback_actor( localclientnumber, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    for ( i = 0; i < level.perk_vulture.clientfields.actors.size; i++ )
    {
        n_value_old = oldval & 1 << i;
        n_value_new = newval & 1 << i;
        b_value_old = 1 << i == n_value_old;
        b_value_new = 1 << i == n_value_new;

        if ( n_value_old != n_value_new || bnewent )
            self [[ level.perk_vulture.clientfields.actors[i] ]]( localclientnumber, b_value_old, b_value_new, bnewent, binitialsnap, fieldname, bwasdemojump );
    }
}

vulture_callback_scriptmover( localclientnumber, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    for ( i = 0; i < level.perk_vulture.clientfields.scriptmovers.size; i++ )
    {
        n_value_old = oldval & 1 << i;
        n_value_new = newval & 1 << i;
        b_value_old = 1 << i == n_value_old;
        b_value_new = 1 << i == n_value_new;

        if ( n_value_old != n_value_new || bnewent )
            self [[ level.perk_vulture.clientfields.scriptmovers[i] ]]( localclientnumber, b_value_old, b_value_new, bnewent, binitialsnap, fieldname, bwasdemojump );
    }
}

vulture_callback_toplayer( localclientnumber, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    for ( i = 0; i < level.perk_vulture.clientfields.toplayer.size; i++ )
    {
        n_value_old = oldval & 1 << i;
        n_value_new = newval & 1 << i;
        b_value_old = 1 << i == n_value_old;
        b_value_new = 1 << i == n_value_new;

        if ( n_value_old != n_value_new || bnewent )
            self [[ level.perk_vulture.clientfields.toplayer[i] ]]( localclientnumber, b_value_old, b_value_new, bnewent, binitialsnap, fieldname, bwasdemojump );
    }
}

vulture_powerup_drop( localclientnumber, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( newval )
    {
        if ( !isinarray( level.perk_vulture.vulture_vision.powerups, self ) )
        {
            level.perk_vulture.vulture_vision.powerups[level.perk_vulture.vulture_vision.powerups.size] = self;
            self _powerup_drop_fx_enable( localclientnumber );
        }
    }
    else
    {
        if ( !newval && oldval )
            arrayremovevalue( level.perk_vulture.vulture_vision.powerups, self, 0 );

        self _powerup_drop_fx_disable( localclientnumber );
    }
}

vulture_drop_fx( localclientnumber, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( newval )
    {
        self.n_vulture_drop_fx = playfxontag( localclientnumber, level._effect["vulture_perk_bonus_drop"], self, "tag_origin" );
        playsound( localclientnumber, "zmb_vulture_drop_spawn", self.origin );

        if ( !isdefined( self.vulture_sound_locations ) )
            self.vulture_sound_locations = [];

        if ( isdefined( self.vulture_sound_locations[localclientnumber] ) )
            stoploopat( "zmb_vulture_drop_loop", self.vulture_sound_locations[localclientnumber] );

        self.vulture_sound_locations[localclientnumber] = self.origin;
        playloopat( "zmb_vulture_drop_loop", self.vulture_sound_locations[localclientnumber] );
    }
    else if ( isdefined( self ) && isdefined( self.n_vulture_drop_fx ) )
    {
        deletefx( localclientnumber, self.n_vulture_drop_fx, 1 );

        if ( isdefined( self.vulture_sound_locations ) && isdefined( self.vulture_sound_locations[localclientnumber] ) )
            stoploopat( "zmb_vulture_drop_loop", self.vulture_sound_locations[localclientnumber] );
    }
}

vulture_drop_pickup( localclientnumber, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( newval )
        playfx( localclientnumber, level._effect["vulture_drop_picked_up"], self.origin );
    else
    {

    }
}

vulture_vision_mystery_box( localclientnumber, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( newval )
        self _mystery_box_fx_enable( localclientnumber );
    else
    {
        b_box_moving = !newval && oldval;
        self _mystery_box_fx_disable( localclientnumber, b_box_moving );

        if ( b_box_moving )
            arrayremovevalue( level.perk_vulture.vulture_vision.mystery_box, self, 0 );
    }
}

vulture_stink_fx( localclientnumber, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( newval )
    {
        if ( isdefined( self ) )
        {
            level.perk_vulture.array_stink_drop_locations[level.perk_vulture.array_stink_drop_locations.size] = self;
            self _stink_fx_enable( localclientnumber );
        }
    }
    else if ( isdefined( self ) )
    {
        arrayremovevalue( level.perk_vulture.array_stink_drop_locations, self, 0 );
        level.perk_vulture.array_stink_drop_locations = remove_undefined_from_array( level.perk_vulture.array_stink_drop_locations );
        self _stink_fx_disable( localclientnumber, bnewent );
    }
}

vulture_toggle( localclientnumber, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( newval )
    {
        if ( !isinarray( level.perk_vulture.players_with_vulture_perk, self ) )
            level.perk_vulture.players_with_vulture_perk[localclientnumber] = self;

        foreach ( zombie in level.perk_vulture.array_stink_zombies )
            zombie _stink_trail_enable( localclientnumber );

        foreach ( ent in level.perk_vulture.array_stink_drop_locations )
            ent _stink_fx_enable( localclientnumber );

        self vulture_vision_enable( localclientnumber );

        for ( i = 0; i < level.perk_vulture.custom_funcs_enable.size; i++ )
            [[ level.perk_vulture.custom_funcs_enable[i] ]]( localclientnumber );
    }
    else
    {
        level.perk_vulture.players_with_vulture_perk[localclientnumber] = undefined;
        _clean_up_global_zombie_arrays( localclientnumber );

        foreach ( zombie in level.perk_vulture.array_stink_zombies )
            zombie _stink_trail_disable( localclientnumber );

        foreach ( ent in level.perk_vulture.array_stink_drop_locations )
            ent _stink_fx_disable( localclientnumber, bnewent );

        self vulture_vision_disable( localclientnumber );

        for ( i = 0; i < level.perk_vulture.custom_funcs_disable.size; i++ )
            [[ level.perk_vulture.custom_funcs_disable[i] ]]( localclientnumber );
    }
}

vulture_stink_trail_fx( localclientnumber, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( !isdefined( level.perk_vulture.array_stink_zombies ) )
        level.perk_vulture.array_stink_zombies = [];

    if ( newval )
    {
        level.perk_vulture.array_stink_zombies[level.perk_vulture.array_stink_zombies.size] = self;
        self _stink_trail_enable( localclientnumber );
    }
    else if ( bnewent || !newval && oldval )
    {
        arrayremovevalue( level.perk_vulture.array_stink_zombies, self, 0 );
        _clean_up_global_zombie_arrays( localclientnumber );
        self _stink_trail_disable( localclientnumber, bnewent );
    }
}

_powerup_drop_fx_enable( localclientnumber )
{
    if ( isdefined( self ) )
    {
        if ( !isdefined( self.perk_vulture_fx_id ) )
            self.perk_vulture_fx_id = [];

        if ( _player_has_vulture( localclientnumber ) )
        {
            self.perk_vulture_fx_id[localclientnumber] = playfx( localclientnumber, level._effect["vulture_perk_powerup_drop"], self.origin );
            level.perk_vulture.vulture_vision_fx_list[localclientnumber].fx_list[level.perk_vulture.vulture_vision_fx_list[localclientnumber].fx_list.size] = self.perk_vulture_fx_id[localclientnumber];
        }
    }
}

_powerup_drop_fx_disable( localclientnumber )
{
    if ( isdefined( self ) && isdefined( self.perk_vulture_fx_id ) && isdefined( self.perk_vulture_fx_id[localclientnumber] ) )
        deletefx( localclientnumber, self.perk_vulture_fx_id[localclientnumber], 1 );
}

_stink_trail_enable( localclientnumber )
{
    if ( isdefined( self ) && !isdefined( self.n_vulture_fx_trail ) && _player_has_vulture( localclientnumber ) )
        self thread _loop_stink_trail( localclientnumber );
}

_loop_stink_trail( localclientnumber )
{
    self endon( "vulture_stop_stink_trail_fx" );

    if ( !isdefined( self.perk_vulture_stink_trail ) )
        self.perk_vulture_stink_trail = [];

    if ( !isdefined( self.sndent ) )
    {
        self.sndent = spawn( 0, self.origin, "script_origin" );
        self.sndent linkto( self );
    }

    sndent = self.sndent;
    sndent playloopsound( "zmb_vulture_stink_loop", 1 );
    self thread sndloopstinktraildelete( sndent );

    while ( isdefined( self ) )
    {
        self.perk_vulture_stink_trail[localclientnumber] = playfx( localclientnumber, level._effect["vulture_perk_zombie_stink_trail"], self.origin );
        wait 0.1;
    }

    if ( isdefined( sndent ) )
    {
        sndent stoploopsound();
        sndent delete();
    }
}

sndloopstinktraildelete( sndent )
{
    self endon( "death" );
    self waittill_any( "vulture_stop_stink_trail_fx", "vulture_stop_stink_fx" );

    if ( isdefined( sndent ) )
    {
        sndent stoploopsound();
        sndent delete();
    }
}

_stink_trail_disable( localclientnumber, b_kill_fx_immediately )
{
    if ( !isdefined( b_kill_fx_immediately ) )
        b_kill_fx_immediately = 0;

    if ( isdefined( self ) && isdefined( self.perk_vulture_stink_trail ) && isdefined( self.perk_vulture_stink_trail[localclientnumber] ) )
    {
        self notify( "vulture_stop_stink_trail_fx" );
        deletefx( localclientnumber, self.perk_vulture_stink_trail[localclientnumber], b_kill_fx_immediately );
        self.perk_vulture_stink_trail[localclientnumber] = undefined;
    }
}

_stink_fx_enable( localclientnumber )
{
    if ( isdefined( self ) && !isdefined( self.n_vulture_fx_id ) && _player_has_vulture( localclientnumber ) )
        self thread _loop_stink_stationary( localclientnumber );
}

_loop_stink_stationary( localclientnumber )
{
    if ( !isdefined( self.perk_vulture_fx ) )
        self.perk_vulture_fx = [];

    self.perk_vulture_fx_active = 1;
    sndorigin = self.origin;
    playloopat( "zmb_vulture_stink_loop", sndorigin );
    self thread sndloopstinkstationarydelete( sndorigin );

    while ( isdefined( self ) && ( isdefined( self.perk_vulture_fx_active ) && self.perk_vulture_fx_active ) )
    {
        self.perk_vulture_fx[localclientnumber] = playfx( localclientnumber, level._effect["vulture_perk_zombie_stink"], self.origin );
        wait 0.125;
    }

    stoploopat( "zmb_vulture_stink_loop", sndorigin );
}

sndloopstinkstationarydelete( sndorigin )
{
    self endon( "death" );
    self waittill_any( "vulture_stop_stink_trail_fx", "vulture_stop_stink_fx" );

    if ( isdefined( sndorigin ) )
        stoploopat( "zmb_vulture_stink_loop", sndorigin );
}

_stink_fx_disable( localclientnumber, b_kill_fx_immediately )
{
    if ( !isdefined( b_kill_fx_immediately ) )
        b_kill_fx_immediately = 1;

    if ( isdefined( self ) )
    {
        self.perk_vulture_fx_active = 0;
        self notify( "vulture_stop_stink_fx" );

        if ( isdefined( self.perk_vulture_fx ) && isdefined( self.perk_vulture_fx[localclientnumber] ) )
        {
            deletefx( localclientnumber, self.perk_vulture_fx[localclientnumber], b_kill_fx_immediately );
            self.perk_vulture_fx[localclientnumber] = undefined;
        }
    }
}

_mystery_box_fx_enable( localclientnumber )
{
    if ( !isinarray( level.perk_vulture.vulture_vision.mystery_box, self ) )
        level.perk_vulture.vulture_vision.mystery_box[level.perk_vulture.vulture_vision.mystery_box.size] = self;

    if ( !isdefined( self.perk_vulture_fx_id ) )
        self.perk_vulture_fx_id = [];

    if ( _player_has_vulture( localclientnumber ) )
    {
        n_fx_id = playfx( localclientnumber, level._effect["vulture_perk_mystery_box_glow"], self.origin, anglestoright( self.angles ), anglestoforward( self.angles ) );
        level.perk_vulture.vulture_vision_fx_list[localclientnumber].fx_list[level.perk_vulture.vulture_vision_fx_list[localclientnumber].fx_list.size] = n_fx_id;
        self.perk_vulture_fx_id[localclientnumber] = n_fx_id;
    }
}

_mystery_box_fx_disable( localclientnumber, b_force_kill_fx )
{
    if ( !isdefined( b_force_kill_fx ) )
        b_force_kill_fx = 0;

    if ( ( !_player_has_vulture( localclientnumber ) || b_force_kill_fx ) && isdefined( level.perk_vulture.vulture_vision.mystery_box ) && isdefined( level.perk_vulture.vulture_vision_fx_list[localclientnumber] ) && isdefined( self.perk_vulture_fx_id ) && isdefined( self.perk_vulture_fx_id[localclientnumber] ) )
        deletefx( localclientnumber, self.perk_vulture_fx_id[localclientnumber], 1 );
}

_zombie_eye_glow_think()
{
    level.perk_vulture.vulture_vision.actors_eye_glow[level.perk_vulture.vulture_vision.actors_eye_glow.size] = self;
    self waittill_any( "death", "entityshutdown" );
    level.perk_vulture.vulture_vision.actors_eye_glow = remove_undefined_from_array( level.perk_vulture.vulture_vision.actors_eye_glow );
}

_zombie_eye_glow_enable( localclientnumber )
{
    if ( _player_has_vulture( localclientnumber ) && isdefined( self ) )
    {
        if ( !isdefined( self.perk_vulture_fx_id ) )
            self.perk_vulture_fx_id = [];

        n_fx_id = level._effect["vulture_perk_zombie_eye_glow"];

        if ( isdefined( level.perk_vulture.vulture_vision.actors_eye_glow_override ) )
            n_fx_id = level.perk_vulture.vulture_vision.actors_eye_glow_override;

        if ( isdefined( self.vulture_perk_actor_eye_glow_override ) )
            n_fx_id = self.vulture_perk_actor_eye_glow_override;

        self.perk_vulture_fx_id[localclientnumber] = playfxontag( localclientnumber, n_fx_id, self, "J_Eyeball_LE" );
    }
}

set_vulture_custom_eye_glow( n_fx_id )
{
    level.perk_vulture.vulture_vision.actors_eye_glow_override = n_fx_id;
}

_zombie_eye_glow_disable( localclientnumber )
{
    if ( isdefined( self ) && isdefined( self.perk_vulture_fx_id ) && isdefined( self.perk_vulture_fx_id[localclientnumber] ) )
    {
        deletefx( localclientnumber, self.perk_vulture_fx_id[localclientnumber], 1 );
        self.perk_vulture_fx_id[localclientnumber] = undefined;
    }
}

_player_has_vulture( localclientnumber )
{
    return isdefined( level.perk_vulture.players_with_vulture_perk[localclientnumber] );
}

remove_undefined_from_array( array )
{
    newarray = [];

    for ( i = 0; i < array.size; i++ )
    {
        if ( !isdefined( array[i] ) )
            continue;

        newarray[newarray.size] = array[i];
    }

    return newarray;
}

_clean_up_global_zombie_arrays( localclientnumber )
{
    if ( isdefined( level.perk_vulture.array_stink_zombies ) )
        level.perk_vulture.array_stink_zombies = remove_undefined_from_array( level.perk_vulture.array_stink_zombies );
}

vulture_vision_init( localclientnumber, b_first_run )
{
    if ( !isdefined( b_first_run ) )
        b_first_run = 0;

    if ( !isdefined( level.perk_vulture.vulture_vision ) )
    {
        level.perk_vulture.vulture_vision = spawnstruct();
        level.perk_vulture.vulture_vision.perk_machines = [];
        level.perk_vulture.vulture_vision.mystery_box = [];
        level.perk_vulture.vulture_vision.powerups = [];
        level.perk_vulture.vulture_vision.actors_eye_glow = [];
        level.perk_vulture.vulture_vision.custom = [];
        vulture_vision_update_wallbuy_list( localclientnumber, b_first_run );
        setup_perk_machine_fx();
        a_perk_machines = getstructarray( "zm_perk_machine", "targetname" );

        foreach ( struct in a_perk_machines )
            level.perk_vulture.vulture_vision.perk_machines[struct.script_noteworthy] = struct;

        level.perk_vulture.vulture_vision_enabled = 1;
        level thread wallbuy_update_listener( localclientnumber );
    }
}

wallbuy_update_listener( localclientnumber )
{
    while ( true )
    {
        level waittill( "wallbuy_updated" );
        vulture_vision_update_wallbuy_list( localclientnumber );
    }
}

vulture_vision_update_wallbuy_list( localclientnumber, b_first_run )
{
    if ( !isdefined( b_first_run ) )
        b_first_run = 0;

    if ( isdefined( level.perk_vulture.vulture_vision_fx_list[localclientnumber] ) && isdefined( level.perk_vulture.vulture_vision_fx_list[localclientnumber].fx_list_wallbuy ) )
    {
        foreach ( n_fx_id in level.perk_vulture.vulture_vision_fx_list[localclientnumber].fx_list_wallbuy )
            deletefx( localclientnumber, n_fx_id, 1 );
    }

    level.perk_vulture.vulture_vision.wall_buys_static = [];
    level.perk_vulture.vulture_vision.wall_buys_dynamic = [];
    a_wall_buys = _get_wallbuy_array();
    a_keys = getarraykeys( a_wall_buys );

    for ( i = 0; i < a_keys.size; i++ )
    {
        s_temp = a_wall_buys[a_keys[i]];

        if ( s_temp.zombie_weapon_upgrade == "dynamic" )
        {
            if ( isdefined( s_temp.models ) && s_temp.models.size > 0 )
                level.perk_vulture.vulture_vision.wall_buys_static[level.perk_vulture.vulture_vision.wall_buys_static.size] = s_temp;
            else
                level.perk_vulture.vulture_vision.wall_buys_dynamic[level.perk_vulture.vulture_vision.wall_buys_dynamic.size] = s_temp;

            continue;
        }

        level.perk_vulture.vulture_vision.wall_buys_static[level.perk_vulture.vulture_vision.wall_buys_static.size] = s_temp;
    }

    if ( !b_first_run )
        vulture_vision_show_wallbuy_fx( localclientnumber );
}

vulture_vision_show_wallbuy_fx( localclientnumber )
{
    if ( _player_has_vulture( localclientnumber ) )
    {
        s_temp = level.perk_vulture.vulture_vision_fx_list[localclientnumber];

        for ( i = 0; i < level.perk_vulture.vulture_vision.wall_buys_static.size; i++ )
        {
            ent = level.perk_vulture.vulture_vision.wall_buys_static[i];
            s_temp.fx_list_wallbuy[s_temp.fx_list_wallbuy.size] = playfx( localclientnumber, level._effect["vulture_perk_wallbuy_static"], ent.origin, anglestoforward( ent.angles ), anglestoup( ent.angles ) );
        }

        for ( i = 0; i < level.perk_vulture.vulture_vision.wall_buys_dynamic.size; i++ )
        {
            ent = level.perk_vulture.vulture_vision.wall_buys_dynamic[i];
            s_temp.fx_list_wallbuy[s_temp.fx_list_wallbuy.size] = playfx( localclientnumber, level._effect["vulture_perk_wallbuy_dynamic"], ent.origin, anglestoforward( ent.angles ), anglestoup( ent.angles ) );
        }
    }
}

vulture_vision_enable( localclientnumber )
{
    if ( isdefined( level.perk_vulture.vulture_vision_fx_list[localclientnumber] ) )
        vulture_vision_disable( localclientnumber );

    level.perk_vulture.vulture_vision_fx_list[localclientnumber] = spawnstruct();
    s_temp = level.perk_vulture.vulture_vision_fx_list[localclientnumber];
    s_temp.player_ent = self;
    s_temp.fx_list = [];
    s_temp.fx_list_wallbuy = [];
    s_temp.fx_list_special = [];
    vulture_vision_show_wallbuy_fx( localclientnumber );
    a_keys = getarraykeys( level.perk_vulture.vulture_vision.perk_machines );

    for ( i = 0; i < a_keys.size; i++ )
    {
        s_perk_machine = level.perk_vulture.vulture_vision.perk_machines[a_keys[i]];

        if ( isdefined( level.perk_vulture.vulture_vision.perk_machine_fx[a_keys[i]] ) )
            str_perk_machine_fx = level.perk_vulture.vulture_vision.perk_machine_fx[a_keys[i]];
        else
        {
            str_perk_machine_fx = "vulture_perk_machine_glow_speed";
/#
            println( "ZM PERK VULTURE >> perk machine with name '" + a_keys[i] + "' is missing vulture perk fx!" );
#/
        }

        if ( a_keys[i] == "specialty_weapupgrade" || a_keys[i] == "specialty_nomotionsensor" || !self hasperk( localclientnumber, a_keys[i] ) )
        {
            if ( a_keys[i] != "specialty_quickrevive" || !level.perk_vulture.disable_solo_quick_revive_glow )
                s_temp.fx_list_special[a_keys[i]] = playfx( localclientnumber, level._effect[str_perk_machine_fx], s_perk_machine.origin, anglestoforward( s_perk_machine.angles ), anglestoup( s_perk_machine.angles ) );
        }
    }

    if ( level.perk_vulture.vulture_vision.mystery_box.size > 0 )
    {
        level.perk_vulture.vulture_vision.mystery_box = remove_undefined_from_array( level.perk_vulture.vulture_vision.mystery_box );

        for ( i = 0; i < level.perk_vulture.vulture_vision.mystery_box.size; i++ )
            level.perk_vulture.vulture_vision.mystery_box[i] _mystery_box_fx_enable( localclientnumber );
    }

    foreach ( powerup in level.perk_vulture.vulture_vision.powerups )
        powerup _powerup_drop_fx_enable( localclientnumber );

    foreach ( zombie in level.perk_vulture.vulture_vision.actors_eye_glow )
        zombie _zombie_eye_glow_enable( localclientnumber );

    self.perk_vulture = s_temp;
    level.perk_vulture.fx_array[localclientnumber] = s_temp;
}

setup_perk_machine_fx()
{
    register_perk_machine_fx( "specialty_armorvest", "vulture_perk_machine_glow_juggernog" );
    register_perk_machine_fx( "specialty_rof", "vulture_perk_machine_glow_doubletap" );
    register_perk_machine_fx( "specialty_quickrevive", "vulture_perk_machine_glow_revive" );
    register_perk_machine_fx( "specialty_fastreload", "vulture_perk_machine_glow_speed" );
    register_perk_machine_fx( "specialty_weapupgrade", "vulture_perk_machine_glow_pack_a_punch" );
    register_perk_machine_fx( "specialty_longersprint", "vulture_perk_machine_glow_marathon" );
    register_perk_machine_fx( "specialty_additionalprimaryweapon", "vulture_perk_machine_glow_mule_kick" );
    register_perk_machine_fx( "specialty_nomotionsensor", "vulture_perk_machine_glow_vulture" );
}

register_perk_machine_fx( str_perk, str_fx_reference )
{
    if ( !isdefined( level.perk_vulture.vulture_vision.perk_machine_fx ) )
        level.perk_vulture.vulture_vision.perk_machine_fx = [];

    if ( !isdefined( level.perk_vulture.vulture_vision.perk_machine_fx[str_perk] ) )
        level.perk_vulture.vulture_vision.perk_machine_fx[str_perk] = str_fx_reference;
}

vulture_vision_disable( localclientnumber )
{
    b_removed_fx = 0;

    if ( isdefined( level.perk_vulture.vulture_vision_fx_list[localclientnumber] ) )
    {
        if ( isdefined( level.perk_vulture.vulture_vision_fx_list[localclientnumber].fx_list ) )
        {
            foreach ( n_fx_id in level.perk_vulture.vulture_vision_fx_list[localclientnumber].fx_list )
                deletefx( localclientnumber, n_fx_id, 1 );
        }

        if ( isdefined( level.perk_vulture.vulture_vision_fx_list[localclientnumber].fx_list_wallbuy ) )
        {
            foreach ( n_fx_id in level.perk_vulture.vulture_vision_fx_list[localclientnumber].fx_list_wallbuy )
                deletefx( localclientnumber, n_fx_id, 1 );
        }

        if ( isdefined( level.perk_vulture.vulture_vision_fx_list[localclientnumber].fx_list_special ) )
        {
            foreach ( n_fx_id in level.perk_vulture.vulture_vision_fx_list[localclientnumber].fx_list_special )
                deletefx( localclientnumber, n_fx_id, 1 );

            level.perk_vulture.vulture_vision_fx_list[localclientnumber] = undefined;
        }
    }

    foreach ( powerup in level.perk_vulture.vulture_vision.powerups )
        powerup _powerup_drop_fx_disable( localclientnumber );

    foreach ( zombie in level.perk_vulture.vulture_vision.actors_eye_glow )
        zombie _zombie_eye_glow_disable( localclientnumber );
}

_get_wallbuy_array()
{
    return level._active_wallbuys;
}

vulture_global_perk_client_callback( localclientnumber, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    b_icon_should_appear = newval & 1;

    if ( isdefined( level.perk_vulture ) && b_icon_should_appear )
    {
        if ( isdefined( level.perk_vulture.vulture_vision.perk_clientfields[fieldname] ) )
        {
            str_perk = level.perk_vulture.vulture_vision.perk_clientfields[fieldname];

            if ( str_perk != "specialty_weapupgrade" && str_perk != "specialty_nomotionsensor" && self hasperk( localclientnumber, str_perk ) || str_perk == "specialty_quickrevive" && level.perk_vulture.disable_solo_quick_revive_glow )
            {
                if ( _player_has_vulture( localclientnumber ) && isdefined( level.perk_vulture.vulture_vision_fx_list[localclientnumber] ) && isdefined( level.perk_vulture.vulture_vision_fx_list[localclientnumber].fx_list_special[str_perk] ) )
                    deletefx( localclientnumber, level.perk_vulture.vulture_vision_fx_list[localclientnumber].fx_list_special[str_perk], 1 );
            }
        }
    }
}

register_perk_with_clientfield( str_clientfield, str_perk )
{
    if ( !isdefined( level.perk_vulture.vulture_vision.perk_clientfields ) )
        level.perk_vulture.vulture_vision.perk_clientfields = [];

    if ( !isdefined( level.perk_vulture.vulture_vision.perk_clientfields[str_clientfield] ) )
        level.perk_vulture.vulture_vision.perk_clientfields[str_clientfield] = str_perk;
}

register_perk_clientfield_names_with_corresponding_perks()
{
    register_perk_with_clientfield( "perk_additional_primary_weapon", "specialty_additionalprimaryweapon" );
    register_perk_with_clientfield( "perk_dead_shot", "specialty_deadshot" );
    register_perk_with_clientfield( "perk_dive_to_nuke", "specialty_flakjacket" );
    register_perk_with_clientfield( "perk_double_tap", "specialty_rof" );
    register_perk_with_clientfield( "perk_juggernaut", "specialty_armorvest" );
    register_perk_with_clientfield( "perk_marathon", "specialty_longersprint" );
    register_perk_with_clientfield( "perk_quick_revive", "specialty_quickrevive" );
    register_perk_with_clientfield( "perk_sleight_of_hand", "specialty_fastreload" );
    register_perk_with_clientfield( "perk_tombstone", "specialty_scavenger" );
    register_perk_with_clientfield( "perk_chugabud", "specialty_finalstand" );
    register_perk_with_clientfield( "perk_electric_cherry", "specialty_grenadepulldeath" );
    register_perk_with_clientfield( "perk_vulture", "specialty_nomotionsensor" );
}

vulture_disable_solo_quick_revive_glow( localclientnumber, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( newval )
        level.perk_vulture.disable_solo_quick_revive_glow = 1;
    else
        level.perk_vulture.disable_solo_quick_revive_glow = 0;
}

sndvulturestink( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( newval == 1 )
        self thread sndactivatevulturestink();
    else
        self thread snddeactivatevulturestink();
}

sndactivatevulturestink()
{
    if ( !isdefined( self.sndstinkent ) )
    {
        self.sndstinkent = spawn( 0, ( 0, 0, 0 ), "script_origin" );
        self.sndstinkent playloopsound( "zmb_vulture_stink_player_loop", 0.5 );
    }

    playsound( 0, "zmb_vulture_stink_player_start", ( 0, 0, 0 ) );
    snd_set_snapshot( "zmb_buried_stink" );
}

snddeactivatevulturestink()
{
    playsound( 0, "zmb_vulture_stink_player_stop", ( 0, 0, 0 ) );
    snd_set_snapshot( "default" );

    if ( isdefined( self.sndstinkent ) )
    {
        self.sndstinkent stoploopsound();
        self.sndstinkent delete();
        self.sndstinkent = undefined;
    }
}

set_vulture_stink_fogbanks( fogbank_enabled, fogbank_disabled )
{
    level.perk_vulture.fog_banks_enabled = 1;
    level.perk_vulture.fog_bank_stink_on = fogbank_enabled;
    level.perk_vulture.fog_bank_stink_off = fogbank_disabled;
}

vulture_callback_stink_active( localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump )
{
    if ( isdefined( self ) )
    {
        if ( newval > 0 )
            self vulture_fogbank_enable( localclientnum );
        else
            self vulture_fogbank_disable( localclientnum );
    }
}

vulture_fogbank_disable( localclientnumber )
{
    if ( isdefined( level.perk_vulture.fog_banks_enabled ) && isdefined( level.perk_vulture.fog_bank_stink_off ) )
        setworldfogactivebank( localclientnumber, level.perk_vulture.fog_bank_stink_off );
}

vulture_fogbank_enable( localclientnumber )
{
    if ( isdefined( level.perk_vulture.fog_banks_enabled ) && isdefined( level.perk_vulture.fog_bank_stink_on ) )
        setworldfogactivebank( localclientnumber, level.perk_vulture.fog_bank_stink_on );
}

enable_divetonuke_perk_for_level()
{
    clientscripts\mp\zombies\_zm_perks::register_perk_clientfields( "specialty_flakjacket", ::divetonuke_client_field_func, ::divetonuke_code_callback_func );
    clientscripts\mp\zombies\_zm_perks::register_perk_init_thread( "specialty_flakjacket", ::init_divetonuke );
}

init_divetonuke()
{
    if ( isdefined( level.enable_magic ) && level.enable_magic )
        clientscripts\mp\_visionset_mgr::vsmgr_register_visionset_info( "zm_perk_divetonuke", 9000, 5, "zombie_cosmodrome_divetonuke", "zombie_cosmodrome_divetonuke" );

    level._effect["divetonuke_groundhit"] = loadfx( "maps/zombie/fx_zmb_phdflopper_exp" );
}

divetonuke_client_field_func()
{
    registerclientfield( "toplayer", "perk_dive_to_nuke", 9000, 1, "int", undefined, 0, 1 );
}

divetonuke_code_callback_func()
{
    setupclientfieldcodecallbacks( "toplayer", 1, "perk_dive_to_nuke" );
}