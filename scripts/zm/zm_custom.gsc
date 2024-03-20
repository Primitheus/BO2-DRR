#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes_zm\_hud_util;
#include maps\mp\zombies\_zm_weapons;
#include maps\mp\zombies\_zm_stats;
#include maps\mp\zm_highrise_elevators;
#include maps\mp\zm_highrise_buildables;
#include maps\mp\gametypes_zm\_spawnlogic;
#include maps\mp\animscripts\traverse\shared;
#include maps\mp\animscripts\utility;
#include maps\mp\zombies\_load;
#include maps\mp\_createfx;
#include maps\mp\_music;
#include maps\mp\_busing;
#include maps\mp\_script_gen;
#include maps\mp\gametypes_zm\_globallogic_audio;
#include maps\mp\gametypes_zm\_tweakables;
#include maps\mp\_challenges;
#include maps\mp\gametypes_zm\_weapons;
#include maps\mp\_demo;
#include maps\mp\gametypes_zm\_spawning;
#include maps\mp\gametypes_zm\_globallogic_utils;
#include maps\mp\gametypes_zm\_spectating;
#include maps\mp\gametypes_zm\_globallogic_spawn;
#include maps\mp\gametypes_zm\_globallogic_ui;
#include maps\mp\gametypes_zm\_hostmigration;
#include maps\mp\gametypes_zm\_globallogic_score;
#include maps\mp\gametypes_zm\_globallogic;
#include maps\mp\zombies\_zm;
#include maps\mp\zombies\_zm_ai_faller;
#include maps\mp\zombies\_zm_spawner;
#include maps\mp\zombies\_zm_pers_upgrades_functions;
#include maps\mp\zombies\_zm_pers_upgrades;
#include maps\mp\zombies\_zm_score;
#include maps\mp\animscripts\zm_run;
#include maps\mp\animscripts\zm_death;
#include maps\mp\zombies\_zm_blockers;
#include maps\mp\animscripts\zm_shared;
#include maps\mp\animscripts\zm_utility;
#include maps\mp\zombies\_zm_ai_basic;
#include maps\mp\zombies\_zm_laststand;
#include maps\mp\zombies\_zm_net;
#include maps\mp\zombies\_zm_audio;
#include maps\mp\gametypes_zm\_zm_gametype;
#include maps\mp\_visionset_mgr;
#include maps\mp\zombies\_zm_equipment;
#include maps\mp\zombies\_zm_power;
#include maps\mp\zombies\_zm_server_throttle;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\zombies\_zm_unitrigger;
#include maps\mp\zombies\_zm_zonemgr;
#include maps\mp\zombies\_zm_perks;
#include maps\mp\zombies\_zm_melee_weapon;
#include maps\mp\zombies\_zm_audio_announcer;
#include maps\mp\zombies\_zm_magicbox;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zombies\_zm_ai_dogs;
#include maps\mp\gametypes_zm\_hud_message;
#include maps\mp\zombies\_zm_game_module;
#include maps\mp\zombies\_zm_buildables;
#include codescripts\character;
#include maps\mp\zombies\_zm_weap_riotshield;
#include maps\mp\zombies\_zm_ai_sloth;
#include maps\mp\zombies\_zm_ai_sloth_ffotd;
#include maps\mp\zombies\_zm_ai_sloth_utility;
#include maps\mp\zombies\_zm_ai_sloth_magicbox;
#include maps\mp\zombies\_zm_ai_sloth_crawler;
#include maps\mp\zombies\_zm_ai_sloth_buildables;
#include maps\mp\zombies\_zm_afterlife;
#include maps\mp\zombies\_zm_perk_electric_cherry;
#include maps\mp\zombies\_zm_perk_vulture;
#include maps\mp\zm_prison;
#include maps\mp\zombies\_zm_perk_divetonuke;


main()
{


	replacefunc(maps\mp\zombies\_zm_perks::perk_machine_spawn_init, ::perk_machine_spawn_init_override);

    replacefunc(maps\mp\zm_highrise_elevators::init_elevators, ::zm_highrise_elevators_init_override);
    replacefunc(maps\mp\zm_highrise_elevators::init_elevator, ::init_elevator_override);
    replacefunc(maps\mp\zm_highrise_elevators::init_elevator_perks, ::init_elevator_perks_override);
    replacefunc(maps\mp\zm_highrise_elevators::elevator_think, ::elevator_think_override);
    replacefunc(maps\mp\zm_highrise_elevators::random_elevator_perks, ::random_elevator_perks_override);

    replacefunc(maps\mp\zm_highrise_buildables::onuseplantobject_elevatorkey, ::onuseplantobject_elevatorkey_override);


	level.zombiemode_using_electric_cherry_perk = 1;
    maps\mp\zombies\_zm_perk_electric_cherry::enable_electric_cherry_perk_for_level();
    maps\mp\_visionset_mgr::vsmgr_register_info( "visionset", "zm_electric_cherry", 9000, 121, 1, 1 );

    // Deadshot
    level.zombiemode_using_deadshot_perk = 1;

    // Vulture
    enable_vulture_perk_for_level();

    // PhD Flopper
    level.zombiemode_using_divetonuke_perk = 1;
    enable_divetonuke_perk_for_level();
    //maps\mp\zombies\_zm_perk_divetonuke::enable_divetonuke_perk_for_level();

    //spawn_electric_c((1483.35, 1568.57, 3391.57), (0, 0.726334, 0));

 

}

init_elevator_perks_override()
{
    level.elevator_perks = [];
    level.elevator_perks_building = [];
    level.elevator_perks_building["green"] = [];
    level.elevator_perks_building["blue"] = [];
    level.elevator_perks_building["green"][0] = spawnstruct();
    level.elevator_perks_building["green"][0].model = "zombie_vending_revive";
    level.elevator_perks_building["green"][0].script_noteworthy = "specialty_quickrevive";
    level.elevator_perks_building["green"][0].turn_on_notify = "revive_on";
   
    a = 1;
    b = 2;

    level.custom_electric_perk = spawn_electric_c((1483.35, 1568.57, 9000.57), (0, 0.726334, 0));
    level.custom_vulture_aid_perk = spawn_vulture_aid((1483.35, 1568.57, 9000.57), (0, 0.726334, 0));
    level.custom_deadshot_perk = spawn_deadshot((1483.35, 1568.57, 9000.57), (0, 0.726334, 0));
    level.custom_phd_flopper_perk = spawn_phd_flopper((1483.35, 1568.57, 9000.57), (0, 0.726334, 0));
    
    //level.custom_staminup_perk;

    // most likely won't add
    //level.thomnstone_perk;

    if ( randomint( 100 ) > 50 )
    {
        a = 2;
        b = 1;

    }

    level.elevator_perks_building["green"][a] = spawnstruct();
    level.elevator_perks_building["green"][a].model = "p6_zm_vending_chugabud";
    level.elevator_perks_building["green"][a].script_noteworthy = "specialty_finalstand";
    level.elevator_perks_building["green"][a].turn_on_notify = "chugabud_on";
    level.elevator_perks_building["green"][b] = spawnstruct();
    level.elevator_perks_building["green"][b].model = "zombie_vending_sleight";
    level.elevator_perks_building["green"][b].script_noteworthy = "specialty_fastreload";
    level.elevator_perks_building["green"][b].turn_on_notify = "sleight_on";
    level.elevator_perks_building["blue"][0] = spawnstruct();
    level.elevator_perks_building["blue"][0].model = "zombie_vending_three_gun";
    level.elevator_perks_building["blue"][0].script_noteworthy = "specialty_additionalprimaryweapon";
    level.elevator_perks_building["blue"][0].turn_on_notify = "specialty_additionalprimaryweapon_power_on";
    level.elevator_perks_building["blue"][1] = spawnstruct();
    level.elevator_perks_building["blue"][1].model = "zombie_vending_jugg";
    level.elevator_perks_building["blue"][1].script_noteworthy = "specialty_armorvest";
    level.elevator_perks_building["blue"][1].turn_on_notify = "juggernog_on";
    level.elevator_perks_building["blue"][2] = spawnstruct();
    level.elevator_perks_building["blue"][2].model = "zombie_vending_doubletap2";
    level.elevator_perks_building["blue"][2].script_noteworthy = "specialty_rof";
    level.elevator_perks_building["blue"][2].turn_on_notify = "doubletap_on";
    level.elevator_perks_building["blue"][3] = spawnstruct();
    level.elevator_perks_building["blue"][3].model = "p6_anim_zm_buildable_pap";
    level.elevator_perks_building["blue"][3].script_noteworthy = "specialty_weapupgrade";
    level.elevator_perks_building["blue"][3].turn_on_notify = "Pack_A_Punch_on";

    players_expected = getnumexpectedplayers();
    level.override_perk_targetname = "zm_perk_machine_override";
    level.elevator_perks_building["blue"] = array_randomize( level.elevator_perks_building["blue"] );
    level.elevator_perks = arraycombine( level.elevator_perks_building["green"], level.elevator_perks_building["blue"], 0, 0 );
    random_perk_structs = [];
    revive_perk_struct = getstruct( "force_quick_revive", "targetname" );
    revive_perk_struct = getstruct( revive_perk_struct.target, "targetname" );
    perk_structs = getstructarray( "zm_random_machine", "script_noteworthy" );

    for ( i = 0; i < perk_structs.size; i++ )
    {
        random_perk_structs[i] = getstruct( perk_structs[i].target, "targetname" );
        random_perk_structs[i].script_parameters = perk_structs[i].script_parameters;
        random_perk_structs[i].script_linkent = getent( "elevator_" + perk_structs[i].script_parameters + "_body", "targetname" );
    }

    

    green_structs = [];
    blue_structs = [];

    foreach ( perk_struct in random_perk_structs )
    {
        if ( isdefined( perk_struct.script_parameters ) )
        {
            if ( issubstr( perk_struct.script_parameters, "bldg1" ) )
            {
                green_structs[green_structs.size] = perk_struct;
                continue;
            }

            blue_structs[blue_structs.size] = perk_struct;
        }
    }

    green_structs = array_exclude( green_structs, revive_perk_struct );
    green_structs = array_randomize( green_structs );
    blue_structs = array_randomize( blue_structs );
    level.random_perk_structs = array( revive_perk_struct );
    level.random_perk_structs = arraycombine( level.random_perk_structs, green_structs, 0, 0 );
    level.random_perk_structs = arraycombine( level.random_perk_structs, blue_structs, 0, 0 );

    for ( i = 0; i < level.elevator_perks.size; i++ )
    {
        if ( !isdefined( level.random_perk_structs[i] ) )
            continue;

        level.random_perk_structs[i].targetname = "zm_perk_machine_override";
        level.random_perk_structs[i].model = level.elevator_perks[i].model;
        level.random_perk_structs[i].script_noteworthy = level.elevator_perks[i].script_noteworthy;
        level.random_perk_structs[i].turn_on_notify = level.elevator_perks[i].turn_on_notify;

        if ( !isdefined( level.struct_class_names["targetname"]["zm_perk_machine_override"] ) )
            level.struct_class_names["targetname"]["zm_perk_machine_override"] = [];

        level.struct_class_names["targetname"]["zm_perk_machine_override"][level.struct_class_names["targetname"]["zm_perk_machine_override"].size] = level.random_perk_structs[i];
    }

    
}

elevator_think_override( elevator )
{

    current_floor = elevator.body.current_location;
    delaybeforeleaving = 5;
    skipinitialwait = 0;
    speed = 100;
    minwait = 5;
    maxwait = 20;
    flag_wait( "perks_ready" );
    

    if ( isdefined( elevator.body.force_starting_floor ) )
    {
        elevator.body.current_level = "" + elevator.body.force_starting_floor;
        elevator.body.origin = elevator.floors[elevator.body.current_level].origin;

        if ( isdefined( elevator.body.force_starting_origin_offset ) )
            elevator.body.origin = elevator.body.origin + ( 0, 0, elevator.body.force_starting_origin_offset );
    }

    elevator.body.can_move = 1;
    elevator elevator_set_moving( 0 );
    elevator elevator_enable_paths( elevator.body.current_level );

    if ( elevator.body.perk_type == "vending_electriccherry" )
    {
        minwait = level.packapunch_timeout;
        maxwait = minwait + 10;
        elevator thread quick_revive_solo_watch();
    }

    if ( elevator.body.perk_type == "vending_revive" && flag( "solo_game" ) )
    {
        level notify( "revive_on" );
        level notify( "electric_cherry_on");
        level notify(  "speialty_nomotionsensor_on");
        level notify( "divetonuke_on");


    }
    else
        flag_wait( "power_on" );

    elevator.body perkelevatordoor( 1 );
    next = undefined;

    while ( true )
    {
        start_location = 0;

        if ( isdefined( elevator.body.force_starting_floor ) )
            skipinitialwait = 1;

        elevator.body.departing = 1;

        if ( !is_true( elevator.body.lock_doors ) )
            elevator.body setanim( level.perk_elevators_anims[elevator.body.perk_type][1] );

        predict_floor( elevator, next, speed );

        if ( !is_true( skipinitialwait ) )
        {
            elevator_initial_wait( elevator, minwait, maxwait, delaybeforeleaving );

            if ( !is_true( elevator.body.lock_doors ) )
                elevator.body setanim( level.perk_elevators_anims[elevator.body.perk_type][1] );
        }

        next = elevator_next_floor( elevator, next, 0 );

        if ( isdefined( elevator.floors["" + ( next + 1 )] ) )
            elevator.body.next_level = "" + ( next + 1 );
        else
        {
            start_location = 1;
            elevator.body.next_level = "0";
        }

        floor_stop = elevator.floors[elevator.body.next_level];
        floor_goal = undefined;
        cur_level_start_pos = elevator.floors[elevator.body.next_level].starting_position;
        start_level_start_pos = elevator.floors[elevator.body.starting_floor].starting_position;

        if ( elevator.body.next_level == elevator.body.starting_floor || isdefined( cur_level_start_pos ) && isdefined( start_level_start_pos ) && cur_level_start_pos == start_level_start_pos )
            floor_goal = cur_level_start_pos;
        else
            floor_goal = floor_stop.origin;

        dist = distance( elevator.body.origin, floor_goal );
        time = dist / speed;

        if ( dist > 0 )
        {
            if ( elevator.body.origin[2] > floor_goal[2] )
                clientnotify( elevator.name + "_d" );
            else
                clientnotify( elevator.name + "_u" );
        }

        if ( is_true( start_location ) )
        {
            elevator.body thread squashed_death_alarm();

            if ( !skipinitialwait )
                wait 3;
        }

        skipinitialwait = 0;
        elevator.body.current_level = elevator.body.next_level;
        elevator notify( "floor_changed" );
        elevator elevator_disable_paths( elevator.body.current_level );
        elevator.body.departing = 0;
        elevator elevator_set_moving( 1 );

        if ( dist > 0 )
        {
            elevator.body moveto( floor_goal, time, time * 0.25, time * 0.25 );

            if ( isdefined( elevator.body.trig ) )
                elevator.body thread elev_clean_up_corpses();

            elevator.body thread elevator_move_sound();
            elevator.body waittill_any( "movedone", "forcego" );
        }

        elevator elevator_set_moving( 0 );
        elevator elevator_enable_paths( elevator.body.current_level );

        if ( elevator.body.perk_type == "vending_revive" && !flag( "solo_game" ) && !flag( "power_on" ) )
            flag_wait( "power_on" );
    }
}

random_elevator_perks_override()
{
    perks = array( "vending_deadshot", "vending_vulture", "vending_electriccherry", "vending_divetonuke", "vending_additionalprimaryweapon", "vending_revive", "vending_chugabud", "vending_jugg", "vending_doubletap", "vending_sleight" );

    foreach ( perk in perks )
    {
        machine = getent( perk, "targetname" );
        trigger = getent( perk, "target" );

        if ( !isdefined( machine ) || !isdefined( trigger ) )
            continue;

        elevator = machine get_perk_elevator_override();

        trigger enablelinkto();
        trigger linkto( machine );

        if ( isdefined( trigger.clip ) )
            trigger.clip delete();

        if ( isdefined( trigger.bump ) )
        {
            trigger.bump enablelinkto();
            trigger.bump linkto( machine );
        }

        if ( isdefined( elevator ) )
        {
            elevator.perk_type = perk;

            if ( issubstr( elevator.targetname, "3b" ) )
                machine.origin = machine.origin + vectorscale( ( 0, 0, 1 ), 8.0 );

            elevator elevator_perk_offset( machine, perk );
            machine linkto( elevator );
            machine._linked_ent = elevator;
            machine._linked_ent_moves = 1;
            machine._linked_ent_offset = machine.origin - elevator.origin;


            if (perk == "vending_doubletap")
            {
                level.custom_deadshot_perk.origin = machine.origin;
                level.custom_deadshot_perk.angles = machine.angles;
                level.custom_deadshot_trigger.origin = machine.origin + vectorscale( ( 0, 0, 1 ), 30.0 );
                level.custom_deadshot_trigger.angles = machine.angles;

                level.custom_deadshot_perk Hide();
                level.custom_deadshot_perk linkto( elevator );
                level.custom_deadshot_trigger trigger_off();
                level.custom_deadshot_trigger EnableLinkTo();
                level.custom_deadshot_trigger linkto( machine );

            }

            if (perk == "vending_additionalprimaryweapon")
            {
                level.custom_vulture_aid_perk.origin = machine.origin;
                level.custom_vulture_aid_perk.angles = machine.angles;
                level.custom_vulture_aid_trigger.origin = machine.origin + vectorscale( ( 0, 0, 1 ), 30.0 );
                level.custom_vulture_aid_trigger.angles = machine.angles;

                level.custom_vulture_aid_perk Hide();
                level.custom_vulture_aid_perk linkto( elevator );
                level.custom_vulture_aid_trigger trigger_off();
                level.custom_vulture_aid_trigger EnableLinkTo();
                level.custom_vulture_aid_trigger linkto( machine );

            }

            if (perk == "vending_sleight")
            {
                level.custom_electric_perk.origin = machine.origin;
                level.custom_electric_perk.angles = machine.angles;
                level.custom_electric_trigger.origin = machine.origin + vectorscale( ( 0, 0, 1 ), 30.0 );
                level.custom_electric_trigger.angles = machine.angles;

                level.custom_electric_perk Hide();
                level.custom_electric_perk linkto( elevator );
                level.custom_electric_trigger trigger_off();
                level.custom_electric_trigger EnableLinkTo();
                level.custom_electric_trigger linkto( machine );
            }

            if (perk == "vending_jugg")
            {
                level.custom_phd_flopper_perk.origin = machine.origin;
                level.custom_phd_flopper_perk.angles = machine.angles;
                level.custom_phd_flopper_trigger.origin = machine.origin + vectorscale( ( 0, 0, 1 ), 30.0 );
                level.custom_phd_flopper_trigger.angles = machine.angles;

                level.custom_phd_flopper_perk Hide();
                level.custom_phd_flopper_perk linkto( elevator );
                level.custom_phd_flopper_trigger trigger_off();
                level.custom_phd_flopper_trigger EnableLinkTo();
                level.custom_phd_flopper_trigger linkto( machine );
            }

            if ( perk == "vending_revive" )
            {
                level.quick_revive_linked_ent = elevator;
                level.quick_revive_linked_ent_moves = 1;
                level.quick_revive_linked_ent_offset = machine._linked_ent_offset;
            }

            level thread debugline( machine, elevator );
        }

        //perk_system( "script_model", machine.origin, "p6_zm_vending_electric_cherry_on", machine.angles, "custom", "mus_perks_sleight_sting", "Electric Cherry", 3000, "revive_light", "ELECTRIC_CHERRY","zombie_perk_bottle_jugg", elevator);

    }

    trigger = getent( "specialty_weapupgrade", "script_noteworthy" );

    if ( isdefined( trigger ) )
    {
        machine = getent( trigger.target, "targetname" );
        elevator = machine get_perk_elevator_override();
        fwdvec = anglestoright( machine.angles );
        fwdvec = vectornormalize( fwdvec ) * 20;
        trigger.origin = trigger.origin + ( fwdvec[0], fwdvec[1], 8 );
        trigger enablelinkto();
        trigger linkto( machine );

        if ( isdefined( trigger.clip ) )
            trigger.clip delete();

        if ( isdefined( elevator ) )
        {
            elevator.perk_type = "specialty_weapupgrade";
            machine linkto( elevator );
            level thread debugline( machine, elevator );
        }
    }



    flag_set( "perks_ready" );

}



get_perk_elevator_override()
{
    arraylist = level.random_perk_structs;

    for ( x = 0; x < arraylist.size; x++ )
    {
        struct = arraylist[x];

        if ( isdefined( struct.script_noteworthy ) && isdefined( self.targetname ) )
        {
            nw = struct.script_noteworthy;
            tn = self.targetname;
            if ( nw == "specialty_flakjacket" && tn == "vending_divetonuke" || nw == "specialty_grenadepulldeath" && tn == "vending_electriccherry" || nw == "specialty_nomotionsensor" && tn == "vending_vulture" || nw == "specialty_quickrevive" && tn == "vending_revive" || nw == "specialty_fastreload" && tn == "vending_sleight" || nw == "specialty_rof" && tn == "vending_doubletap" || nw == "specialty_armorvest" && tn == "vending_jugg" || nw == "specialty_finalstand" && tn == "vending_chugabud" || nw == "specialty_additionalprimaryweapon" && tn == "vending_additionalprimaryweapon" || nw == "specialty_weapupgrade" && tn == "vending_packapunch" )
            {
                if ( isdefined( struct.script_linkent ) )
                    return struct.script_linkent;
            }
        }
    }

    return undefined;
}



onuseplantobject_elevatorkey_override()
{
    elevatorname = self.script_noteworthy;

    if ( isdefined( elevatorname ) && isdefined( self.script_parameters ) )
    {
        floor = int( self.script_parameters );
        elevator = level.elevators[elevatorname];

        if ( isdefined( elevator ) )
        {
            elevator.body.force_starting_floor = floor;
            elevator.body notify( "forcego" );
        }

    }
}



zm_highrise_elevators_init_override()
{
        level thread init_perk_elevators_anims();

}

init_elevator_override( elevatorname, force_starting_floor, force_starting_origin )
{
    if ( !isdefined( level.elevators ) )
        level.elevators = [];

    elevator = spawnstruct();
    elevator.name = elevatorname;
    elevator.body = undefined;
    level.elevators["bldg" + elevatorname] = elevator;
    piece = getent( "elevator_bldg" + elevatorname + "_body", "targetname" );
    piece setmovingplatformenabled( 1 );
    piece.is_moving = 0;

    if ( !isdefined( piece ) )
    {

        iprintlnbold( "Elevator with name: bldg" + elevatorname + " not found." );
        return;
    }

    trig = getent( "elevator_bldg" + elevatorname + "_trigger", "targetname" );

    if ( isdefined( trig ) )
    {
        trig enablelinkto();
        trig linkto( piece );
        trig setmovingplatformenabled( 1 );
        piece.trig = trig;
        piece thread elevator_roof_watcher();
    }

    elevator.body = piece;
    piece.is_elevator = 1;
    elevator.body perkelevatoruseanimtree();
    assert( isdefined( piece.script_location ) );
    elevator.body.current_level = piece.script_location;
    elevator.body.starting_floor = piece.script_location;
    elevator.body.elevator_switch = 0;
    elevator.roof_paths = elevator_path_nodes( "bldg" + elevatorname, "moving" );
    elevator.floors = [];
    elevator.floors[piece.script_location] = piece;
    elevator.floors[piece.script_location].starting_position = piece.origin;
    elevator.floors[piece.script_location].paths = elevator_path_nodes( "bldg" + elevatorname, "floor" + piece.script_location );

    while ( isdefined( piece.target ) )
    {
        piece = getstruct( piece.target, "targetname" );
        piece.is_elevator = 1;

        if ( !isdefined( elevator.floors[piece.script_location] ) )
        {
            elevator.floors[piece.script_location] = piece;
            elevator.floors[piece.script_location].paths = elevator_path_nodes( "bldg" + elevatorname, "floor" + piece.script_location );
        }
    }

    if ( elevatorname != "3c" )
        elevator.floors["" + elevator.floors.size] = elevator.floors["1"];

    if ( isdefined( force_starting_floor ) )
        elevator.body.force_starting_floor = force_starting_floor;

    if ( isdefined( force_starting_origin ) )
        elevator.body.force_starting_origin_offset = force_starting_origin;

    level thread elevator_think( elevator );
    level thread elevator_depart_early( elevator );
    level thread elevator_sparks_fx( elevator );

}


init()
{

	precacheshader( "faction_cdc" ); 
	precacheshader( "menu_mp_weapons_hamr" ); 
	precacheshader( "zombies_rank_5" );
	precacheshader( "hud_grenadeicon" );
	precacheshader( "specialty_instakill_zombies" );
	precacheshader( "menu_mp_weapons_1911" );
	precacheshader( "hud_icon_colt" );
	precachemodel("p6_zm_buildable_sq_meteor");
	precachemodel( "collision_player_wall_512x512x10" );
	precachemodel( "collision_physics_512x512x10" );
	precachemodel( "t5_foliage_tree_burnt03" );
	precachemodel( "p_rus_door_roller" );
	precachemodel( "ch_tombstone1" );
	precachemodel( "collision_geo_256x256x10_standard" );
	precachemodel( "specialty_divetonuke_zombies");
	precachemodel( "zombie_vending_tombstone_on" );
	precachemodel( "zombie_vending_revive_on" );
	precachemodel( "zombie_vending_sleight_on" );
	precachemodel( "zombie_vending_doubletap2_on" );
	precachemodel( "p6_zm_vending_vultureaid_on" );
	precachemodel( "zombie_vending_marathon_on" );
	precachemodel( "zombie_pickup_perk_bottle" );
	precachemodel( "zm_collision_perks1" );

    // Electric Cherry
    precacheitem( "zombie_perk_bottle_cherry" );
    precacheshader( "specialty_fastreload_zombies" );
    precachemodel( "p6_zm_vending_electric_cherry_off" );
    precachemodel( "p6_zm_vending_electric_cherry_on" );
    precachestring( &"ZM_PRISON_PERK_CHERRY" );
    level._effect["electriccherry"] = loadfx( "misc/fx_zombie_cola_on" );
    level._effect["electric_cherry_explode"] = loadfx( "maps/zombie_alcatraz/fx_alcatraz_electric_cherry_down" );
    level._effect["electric_cherry_reload_small"] = loadfx( "maps/zombie_alcatraz/fx_alcatraz_electric_cherry_sm" );
    level._effect["electric_cherry_reload_medium"] = loadfx( "maps/zombie_alcatraz/fx_alcatraz_electric_cherry_player" );
    level._effect["electric_cherry_reload_large"] = loadfx( "maps/zombie_alcatraz/fx_alcatraz_electric_cherry_lg" );
    level._effect["tesla_shock"] = loadfx( "maps/zombie/fx_zombie_tesla_shock" );
    level._effect["tesla_shock_secondary"] = loadfx( "maps/zombie/fx_zombie_tesla_shock_secondary" );

    // Vulture
    precacheitem( "zombie_perk_bottle_vulture" );
    precacheshader( "specialty_vulture_zombies" );
    precachestring( &"ZOMBIE_PERK_VULTURE" );
    precachemodel( "p6_zm_vending_vultureaid" );
    precachemodel( "p6_zm_vending_vultureaid_on" );
    precachemodel( "p6_zm_perk_vulture_ammo" );
    precachemodel( "p6_zm_perk_vulture_points" );
    level._effect["vulture_light"] = loadfx( "misc/fx_zombie_cola_jugg_on" );
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
    onplayerconnect_callback( ::vulture_player_connect_callback );

    // Deadshot
    precacheitem( "zombie_perk_bottle_deadshot" );
    precacheshader( "specialty_ads_zombies" );
    precachemodel( "p6_zm_al_vending_ads_on" );
    precachestring( &"ZOMBIE_PERK_DEADSHOT" );
    level._effect["deadshot_light"] = loadfx( "maps/zombie_alcatraz/fx_alcatraz_perk_smk" );
    level.machine_assets["deadshot"] = spawnstruct();
    level.machine_assets["deadshot"].weapon = "zombie_perk_bottle_deadshot";
    level.machine_assets["deadshot"].off_model = "p6_zm_al_vending_ads_on";
    level.machine_assets["deadshot"].on_model = "p6_zm_al_vending_ads_on";

    // PhD Flopper
    precacheitem( "zombie_perk_bottle_nuke" );
    precacheshader( "specialty_divetonuke_zombies" );
    precachemodel( "p6_zm_al_vending_nuke_on" );
    precachestring( &"ZOMBIE_PERK_DIVETONUKE" );
    level._effect["divetonuke_light"] = loadfx( "maps/zombie_alcatraz/fx_alcatraz_perk_smk" );
    level.machine_assets["divetonuke"] = spawnstruct();
    level.machine_assets["divetonuke"].weapon = "zombie_perk_bottle_nuke";
    level.machine_assets["divetonuke"].off_model = "p6_zm_al_vending_nuke_on";
    level.machine_assets["divetonuke"].on_model = "p6_zm_al_vending_nuke_on";
    
    level._effect["fx_zm_nuked_exp_perk_impact_int_shockwave"] = loadfx( "explosions/fx_zm_nuked_exp_perk_impact_int_shockwave" );

	level.effect_WebFX = loadfx("misc/fx_zombie_powerup_solo_grab");
	if (  getdvar("mapname") == "zm_buried" || getdvar("mapname") == "zm_tomb"  ) {
		level._effect["fx_default_explosion"] = level._effect["divetonuke_groundhit"];
	} else {
		level._effect["fx_default_explosion"] = loadfx( "explosions/fx_default_explosion" );
	}
	
	level thread onPlayerConnect();
	init_custom_map(); 
   
	level.player_out_of_playable_area_monitor = 0;
	level.perk_purchase_limit = 50;


}


onPlayerConnect()
{
	while ( 1 )
	{
		level waittill( "connected", player);
		player thread onPlayerSpawned();

	}
}

onPlayerSpawned()
{
	self endon( "disconnect" );
	level endon( "game_ended" );
	for(;;)
	{
		self waittill( "spawned_player" );
		self.coinsfound = [];
		self.perkarray = [];
		self.dying_wish_on_cooldown = 0;
		self.thunder_wall_on_cooldown = 0;
		self.rampage_on_cooldown = 0;
		self.rampage = 0;
		self.GS_on_cooldown = 0;
		self.perk_reminder = 0;
		self.perk_count = 0;
		self.num_perks = 0;
		
	}
}

spawn_electric_c( origin, angle, elevator)
{
    use_trigger = spawn( "trigger_radius_use", origin + vectorscale( ( 0, 0, 1 ), 30.0 ), 0, 40, 70 );
    use_trigger.targetname = "zombie_vending";
    use_trigger.script_noteworthy = "specialty_grenadepulldeath";
    use_trigger triggerignoreteam();
    perk_machine = spawn( "script_model", origin );
    perk_machine.angles = angle;
    perk_machine setmodel( "p6_zm_vending_electric_cherry_on" );

    if ( isdefined( level._no_vending_machine_bump_trigs ) && level._no_vending_machine_bump_trigs )
        bump_trigger = undefined;
    else
    {
        bump_trigger = spawn( "trigger_radius", origin, 0, 35, 64 );
        bump_trigger.script_activated = 1;
        bump_trigger.script_sound = "zmb_perks_bump_bottle";
        bump_trigger.targetname = "audio_bump_trigger";

        bump_trigger thread thread_bump_trigger();
    }

    collision = spawn( "script_model", origin, 1 );
    collision.angles = angle;
    collision setmodel( "zm_collision_perks1" );
    collision.script_noteworthy = "clip";
    collision disconnectpaths();
    use_trigger.clip = collision;
    use_trigger.machine = perk_machine;
    use_trigger.bump = bump_trigger;

    perk_machine.turn_on_notify = "electric_cherry_on";

	use_trigger.script_sound = "mus_perks_cherry_jingle";
    use_trigger.script_string = "electric_cherry_perk";
    use_trigger.script_label = "mus_perks_cherry_sting";
    use_trigger.target = "vending_electriccherry";
    perk_machine.script_string = "electriccherry_perk";
    perk_machine.targetname = "vendingelectric_cherry";

    if ( isdefined( bump_trigger ) )
        bump_trigger.script_string = "electriccherry_perk";

    //perk_machine linkto( elevator );
    level.custom_electric_trigger = use_trigger;
    return perk_machine;

}

spawn_vulture_aid( origin, angle, elevator)
{
    use_trigger = spawn( "trigger_radius_use", origin + vectorscale( ( 0, 0, 1 ), 30.0 ), 0, 40, 70 );
    use_trigger.targetname = "zombie_vending";
    use_trigger.script_noteworthy = "specialty_nomotionsensor";
    use_trigger triggerignoreteam();
    perk_machine = spawn( "script_model", origin );
    perk_machine.angles = angle;
    perk_machine setmodel( "p6_zm_vending_vultureaid" );

    if ( isdefined( level._no_vending_machine_bump_trigs ) && level._no_vending_machine_bump_trigs )
        bump_trigger = undefined;
    else
    {
        bump_trigger = spawn( "trigger_radius", origin, 0, 35, 64 );
        bump_trigger.script_activated = 1;
        bump_trigger.script_sound = "zmb_perks_bump_bottle";
        bump_trigger.targetname = "audio_bump_trigger";

        bump_trigger thread thread_bump_trigger();
    }

    collision = spawn( "script_model", origin, 1 );
    collision.angles = angle;
    collision setmodel( "zm_collision_perks1" );
    collision.script_noteworthy = "clip";
    collision disconnectpaths();
    use_trigger.clip = collision;
    use_trigger.machine = perk_machine;
    use_trigger.bump = bump_trigger;

    use_trigger.script_sound = "mus_perks_vulture_jingle";
    use_trigger.script_string = "vulture_perk";
    use_trigger.script_label = "mus_perks_vulture_sting";
    use_trigger.target = "vending_vulture";
    perk_machine.script_string = "vulture_perk";
    perk_machine.targetname = "vending_vulture";

    if ( isdefined( bump_trigger ) )
        bump_trigger.script_string = "vulture_perk";

    //perk_machine linkto( elevator );
    level.custom_vulture_aid_trigger = use_trigger;
    return perk_machine;

}

spawn_deadshot( origin, angle, elevator)
{
    use_trigger = spawn( "trigger_radius_use", origin + vectorscale( ( 0, 0, 1 ), 30.0 ), 0, 40, 70 );
    use_trigger.targetname = "zombie_vending";
    use_trigger.script_noteworthy = "specialty_deadshot";
    use_trigger triggerignoreteam();
    perk_machine = spawn( "script_model", origin );
    perk_machine.angles = angle;
    perk_machine setmodel( "p6_zm_al_vending_ads_off" );

    if ( isdefined( level._no_vending_machine_bump_trigs ) && level._no_vending_machine_bump_trigs )
        bump_trigger = undefined;
    else
    {
        bump_trigger = spawn( "trigger_radius", origin, 0, 35, 64 );
        bump_trigger.script_activated = 1;
        bump_trigger.script_sound = "zmb_perks_bump_bottle";
        bump_trigger.targetname = "audio_bump_trigger";

        bump_trigger thread thread_bump_trigger();
    }

    collision = spawn( "script_model", origin, 1 );
    collision.angles = angle;
    collision setmodel( "zm_collision_perks1" );
    collision.script_noteworthy = "clip";
    collision disconnectpaths();
    use_trigger.clip = collision;
    use_trigger.machine = perk_machine;
    use_trigger.bump = bump_trigger;

    perk_machine.turn_on_notify = "deadshot_on";

    use_trigger.script_sound = "mus_perks_deadshot_jingle";
    use_trigger.script_string = "deadshot_perk";
    use_trigger.script_label = "mus_perks_deadshot_sting";
    use_trigger.target = "vending_deadshot";
    perk_machine.script_string = "deadshot_vending";
    perk_machine.targetname = "vending_deadshot_model";
     if ( isdefined( bump_trigger ) )
         bump_trigger.script_string = "deadshot_vending";


    //perk_machine linkto( elevator );
    level.custom_deadshot_trigger = use_trigger;
    return perk_machine;

}

spawn_phd_flopper( origin, angle, elevator)
{
    use_trigger = spawn( "trigger_radius_use", origin + vectorscale( ( 0, 0, 1 ), 30.0 ), 0, 40, 70 );
    use_trigger.targetname = "zombie_vending";
    use_trigger.script_noteworthy = "specialty_flakjacket";
    use_trigger triggerignoreteam();
    perk_machine = spawn( "script_model", origin );
    perk_machine.angles = angle;
    perk_machine setmodel( "p6_zm_al_vending_nuke_on" );

    if ( isdefined( level._no_vending_machine_bump_trigs ) && level._no_vending_machine_bump_trigs )
        bump_trigger = undefined;
    else
    {
        bump_trigger = spawn( "trigger_radius", origin, 0, 35, 64 );
        bump_trigger.script_activated = 1;
        bump_trigger.script_sound = "zmb_perks_bump_bottle";
        bump_trigger.targetname = "audio_bump_trigger";

        bump_trigger thread thread_bump_trigger();
    }

    collision = spawn( "script_model", origin, 1 );
    collision.angles = angle;
    collision setmodel( "zm_collision_perks1" );
    collision.script_noteworthy = "clip";
    collision disconnectpaths();
    use_trigger.clip = collision;
    use_trigger.machine = perk_machine;
    use_trigger.bump = bump_trigger;

    perk_machine.turn_on_notify = "divetonuke_on";

    use_trigger.script_sound = "mus_perks_phd_jingle";
    use_trigger.script_string = "divetonuke_perk";
    use_trigger.script_label = "mus_perks_phd_sting";
    use_trigger.target = "vending_divetonuke";
    perk_machine.script_string = "divetonuke_perk";
    perk_machine.targetname = "vending_divetonuke";

    if ( isdefined( bump_trigger ) )
        bump_trigger.script_string = "divetonuke_perk";

    //perk_machine linkto( elevator );
    level.custom_phd_flopper_trigger = use_trigger;
    return perk_machine;

}



// buy_system( perk, sound, name, cost, type, bottle)
// {
//     self endon( "game_ended" );
//     while( 1 )
//     {
//         foreach( player in level.players )
//         {
//             if(!player.machine_is_in_use)
// 			{
//                 if( distance( self.origin, player.origin ) <= 70 && !player hasperk(perk) && !player hascustomperk(perk))
//                 {
// 				    player thread SpawnHint( self.origin, 30, 30, "HINT_ACTIVATE", "Hold ^3&&1^7 for " + name + " [Cost: " + cost + "]" );
//                     if(player usebuttonpressed() && !player hasperk(perk) && !player hascustomperk(perk) && player.score >= cost && !player maps\mp\zombies\_zm_laststand::player_is_in_laststand())
//                     {
//                         player.machine_is_in_use = 1;
//                         player playsound( "zmb_cha_ching" );
//                         player.score -= cost;
//                         player playsound( sound );
// 			    	    player thread drawshader_and_shadermove( perk, 1, 1, bottle );
// 						wait 4;
//                     	player.machine_is_in_use = 0;
// 					}
// 					else
//                     {
//                         if( player usebuttonpressed() && player.score < cost )
//                         {
//                             player maps\mp\zombies\_zm_audio::create_and_play_dialog( "general", "perk_deny", undefined, 0 );
//                         }
//                     }
//                 }
//             }	
//         }
//         wait 0.1;
//     }
// }

doGivePerk(perk)
{
    self endon("disconnect");
    self endon("death");
    level endon("game_ended");
    self endon("perk_abort_drinking");
    if (!(self hasperk(perk) || (self maps\mp\zombies\_zm_perks::has_perk_paused(perk))))
    {
        gun = self maps\mp\zombies\_zm_perks::perk_give_bottle_begin(perk);
        evt = self waittill_any_return("fake_death", "death", "player_downed", "weapon_change_complete");
        if (evt == "weapon_change_complete")
            self thread maps\mp\zombies\_zm_perks::wait_give_perk(perk, 1);
        self maps\mp\zombies\_zm_perks::perk_give_bottle_end(gun, perk);
        if (self maps\mp\zombies\_zm_laststand::player_is_in_laststand() || isDefined(self.intermission) && self.intermission)
            return;
        self notify("burp");
    }
}

func_RemoveAllPerks()
{
    self notify("specialty_armorvest_stop");
    self notify("specialty_fastreload_stop");
    self notify("specialty_quickrevive_stop");
    self notify("specialty_rof_stop");
    self notify("specialty_longersprint_stop");
    self notify("specialty_additionalprimaryweapon_stop");
    self notify("specialty_deadshot_stop");
    self notify("specialty_scavenger_stop");
    self notify("specialty_flakjacket_stop");
    self notify("specialty_nomotionsensor_stop");
    self notify("specialty_grenadepulldeath_stop");
    self notify("specialty_finalstand_stop");
    self iprintln("All Perks ^1Removed");
}

doGetposition() 
{
	self endon ("disconnect"); 
	self endon ("death"); 
	print_pos = 1;
	if (print_pos==1)
	{
		for(;;)
		{
			self.corrected_angles = corrected_angles(self.angles);
			self iPrintln("Angles: "+self.corrected_angles+"\nPosition: "+self.origin);
			wait 0.5;
		}
	}
}

corrected_angles(angles)
{
	angles = angles + (0, 90, 0);
	if (angles[1] < 0)
	{
		angles = angles + (0, 360, 0);
	}
	return angles;
}

perk_machine_spawn_init_override()
{
    match_string = "";
    location = level.scr_zm_map_start_location;

    if ( ( location == "default" || location == "" ) && isdefined( level.default_start_location ) )
        location = level.default_start_location;

    match_string = level.scr_zm_ui_gametype + "_perks_" + location;
    pos = [];

    if ( isdefined( level.override_perk_targetname ) )
        structs = getstructarray( level.override_perk_targetname, "targetname" );
    else
        structs = getstructarray( "zm_perk_machine", "targetname" );

    foreach ( struct in structs )
    {
        if ( isdefined( struct.script_string ) )
        {
            tokens = strtok( struct.script_string, " " );

            foreach ( token in tokens )
            {
                if ( token == match_string )
                    pos[pos.size] = struct;
            }

            continue;
        }

        pos[pos.size] = struct;
    }

    if ( !isdefined( pos ) || pos.size == 0 )
        return;

    precachemodel( "zm_collision_perks1" );

    for ( i = 0; i < pos.size; i++ )
    {
        perk = pos[i].script_noteworthy;

        if ( isdefined( perk ) && isdefined( pos[i].model ) )
        {
            use_trigger = spawn( "trigger_radius_use", pos[i].origin + vectorscale( ( 0, 0, 1 ), 30.0 ), 0, 40, 70 );
            use_trigger.targetname = "zombie_vending";
            use_trigger.script_noteworthy = perk;
            use_trigger triggerignoreteam();
            perk_machine = spawn( "script_model", pos[i].origin );
            perk_machine.angles = pos[i].angles;
            perk_machine setmodel( pos[i].model );

            if ( isdefined( level._no_vending_machine_bump_trigs ) && level._no_vending_machine_bump_trigs )
                bump_trigger = undefined;
            else
            {
                bump_trigger = spawn( "trigger_radius", pos[i].origin, 0, 35, 64 );
                bump_trigger.script_activated = 1;
                bump_trigger.script_sound = "zmb_perks_bump_bottle";
                bump_trigger.targetname = "audio_bump_trigger";

                if ( perk != "specialty_weapupgrade" )
                    bump_trigger thread thread_bump_trigger();
            }

            collision = spawn( "script_model", pos[i].origin, 1 );
            collision.angles = pos[i].angles;
            collision setmodel( "zm_collision_perks1" );
            collision.script_noteworthy = "clip";
            collision disconnectpaths();
            use_trigger.clip = collision;
            use_trigger.machine = perk_machine;
            use_trigger.bump = bump_trigger;

            if ( isdefined( pos[i].blocker_model ) )
                use_trigger.blocker_model = pos[i].blocker_model;

            if ( isdefined( pos[i].script_int ) )
                perk_machine.script_int = pos[i].script_int;

            if ( isdefined( pos[i].turn_on_notify ) )
                perk_machine.turn_on_notify = pos[i].turn_on_notify;

            switch ( perk )
            {
                case "specialty_quickrevive_upgrade":
                case "specialty_quickrevive":
                    use_trigger.script_sound = "mus_perks_revive_jingle";
                    use_trigger.script_string = "revive_perk";
                    use_trigger.script_label = "mus_perks_revive_sting";
                    use_trigger.target = "vending_revive";
                    perk_machine.script_string = "revive_perk";
                    perk_machine.targetname = "vending_revive";

                    if ( isdefined( bump_trigger ) )
                        bump_trigger.script_string = "revive_perk";

                    break;
                case "specialty_fastreload_upgrade":
                case "specialty_fastreload":
                    use_trigger.script_sound = "mus_perks_speed_jingle";
                    use_trigger.script_string = "speedcola_perk";
                    use_trigger.script_label = "mus_perks_speed_sting";
                    use_trigger.target = "vending_sleight";
                    perk_machine.script_string = "speedcola_perk";
                    perk_machine.targetname = "vending_sleight";

                    if ( isdefined( bump_trigger ) )
                        bump_trigger.script_string = "speedcola_perk";

                    break;
                case "specialty_longersprint_upgrade":
                case "specialty_longersprint":
                    use_trigger.script_sound = "mus_perks_stamin_jingle";
                    use_trigger.script_string = "marathon_perk";
                    use_trigger.script_label = "mus_perks_stamin_sting";
                    use_trigger.target = "vending_marathon";
                    perk_machine.script_string = "marathon_perk";
                    perk_machine.targetname = "vending_marathon";

                    if ( isdefined( bump_trigger ) )
                        bump_trigger.script_string = "marathon_perk";

                    break;
                case "specialty_armorvest_upgrade":
                case "specialty_armorvest":
                    use_trigger.script_sound = "mus_perks_jugganog_jingle";
                    use_trigger.script_string = "jugg_perk";
                    use_trigger.script_label = "mus_perks_jugganog_sting";
                    use_trigger.longjinglewait = 1;
                    use_trigger.target = "vending_jugg";
                    perk_machine.script_string = "jugg_perk";
                    perk_machine.targetname = "vending_jugg";

                    if ( isdefined( bump_trigger ) )
                        bump_trigger.script_string = "jugg_perk";

                    break;
                case "specialty_scavenger_upgrade":
                case "specialty_scavenger":
                    use_trigger.script_sound = "mus_perks_tombstone_jingle";
                    use_trigger.script_string = "tombstone_perk";
                    use_trigger.script_label = "mus_perks_tombstone_sting";
                    use_trigger.target = "vending_tombstone";
                    perk_machine.script_string = "tombstone_perk";
                    perk_machine.targetname = "vending_tombstone";

                    if ( isdefined( bump_trigger ) )
                        bump_trigger.script_string = "tombstone_perk";

                    break;
                case "specialty_rof_upgrade":
                case "specialty_rof":
                    use_trigger.script_sound = "mus_perks_doubletap_jingle";
                    use_trigger.script_string = "tap_perk";
                    use_trigger.script_label = "mus_perks_doubletap_sting";
                    use_trigger.target = "vending_doubletap";
                    perk_machine.script_string = "tap_perk";
                    perk_machine.targetname = "vending_doubletap";

                    if ( isdefined( bump_trigger ) )
                        bump_trigger.script_string = "tap_perk";

                    break;
                case "specialty_finalstand_upgrade":
                case "specialty_finalstand":
                    use_trigger.script_sound = "mus_perks_whoswho_jingle";
                    use_trigger.script_string = "tap_perk";
                    use_trigger.script_label = "mus_perks_whoswho_sting";
                    use_trigger.target = "vending_chugabud";
                    perk_machine.script_string = "tap_perk";
                    perk_machine.targetname = "vending_chugabud";

                    if ( isdefined( bump_trigger ) )
                        bump_trigger.script_string = "tap_perk";

                    break;
                case "specialty_additionalprimaryweapon_upgrade":
                case "specialty_additionalprimaryweapon":
                    use_trigger.script_sound = "mus_perks_mulekick_jingle";
                    use_trigger.script_string = "tap_perk";
                    use_trigger.script_label = "mus_perks_mulekick_sting";
                    use_trigger.target = "vending_additionalprimaryweapon";
                    perk_machine.script_string = "tap_perk";
                    perk_machine.targetname = "vending_additionalprimaryweapon";

                    if ( isdefined( bump_trigger ) )
                        bump_trigger.script_string = "tap_perk";

                    break;
                case "specialty_weapupgrade":
                    use_trigger.target = "vending_packapunch";
                    use_trigger.script_sound = "mus_perks_packa_jingle";
                    use_trigger.script_label = "mus_perks_packa_sting";
                    use_trigger.longjinglewait = 1;
                    perk_machine.targetname = "vending_packapunch";
                    flag_pos = getstruct( pos[i].target, "targetname" );

                    if ( isdefined( flag_pos ) )
                    {
                        perk_machine_flag = spawn( "script_model", flag_pos.origin );
                        perk_machine_flag.angles = flag_pos.angles;
                        perk_machine_flag setmodel( flag_pos.model );
                        perk_machine_flag.targetname = "pack_flag";
                        perk_machine.target = "pack_flag";
                    }

                    if ( isdefined( bump_trigger ) )
                        bump_trigger.script_string = "perks_rattle";

                    break;
                case "specialty_deadshot_upgrade":
                case "specialty_deadshot":
                    use_trigger.script_sound = "mus_perks_deadshot_jingle";
                    use_trigger.script_string = "deadshot_perk";
                    use_trigger.script_label = "mus_perks_deadshot_sting";
                    use_trigger.target = "vending_deadshot";
                    perk_machine.script_string = "deadshot_vending";
                    perk_machine.targetname = "vending_deadshot_model";

                    if ( isdefined( bump_trigger ) )
                        bump_trigger.script_string = "deadshot_vending";

                    break;
                default:
                    use_trigger.script_sound = "mus_perks_speed_jingle";
                    use_trigger.script_string = "speedcola_perk";
                    use_trigger.script_label = "mus_perks_speed_sting";
                    use_trigger.target = "vending_sleight";
                    perk_machine.script_string = "speedcola_perk";
                    perk_machine.targetname = "vending_sleight";

                    if ( isdefined( bump_trigger ) )
                        bump_trigger.script_string = "speedcola_perk";

                    break;
            }

            if ( isdefined( level._custom_perks[perk] ) && isdefined( level._custom_perks[perk].perk_machine_set_kvps ) )
                [[ level._custom_perks[perk].perk_machine_set_kvps ]]( use_trigger, perk_machine, bump_trigger, collision );
        }
    }
}

init_custom_map()
{
	if (getdvar( "mapname" ) == "zm_prison") //MOTD
	{
		return;
	}
	else if (getdvar( "mapname" ) == "zm_highrise") //Die rise 
	{
		//perk_system( "script_model", (1483.35, 1568.57, 3391.57), "p6_zm_vending_electric_cherry_on", (0, 0.726334, 0), "custom", "mus_perks_sleight_sting", "Electric Cherry", 3000, "revive_light", "ELECTRIC_CHERRY","zombie_perk_bottle_jugg" );
        //perk_system( "script_model", (1546.26, 1581.86, 3399.77), "p6_zm_al_vending_ads_on", (0, 355.292, 0), "custom", "mus_perks_sleight_sting", "Deadshot Daiquiri", 3000, "revive_light", "DEADSHOT","zombie_perk_bottle_deadshot" );
        //spawn_electric_c((1483.35, 1568.57, 3391.57), (0, 0.726334, 0));
        //perk_system( "script_model", (1408.76, 1581.86, 3392.13), "p6_zm_al_vending_nuke_on", (0, 358.595, 0), "custom", "mus_perks_sleight_sting", "Deadshot Daiquiri", 3000, "revive_light", "DEADSHOT","zombie_perk_bottle_nuke" );
	}


	else if( getdvar( "mapname" ) == "zm_transit" && getdvar( "g_gametype" ) == "zstandard")
	{
		return;
	}

	else if (getdvar("mapname") == "zm_buried")
	{
		return;
	}
		
	else if (getdvar( "mapname" ) == "zm_nuked") 
	{	
		
		return;
	}
	else if (getdvar( "mapname" ) == "zm_tomb") //Origins
	{
		return;
	}
	else if (getdvar("mapname") == "zm_transit" && getdvar( "g_gametype" )=="zclassic") //TranZit
	{
		return;
	}
}

drawshader_and_shadermove(perk, custom, print, bottle)
{
    if(custom)
	{
        self allowProne(false);
        self allowSprint(true);
        self disableoffhandweapons();
        self disableweaponcycling();
        weapona = self getcurrentweapon();
        weaponb = bottle;
        self giveweapon( weaponb );
        self switchtoweapon( weaponb );
        self waittill( "weapon_change_complete" );
        self enableoffhandweapons();
        self enableweaponcycling();
        self takeweapon( weaponb );
        self switchtoweapon( weapona );
        self maps\mp\zombies\_zm_audio::playerexert( "burp" );
        self setblur( 4, 0.1 );
        wait 0.1;
        self setblur( 0, 0.1 );
        self allowProne(true);
    }
    x = -408 + (self.perk_count * 30);
	if (getdvar("mapname")=="zm_buried" || getdvar("mapname") == "zm_tomb")
	{
		y = 320;
	}
	else
	{
		y = 350;
	}
	
    for(i = 0; i < self.perkarray.size; i++)
	{
    	self.perkarray[i].x = self.perkarray[i].x + 30;
	}

}


perks_register_clientfield_override()
{
    if ( isdefined( level.zombiemode_using_additionalprimaryweapon_perk ) && level.zombiemode_using_additionalprimaryweapon_perk )
        registerclientfield( "toplayer", "perk_additional_primary_weapon", 1, 2, "int" );

    if ( isdefined( level.zombiemode_using_deadshot_perk ) && level.zombiemode_using_deadshot_perk )
        registerclientfield( "toplayer", "perk_dead_shot", 1, 2, "int" );

    if ( isdefined( level.zombiemode_using_doubletap_perk ) && level.zombiemode_using_doubletap_perk )
        registerclientfield( "toplayer", "perk_double_tap", 1, 2, "int" );

    if ( isdefined( level.zombiemode_using_juggernaut_perk ) && level.zombiemode_using_juggernaut_perk )
        registerclientfield( "toplayer", "perk_juggernaut", 1, 2, "int" );

    if ( isdefined( level.zombiemode_using_marathon_perk ) && level.zombiemode_using_marathon_perk )
        registerclientfield( "toplayer", "perk_marathon", 1, 2, "int" );

    if ( isdefined( level.zombiemode_using_revive_perk ) && level.zombiemode_using_revive_perk )
        registerclientfield( "toplayer", "perk_quick_revive", 1, 2, "int" );

    if ( isdefined( level.zombiemode_using_sleightofhand_perk ) && level.zombiemode_using_sleightofhand_perk )
        registerclientfield( "toplayer", "perk_sleight_of_hand", 1, 2, "int" );

    if ( isdefined( level.zombiemode_using_tombstone_perk ) && level.zombiemode_using_tombstone_perk )
        registerclientfield( "toplayer", "perk_tombstone", 1, 2, "int" );

    if ( isdefined( level.zombiemode_using_perk_intro_fx ) && level.zombiemode_using_perk_intro_fx )
        registerclientfield( "scriptmover", "clientfield_perk_intro_fx", 1000, 1, "int" );

    if ( isdefined( level.zombiemode_using_chugabud_perk ) && level.zombiemode_using_chugabud_perk )
        registerclientfield( "toplayer", "perk_chugabud", 1000, 1, "int" );

    if ( isdefined( level._custom_perks ) )
    {
        a_keys = getarraykeys( level._custom_perks );

        for ( i = 0; i < a_keys.size; i++ )
        {
            if ( isdefined( level._custom_perks[a_keys[i]].clientfield_register ) )
                level [[ level._custom_perks[a_keys[i]].clientfield_register ]]();
        }
    }
}

enable_vulture_perk_for_level()
{
    maps\mp\zombies\_zm_perks::register_perk_basic_info( "specialty_nomotionsensor", "vulture", 3000, &"ZOMBIE_PERK_VULTURE", "zombie_perk_bottle_vulture" );
    maps\mp\zombies\_zm_perks::register_perk_precache_func( "specialty_nomotionsensor", ::vulture_precache );
    maps\mp\zombies\_zm_perks::register_perk_clientfields( "specialty_nomotionsensor", ::vulture_register_clientfield, ::vulture_set_clientfield );
    maps\mp\zombies\_zm_perks::register_perk_threads( "specialty_nomotionsensor", ::give_vulture_perk, ::take_vulture_perk );
    maps\mp\zombies\_zm_perks::register_perk_machine( "specialty_nomotionsensor", ::vulture_perk_machine_setup, ::vulture_perk_machine_think );
    maps\mp\zombies\_zm_perks::register_perk_host_migration_func( "specialty_nomotionsensor", ::vulture_host_migration_func );
}

vulture_precache()
{
    precacheitem( "zombie_perk_bottle_vulture" );
    precacheshader( "specialty_vulture_zombies" );
    precachestring( &"ZOMBIE_PERK_VULTURE" );
    precachemodel( "p6_zm_vending_vultureaid" );
    precachemodel( "p6_zm_vending_vultureaid_on" );
    precachemodel( "p6_zm_perk_vulture_ammo" );
    precachemodel( "p6_zm_perk_vulture_points" );
    level._effect["vulture_light"] = loadfx( "misc/fx_zombie_cola_jugg_on" );
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
    onplayerconnect_callback( ::vulture_player_connect_callback );
}

vulture_player_connect_callback()
{
    self thread end_game_turn_off_vulture_overlay();
}

end_game_turn_off_vulture_overlay()
{
    self endon( "disconnect" );
    level waittill( "end_game" );
    self thread take_vulture_perk();
}

init_vulture()
{
    setdvarint( "zombies_perk_vulture_pickup_time", 12 );
    setdvarint( "zombies_perk_vulture_pickup_time_stink", 16 );
    setdvarint( "zombies_perk_vulture_drop_chance", 65 );
    setdvarint( "zombies_perk_vulture_ammo_chance", 33 );
    setdvarint( "zombies_perk_vulture_points_chance", 33 );
    setdvarint( "zombies_perk_vulture_stink_chance", 33 );
    setdvarint( "zombies_perk_vulture_drops_max", 20 );
    setdvarint( "zombies_perk_vulture_network_drops_max", 5 );
    setdvarint( "zombies_perk_vulture_network_time_frame", 250 );
    setdvarint( "zombies_perk_vulture_spawn_stink_zombie_cooldown", 12 );
    setdvarint( "zombies_perk_vulture_max_stink_zombies", 4 );
    level.perk_vulture = spawnstruct();
    level.perk_vulture.zombie_stink_array = [];
    level.perk_vulture.drop_time_last = 0;
    level.perk_vulture.drop_slots_for_network = 0;
    level.perk_vulture.last_stink_zombie_spawned = 0;
    level.perk_vulture.use_exit_behavior = 0;
    level.perk_vulture.clientfields = spawnstruct();
    level.perk_vulture.clientfields.scriptmovers = [];
    level.perk_vulture.clientfields.scriptmovers["vulture_stink_fx"] = 0;
    level.perk_vulture.clientfields.scriptmovers["vulture_drop_fx"] = 1;
    level.perk_vulture.clientfields.scriptmovers["vulture_drop_pickup"] = 2;
    level.perk_vulture.clientfields.scriptmovers["vulture_powerup_drop"] = 3;
    level.perk_vulture.clientfields.actors = [];
    level.perk_vulture.clientfields.actors["vulture_stink_trail_fx"] = 0;
    level.perk_vulture.clientfields.actors["vulture_eye_glow"] = 1;
    level.perk_vulture.clientfields.toplayer = [];
    level.perk_vulture.clientfields.toplayer["vulture_perk_active"] = 0;
    registerclientfield( "toplayer", "vulture_perk_toplayer", 12000, 1, "int" );
    registerclientfield( "actor", "vulture_perk_actor", 12000, 2, "int" );
    registerclientfield( "scriptmover", "vulture_perk_scriptmover", 12000, 4, "int" );
    registerclientfield( "zbarrier", "vulture_perk_zbarrier", 12000, 1, "int" );
    registerclientfield( "toplayer", "sndVultureStink", 12000, 1, "int" );
    registerclientfield( "world", "vulture_perk_disable_solo_quick_revive_glow", 12000, 1, "int" );
    registerclientfield( "toplayer", "vulture_perk_disease_meter", 12000, 5, "float" );
    maps\mp\_visionset_mgr::vsmgr_register_info( "overlay", "vulture_stink_overlay", 12000, 120, 31, 1 );
    maps\mp\zombies\_zm_spawner::add_cusom_zombie_spawn_logic( ::vulture_zombie_spawn_func );
    register_zombie_death_event_callback( ::zombies_drop_stink_on_death );
    level thread vulture_perk_watch_mystery_box();
    level thread vulture_perk_watch_fire_sale();
    level thread vulture_perk_watch_powerup_drops();
    level thread vulture_handle_solo_quick_revive();
    assert( !isdefined( level.exit_level_func ), "vulture perk is attempting to use level.exit_level_func, but one already exists for this level!" );
    level.exit_level_func = ::vulture_zombies_find_exit_point;
    level.perk_vulture.invalid_bonus_ammo_weapons = array( "time_bomb_zm", "time_bomb_detonator_zm" );

    if ( !isdefined( level.perk_vulture.func_zombies_find_valid_exit_locations ) )
        level.perk_vulture.func_zombies_find_valid_exit_locations = ::get_valid_exit_points_for_zombie;

    setup_splitscreen_optimizations();
    initialize_bonus_entity_pool();
    initialize_stink_entity_pool();
/#
    level.vulture_devgui_spawn_stink = ::vulture_devgui_spawn_stink;
#/
}

add_additional_stink_locations_for_zone( str_zone, a_zones )
{
    if ( !isdefined( level.perk_vulture.zones_for_extra_stink_locations ) )
        level.perk_vulture.zones_for_extra_stink_locations = [];

    level.perk_vulture.zones_for_extra_stink_locations[str_zone] = a_zones;
}

vulture_register_clientfield()
{
    registerclientfield( "toplayer", "perk_vulture", 12000, 2, "int" );
}

vulture_set_clientfield( state )
{
    self setclientfieldtoplayer( "perk_vulture", state );
}

give_vulture_perk()
{
    vulture_debug_text( "player " + self getentitynumber() + " has vulture perk!" );

    if ( !isdefined( self.perk_vulture ) )
        self.perk_vulture = spawnstruct();

    self.perk_vulture.active = 1;
    self vulture_vision_toggle( 1 );
    self vulture_clientfield_toplayer_set( "vulture_perk_active" );
    self thread _vulture_perk_think();
}

take_vulture_perk()
{
    if ( isdefined( self.perk_vulture ) && ( isdefined( self.perk_vulture.active ) && self.perk_vulture.active ) )
    {
        vulture_debug_text( "player " + self getentitynumber() + " has lost vulture perk!" );
        self.perk_vulture.active = 0;

        if ( !self maps\mp\zombies\_zm_laststand::player_is_in_laststand() )
            self.ignoreme = 0;

        self vulture_vision_toggle( 0 );
        self vulture_clientfield_toplayer_clear( "vulture_perk_active" );
        self set_vulture_overlay( 0 );
        self.vulture_stink_value = 0;
        self setclientfieldtoplayer( "vulture_perk_disease_meter", 0 );
        self notify( "vulture_perk_lost" );
    }
}

vulture_host_migration_func()
{
    a_vulture_perk_machines = getentarray( "vending_vulture", "targetname" );

    foreach ( perk_machine in a_vulture_perk_machines )
    {
        if ( isdefined( perk_machine.model ) && perk_machine.model == "p6_zm_vending_vultureaid_on" )
        {
            perk_machine maps\mp\zombies\_zm_perks::perk_fx( undefined, 1 );
            perk_machine thread maps\mp\zombies\_zm_perks::perk_fx( "vulture_light" );
        }
    }

    foreach ( ent in level.perk_vulture.stink_ent_pool )
    {
        if ( isdefined( ent ) )
        {
            arrayremovevalue( level.perk_vulture.zombie_stink_array, ent, 0 );
            ent clear_stink_ent();
        }
    }

    foreach ( ent in level.perk_vulture.bonus_drop_ent_pool )
    {
        if ( isdefined( ent ) )
            ent clear_bonus_ent();
    }
}

vulture_perk_add_invalid_bonus_ammo_weapon( str_weapon )
{
    assert( isdefined( level.perk_vulture ), "vulture_perk_add_invalid_bonus_ammo_weapon() was called before vulture perk was initialized. Make sure this is called after the vulture perk initialization func!" );
    level.perk_vulture.invalid_bonus_ammo_weapons[level.perk_vulture.invalid_bonus_ammo_weapons.size] = str_weapon;
}

vulture_perk_machine_setup( use_trigger, perk_machine, bump_trigger, collision )
{
    use_trigger.script_sound = "mus_perks_vulture_jingle";
    use_trigger.script_string = "vulture_perk";
    use_trigger.script_label = "mus_perks_vulture_sting";
    use_trigger.target = "vending_vulture";
    perk_machine.script_string = "vulture_perk";
    perk_machine.targetname = "vending_vulture";
    bump_trigger.script_string = "vulture_perk";
}

vulture_perk_machine_think()
{
    init_vulture();

    while ( true )
    {
        machine = getentarray( "vending_vulture", "targetname" );
        machine_triggers = getentarray( "vending_vulture", "target" );
        array_thread( machine_triggers, maps\mp\zombies\_zm_perks::set_power_on, 0 );

        for ( i = 0; i < machine.size; i++ )
            machine[i] setmodel( "p6_zm_vending_vultureaid" );

        level waittill( "specialty_nomotionsensor" + "_on" );
        level notify( "specialty_nomotionsensor" + "_power_on" );

        for ( i = 0; i < machine.size; i++ )
        {
            machine[i] setmodel( "p6_zm_vending_vultureaid_on" );
            machine[i] vibrate( vectorscale( ( 0, -1, 0 ), 100.0 ), 0.3, 0.4, 3 );
            machine[i] playsound( "zmb_perks_power_on" );
            machine[i] thread maps\mp\zombies\_zm_perks::perk_fx( "vulture_light" );
            machine[i] thread maps\mp\zombies\_zm_perks::play_loop_on_machine();
        }

        array_thread( machine_triggers, maps\mp\zombies\_zm_perks::set_power_on, 1 );
        level waittill( "specialty_nomotionsensor" + "_off" );
        array_thread( machine, maps\mp\zombies\_zm_perks::turn_perk_off );
    }
}

do_vulture_death( player )
{
    if ( isdefined( self ) )
        self thread _do_vulture_death( player );
}

_do_vulture_death( player )
{
    if ( should_do_vulture_drop( self.origin ) )
    {
        str_bonus = get_vulture_drop_type();
        str_identifier = "_" + self getentitynumber() + "_" + gettime();
        v_drop_origin = groundtrace( self.origin + vectorscale( ( 0, 0, 1 ), 50.0 ), self.origin - vectorscale( ( 0, 0, -1 ), 100.0 ), 0, self )["position"];
        player thread show_debug_info( self.origin, str_identifier, str_bonus );
        self thread vulture_drop_funcs( self.origin, player, str_identifier, str_bonus );
    }
}

vulture_drop_funcs( v_origin, player, str_identifier, str_bonus )
{
    vulture_drop_count_increment();

    switch ( str_bonus )
    {
        case "ammo":
            e_temp = player _vulture_drop_model( str_identifier, "p6_zm_perk_vulture_ammo", v_origin, vectorscale( ( 0, 0, 1 ), 15.0 ) );
            self thread check_vulture_drop_pickup( e_temp, player, str_identifier, str_bonus );
            break;
        case "points":
            e_temp = player _vulture_drop_model( str_identifier, "p6_zm_perk_vulture_points", v_origin, vectorscale( ( 0, 0, 1 ), 15.0 ) );
            self thread check_vulture_drop_pickup( e_temp, player, str_identifier, str_bonus );
            break;
        case "stink":
            self _drop_zombie_stink( player, str_identifier, str_bonus );
            break;
    }
}

_drop_zombie_stink( player, str_identifier, str_bonus )
{
    self clear_zombie_stink_fx();
    e_temp = player zombie_drops_stink( self, str_identifier );
    e_temp = player _vulture_spawn_fx( str_identifier, self.origin, str_bonus, e_temp );
    clean_up_stink( e_temp );
}

zombie_drops_stink( ai_zombie, str_identifier )
{
    e_temp = ai_zombie.stink_ent;

    if ( isdefined( e_temp ) )
    {
        e_temp thread delay_showing_vulture_ent( self, ai_zombie.origin );
        level.perk_vulture.zombie_stink_array[level.perk_vulture.zombie_stink_array.size] = e_temp;
        self delay_notify( str_identifier, getdvarint( #"_id_DDE8D546" ) );
    }

    return e_temp;
}

delay_showing_vulture_ent( player, v_moveto_pos, str_model, func )
{
    self.drop_time = gettime();
    wait_network_frame();
    wait_network_frame();
    self.origin = v_moveto_pos;
    wait_network_frame();

    if ( isdefined( str_model ) )
        self setmodel( str_model );

    self show();

    if ( isplayer( player ) )
    {
        self setinvisibletoall();
        self setvisibletoplayer( player );
    }

    if ( isdefined( func ) )
        self [[ func ]]();
}

clean_up_stink( e_temp )
{
    e_temp vulture_clientfield_scriptmover_clear( "vulture_stink_fx" );
    arrayremovevalue( level.perk_vulture.zombie_stink_array, e_temp, 0 );
    wait 4;
    e_temp clear_stink_ent();
}

_delete_vulture_ent( n_delay )
{
    if ( !isdefined( n_delay ) )
        n_delay = 0;

    if ( n_delay > 0 )
    {
        self ghost();
        wait( n_delay );
    }

    self clear_bonus_ent();
}

_vulture_drop_model( str_identifier, str_model, v_model_origin, v_offset )
{
    if ( !isdefined( v_offset ) )
        v_offset = ( 0, 0, 0 );

    if ( !isdefined( self.perk_vulture_models ) )
        self.perk_vulture_models = [];

    e_temp = get_unused_bonus_ent();

    if ( !isdefined( e_temp ) )
    {
        self notify( str_identifier );
        return;
    }

    e_temp thread delay_showing_vulture_ent( self, v_model_origin + v_offset, str_model, ::set_vulture_drop_fx );
    self.perk_vulture_models[self.perk_vulture_models.size] = e_temp;
    e_temp setinvisibletoall();
    e_temp setvisibletoplayer( self );
    e_temp thread _vulture_drop_model_thread( str_identifier, self );
    return e_temp;
}

set_vulture_drop_fx()
{
    self vulture_clientfield_scriptmover_set( "vulture_drop_fx" );
}

_vulture_drop_model_thread( str_identifier, player )
{
    self thread _vulture_model_blink_timeout( player );
    player waittill_any( str_identifier, "death_or_disconnect", "vulture_perk_lost" );
    self vulture_clientfield_scriptmover_clear( "vulture_drop_fx" );
    n_delete_delay = 0.1;

    if ( isdefined( self.picked_up ) && self.picked_up )
    {
        self _play_vulture_drop_pickup_fx();
        n_delete_delay = 1;
    }

    if ( isdefined( player.perk_vulture_models ) )
    {
        arrayremovevalue( player.perk_vulture_models, self, 0 );
        self.perk_vulture_models = remove_undefined_from_array( player.perk_vulture_models );
    }

    self _delete_vulture_ent( n_delete_delay );
}

_vulture_model_blink_timeout( player )
{
    self endon( "death" );
    player endon( "death" );
    player endon( "disconnect" );
    self endon( "stop_vulture_behavior" );
    n_time_total = getdvarint( #"_id_34FA67DE" );
    n_frames = n_time_total * 20;
    n_section = int( n_frames / 6 );
    n_flash_slow = n_section * 3;
    n_flash_medium = n_section * 4;
    n_flash_fast = n_section * 5;
    b_show = 1;
    i = 0;

    while ( i < n_frames )
    {
        if ( i < n_flash_slow )
            n_multiplier = n_flash_slow;
        else if ( i < n_flash_medium )
            n_multiplier = 10;
        else if ( i < n_flash_fast )
            n_multiplier = 5;
        else
            n_multiplier = 2;

        if ( b_show )
        {
            self show();
            self setinvisibletoall();
            self setvisibletoplayer( player );
        }
        else
            self ghost();

        b_show = !b_show;
        i = i + n_multiplier;
        wait( 0.05 * n_multiplier );
    }
}

_vulture_spawn_fx( str_identifier, v_fx_origin, str_bonus, e_temp )
{
    b_delete = 0;

    if ( !isdefined( e_temp ) )
    {
        e_temp = get_unused_bonus_ent();

        if ( !isdefined( e_temp ) )
        {
            self notify( str_identifier );
            return;
        }

        b_delete = 1;
    }

    e_temp thread delay_showing_vulture_ent( self, v_fx_origin, "tag_origin", ::clientfield_set_vulture_stink_enabled );

    if ( isplayer( self ) )
        self waittill_any( str_identifier, "disconnect", "vulture_perk_lost" );
    else
        self waittill( str_identifier );

    if ( b_delete )
        e_temp _delete_vulture_ent();

    return e_temp;
}

clientfield_set_vulture_stink_enabled()
{
    self vulture_clientfield_scriptmover_set( "vulture_stink_fx" );
}

should_do_vulture_drop( v_death_origin )
{
    b_is_inside_playable_area = check_point_in_enabled_zone( v_death_origin, 1 );
    b_ents_are_available = get_unused_bonus_ent_count() > 0;
    b_network_slots_available = level.perk_vulture.drop_slots_for_network < getdvarint( #"_id_1786213A" );
    n_roll = randomint( 100 );
    b_passed_roll = n_roll > 100 - getdvarint( #"_id_70E3B3FA" );
    b_is_stink_zombie = isdefined( self.is_stink_zombie ) && self.is_stink_zombie;
    b_should_drop = b_is_stink_zombie || b_is_inside_playable_area && b_ents_are_available && b_network_slots_available && b_passed_roll;
    return b_should_drop;
}

get_vulture_drop_type()
{
    n_chance_ammo = getdvarint( #"_id_F75E07AF" );
    n_chance_points = getdvarint( #"_id_D7BCDBE2" );
    n_chance_stink = getdvarint( #"_id_4918C38E" );
    n_total_weight = n_chance_ammo + n_chance_points;
    n_cutoff_ammo = n_chance_ammo;
    n_cutoff_points = n_chance_ammo + n_chance_points;
    n_roll = randomint( n_total_weight );

    if ( n_roll < n_cutoff_ammo )
        str_bonus = "ammo";
    else
        str_bonus = "points";

    if ( isdefined( self.is_stink_zombie ) && self.is_stink_zombie )
        str_bonus = "stink";

    return str_bonus;
}

show_debug_info( v_drop_point, str_identifier, str_bonus )
{
/#
    n_radius = 32;

    if ( str_bonus == "stink" )
        n_radius = 70;

    if ( getdvarint( #"_id_38E68F2B" ) )
    {
        self endon( str_identifier );
        vulture_debug_text( "zombie dropped " + str_bonus );

        for ( i = 0; i < get_vulture_drop_duration( str_bonus ) * 20; i++ )
        {
            circle( v_drop_point, n_radius, get_debug_circle_color( str_bonus ), 0, 1, 1 );
            wait 0.05;
        }
    }
#/
}

get_vulture_drop_duration( str_bonus )
{
    str_dvar = "zombies_perk_vulture_pickup_time";

    if ( str_bonus == "stink" )
        str_dvar = "zombies_perk_vulture_pickup_time_stink";

    n_duration = getdvarint( str_dvar );
    return n_duration;
}

get_debug_circle_color( str_bonus )
{
    switch ( str_bonus )
    {
        case "ammo":
            v_color = ( 0, 0, 1 );
            break;
        case "points":
            v_color = ( 1, 1, 0 );
            break;
        case "stink":
            v_color = ( 0, 1, 0 );
            break;
        default:
            v_color = ( 1, 1, 1 );
            break;
    }

    return v_color;
}

check_vulture_drop_pickup( e_temp, player, str_identifier, str_bonus )
{
    if ( !isdefined( e_temp ) )
        return;

    player endon( "death" );
    player endon( "disconnect" );
    e_temp endon( "death" );
    e_temp endon( "stop_vulture_behavior" );
    wait_network_frame();
    n_times_to_check = int( get_vulture_drop_duration( str_bonus ) / 0.15 );

    for ( i = 0; i < n_times_to_check; i++ )
    {
        b_player_inside_radius = distancesquared( e_temp.origin, player.origin ) < 1024;

        if ( b_player_inside_radius )
        {
            e_temp.picked_up = 1;
            break;
        }

        wait 0.15;
    }

    player notify( str_identifier );

    if ( b_player_inside_radius )
        player give_vulture_bonus( str_bonus );
}

_handle_zombie_stink( b_player_inside_radius )
{
    if ( !isdefined( self.perk_vulture.is_in_zombie_stink ) )
        self.perk_vulture.is_in_zombie_stink = 0;

    b_in_stink_last_check = self.perk_vulture.is_in_zombie_stink;
    self.perk_vulture.is_in_zombie_stink = b_player_inside_radius;

    if ( self.perk_vulture.is_in_zombie_stink )
    {
        n_current_time = gettime();

        if ( !b_in_stink_last_check )
        {
            self.perk_vulture.stink_time_entered = n_current_time;
            self toggle_stink_overlay( 1 );
            self thread stink_react_vo();
        }

        b_should_ignore_player = isdefined( self.perk_vulture.stink_time_entered ) && ( n_current_time - self.perk_vulture.stink_time_entered ) * 0.001 >= 0.0;

        if ( b_should_ignore_player )
            self.ignoreme = 1;

        if ( get_targetable_player_count() == 0 || !self are_any_players_in_adjacent_zone() )
        {
            if ( b_should_ignore_player && !level.perk_vulture.use_exit_behavior )
            {
                level.perk_vulture.use_exit_behavior = 1;
                level.default_find_exit_position_override = ::vulture_perk_should_zombies_resume_find_flesh;
                self thread vulture_zombies_find_exit_point();
            }
        }
    }
    else if ( b_in_stink_last_check )
    {
        self.perk_vulture.stink_time_exit = gettime();
        self thread _zombies_reacquire_player_after_leaving_stink();
    }
}

stink_react_vo()
{
    self endon( "death" );
    self endon( "disconnect" );
    wait 1.0;
    chance = get_response_chance( "vulture_stink" );

    if ( chance > randomintrange( 1, 100 ) )
        self maps\mp\zombies\_zm_audio::create_and_play_dialog( "general", "vulture_stink" );
}

get_targetable_player_count()
{
    n_targetable_player_count = 0;

    foreach ( player in get_players() )
    {
        if ( !isdefined( player.ignoreme ) || !player.ignoreme )
            n_targetable_player_count++;
    }

    return n_targetable_player_count;
}

are_any_players_in_adjacent_zone()
{
    b_players_in_adjacent_zone = 0;
    str_zone = self maps\mp\zombies\_zm_zonemgr::get_player_zone();

    foreach ( player in get_players() )
    {
        if ( player == self )
            continue;

        str_zone_compare = player maps\mp\zombies\_zm_zonemgr::get_player_zone();

        if ( isinarray( level.zones[str_zone].adjacent_zones, str_zone_compare ) && ( isdefined( level.zones[str_zone].adjacent_zones[str_zone_compare].is_connected ) && level.zones[str_zone].adjacent_zones[str_zone_compare].is_connected ) )
        {
            b_players_in_adjacent_zone = 1;
            break;
        }
    }

    return b_players_in_adjacent_zone;
}

toggle_stink_overlay( b_show_overlay )
{
    if ( !isdefined( self.vulture_stink_value ) )
        self.vulture_stink_value = 0;

    if ( b_show_overlay )
        self thread _ramp_up_stink_overlay();
    else
        self thread _ramp_down_stink_overlay();
}

_ramp_up_stink_overlay( b_instant_change )
{
    if ( !isdefined( b_instant_change ) )
        b_instant_change = 0;

    self notify( "vulture_perk_stink_ramp_up_done" );
    self endon( "vulture_perk_stink_ramp_up_done" );
    self endon( "death_or_disconnect" );
    self endon( "vulture_perk_lost" );
    self setclientfieldtoplayer( "sndVultureStink", 1 );

    if ( !isdefined( level.perk_vulture.stink_change_increment ) )
        level.perk_vulture.stink_change_increment = pow( 2, 5 ) * 0.25 / 8;

    while ( self.perk_vulture.is_in_zombie_stink )
    {
        self.vulture_stink_value = self.vulture_stink_value + level.perk_vulture.stink_change_increment;

        if ( self.vulture_stink_value > pow( 2, 5 ) - 1 )
            self.vulture_stink_value = pow( 2, 5 ) - 1;

        fraction = self _get_disease_meter_fraction();
        self setclientfieldtoplayer( "vulture_perk_disease_meter", fraction );
        self set_vulture_overlay( fraction );
        vulture_debug_text( "disease counter = " + self.vulture_stink_value );
        wait 0.25;
    }
}

set_vulture_overlay( fraction )
{
    state = level.vsmgr["overlay"].info["vulture_stink_overlay"].state;

    if ( fraction > 0 )
        state maps\mp\_visionset_mgr::vsmgr_set_state_active( self, 1 - fraction );
    else
        state maps\mp\_visionset_mgr::vsmgr_set_state_inactive( self );
}

_get_disease_meter_fraction()
{
    return self.vulture_stink_value / ( pow( 2, 5 ) - 1 );
}

_ramp_down_stink_overlay( b_instant_change )
{
    if ( !isdefined( b_instant_change ) )
        b_instant_change = 0;

    self notify( "vulture_perk_stink_ramp_down_done" );
    self endon( "vulture_perk_stink_ramp_down_done" );
    self endon( "death_or_disconnect" );
    self endon( "vulture_perk_lost" );
    self setclientfieldtoplayer( "sndVultureStink", 0 );

    if ( !isdefined( level.perk_vulture.stink_change_decrement ) )
        level.perk_vulture.stink_change_decrement = pow( 2, 5 ) * 0.25 / 4;

    while ( !self.perk_vulture.is_in_zombie_stink && self.vulture_stink_value > 0 )
    {
        self.vulture_stink_value = self.vulture_stink_value - level.perk_vulture.stink_change_decrement;

        if ( self.vulture_stink_value < 0 )
            self.vulture_stink_value = 0;

        fraction = self _get_disease_meter_fraction();
        self set_vulture_overlay( fraction );
        self setclientfieldtoplayer( "vulture_perk_disease_meter", fraction );
        vulture_debug_text( "disease counter = " + self.vulture_stink_value );
        wait 0.25;
    }
}

_zombies_reacquire_player_after_leaving_stink()
{
    self endon( "death_or_disconnect" );
    self notify( "vulture_perk_stop_zombie_reacquire_player" );
    self endon( "vulture_perk_stop_zombie_reacquire_player" );
    self toggle_stink_overlay( 0 );

    while ( self.vulture_stink_value > 0 )
    {
        vulture_debug_text( "zombies ignoring player..." );
        wait 0.25;
    }

    self.ignoreme = 0;
    level.perk_vulture.use_exit_behavior = 0;
}

vulture_perk_should_zombies_resume_find_flesh()
{
    b_should_find_flesh = !is_player_in_zombie_stink();
    return b_should_find_flesh;
}

is_player_in_zombie_stink()
{
    a_players = get_players();
    b_player_in_zombie_stink = 0;

    for ( i = 0; !b_player_in_zombie_stink && i < a_players.size; i++ )
    {
        if ( isdefined( a_players[i].is_in_zombie_stink ) && a_players[i].is_in_zombie_stink )
            b_player_in_zombie_stink = 1;
    }

    return b_player_in_zombie_stink;
}

give_vulture_bonus( str_bonus )
{
    switch ( str_bonus )
    {
        case "ammo":
            self give_bonus_ammo();
            break;
        case "points":
            self give_bonus_points();
            break;
        case "stink":
            self give_bonus_stink();
            break;
        default:
            assert( "invalid bonus string '" + str_bonus + "' used in give_vulture_bonus()!" );
            break;
    }
}

give_bonus_ammo()
{
    str_weapon_current = self getcurrentweapon();

    if ( str_weapon_current != "none" )
    {
        n_heat_value = self isweaponoverheating( 1, str_weapon_current );
        n_fuel_total = weaponfuellife( str_weapon_current );
        b_is_fuel_weapon = n_fuel_total > 0;
        b_is_overheating_weapon = n_heat_value > 0;

        if ( b_is_overheating_weapon )
        {
            n_ammo_refunded = randomintrange( 1, 3 );
            b_weapon_is_overheating = self isweaponoverheating();
            self setweaponoverheating( b_weapon_is_overheating, n_heat_value - n_ammo_refunded );
        }
        else if ( b_is_fuel_weapon )
        {
            n_fuel_used = self getweaponammofuel( str_weapon_current );
            n_fuel_refunded = randomintrange( int( n_fuel_total * 0.01 ), int( n_fuel_total * 0.03 ) );
            self setweaponammofuel( str_weapon_current, n_fuel_used - n_fuel_refunded );
            n_ammo_refunded = n_fuel_refunded / n_fuel_total * 100;
        }
        else if ( is_valid_ammo_bonus_weapon( str_weapon_current ) )
        {
            n_ammo_count_current = self getweaponammostock( str_weapon_current );
            n_ammo_count_max = weaponmaxammo( str_weapon_current );
            n_ammo_refunded = clamp( int( n_ammo_count_max * randomfloatrange( 0.0, 0.025 ) ), 1, n_ammo_count_max );
            b_is_custom_weapon = self handle_custom_weapon_refunds( str_weapon_current );

            if ( !b_is_custom_weapon )
                self setweaponammostock( str_weapon_current, n_ammo_count_current + n_ammo_refunded );
        }

        self playsoundtoplayer( "zmb_vulture_drop_pickup_ammo", self );
        chance = get_response_chance( "vulture_ammo_drop" );

        if ( chance > randomintrange( 1, 100 ) )
            self thread maps\mp\zombies\_zm_audio::create_and_play_dialog( "general", "vulture_ammo_drop" );

/#
        if ( getdvarint( #"_id_38E68F2B" ) )
        {
            if ( !isdefined( n_ammo_refunded ) )
                n_ammo_refunded = 0;

            vulture_debug_text( str_weapon_current + " bullets given: " + n_ammo_refunded );
        }
#/
    }
}

is_valid_ammo_bonus_weapon( str_weapon )
{
    return !( is_placeable_mine( str_weapon ) || maps\mp\zombies\_zm_equipment::is_placeable_equipment( str_weapon ) || isinarray( level.perk_vulture.invalid_bonus_ammo_weapons, str_weapon ) );
}

_play_vulture_drop_pickup_fx()
{
    self vulture_clientfield_scriptmover_set( "vulture_drop_pickup" );
}

give_bonus_points( v_fx_origin )
{
    n_multiplier = randomintrange( 1, 5 );
    self maps\mp\zombies\_zm_score::player_add_points( "vulture", 5 * n_multiplier );
    self playsoundtoplayer( "zmb_vulture_drop_pickup_money", self );
    chance = get_response_chance( "vulture_money_drop" );

    if ( chance > randomintrange( 1, 100 ) )
        self thread maps\mp\zombies\_zm_audio::create_and_play_dialog( "general", "vulture_money_drop" );
}

give_bonus_stink( v_drop_origin )
{
    self _handle_zombie_stink( 0 );
}

_vulture_perk_think()
{
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "vulture_perk_lost" );

    while ( true )
    {
        b_player_in_zombie_stink = 0;

        if ( !isdefined( level.perk_vulture.zombie_stink_array ) )
            level.perk_vulture.zombie_stink_array = [];

        if ( level.perk_vulture.zombie_stink_array.size > 0 )
        {
            a_close_points = arraysort( level.perk_vulture.zombie_stink_array, self.origin, 1, 300 );

            if ( a_close_points.size > 0 )
                b_player_in_zombie_stink = self _is_player_in_zombie_stink( a_close_points );
        }

        self _handle_zombie_stink( b_player_in_zombie_stink );
        wait( randomfloatrange( 0.25, 0.5 ) );
    }
}

_is_player_in_zombie_stink( a_points )
{
    b_is_in_stink = 0;

    for ( i = 0; i < a_points.size; i++ )
    {
        if ( distancesquared( a_points[i].origin, self.origin ) < 4900 )
            b_is_in_stink = 1;
    }

    return b_is_in_stink;
}

vulture_drop_count_increment()
{
    level.perk_vulture.drop_slots_for_network++;
    level thread _decrement_network_slots_after_time();
}

_decrement_network_slots_after_time()
{
    wait( getdvarint( #"_id_DB295746" ) * 0.001 );
    level.perk_vulture.drop_slots_for_network--;
}

vulture_zombie_spawn_func()
{
    self endon( "death" );
    self thread add_zombie_eye_glow();
    self waittill( "completed_emerging_into_playable_area" );

    if ( self should_zombie_have_stink() )
    {
        self stink_zombie_array_add();
/#
        if ( isdefined( self.stink_ent ) )
        {
            while ( true )
            {
                if ( getdvarint( #"_id_38E68F2B" ) )
                    debugstar( self.origin, 2, ( 0, 1, 0 ) );

                wait 0.1;
            }
        }
#/
    }
}

add_zombie_eye_glow()
{
    self endon( "death" );
    self waittill( "risen" );
    self vulture_clientfield_actor_set( "vulture_eye_glow" );
}

zombies_drop_stink_on_death()
{
    self vulture_clientfield_actor_clear( "vulture_eye_glow" );

    if ( isdefined( self.attacker ) && isplayer( self.attacker ) && self.attacker hasperk( "specialty_nomotionsensor" ) )
        self thread do_vulture_death( self.attacker );
    else if ( isdefined( self.is_stink_zombie ) && self.is_stink_zombie && isdefined( self.stink_ent ) )
    {
        str_identifier = "_" + self getentitynumber() + "_" + gettime();
        self thread _drop_zombie_stink( level, str_identifier, "stink" );
    }
}

clear_zombie_stink_fx()
{
    self vulture_clientfield_actor_clear( "vulture_stink_trail_fx" );
}

stink_zombie_array_add()
{
    if ( get_unused_stink_ent_count() > 0 )
    {
        self.stink_ent = get_unused_stink_ent();

        if ( isdefined( self.stink_ent ) )
        {
            self.stink_ent.owner = self;
            wait_network_frame();
            wait_network_frame();
            self.stink_ent thread _show_debug_location();
            self vulture_clientfield_actor_set( "vulture_stink_trail_fx" );
            level.perk_vulture.last_stink_zombie_spawned = gettime();
            self.is_stink_zombie = 1;
        }
    }
    else
        self.is_stink_zombie = 0;
}

should_zombie_have_stink()
{
    b_is_zombie = isdefined( self.animname ) && self.animname == "zombie";
    b_cooldown_up = gettime() - level.perk_vulture.last_stink_zombie_spawned > getdvarint( #"_id_47A03A7E" ) * 1000;
    b_roll_passed = 100 - randomint( 100 ) > 50;
    b_stink_ent_available = get_unused_stink_ent_count() > 0;
    b_should_have_stink = b_is_zombie && b_roll_passed && b_cooldown_up && b_stink_ent_available;
    return b_should_have_stink;
}

vulture_debug_text( str_text )
{
/#
    if ( getdvarint( #"_id_38E68F2B" ) )
        iprintln( str_text );
#/
}

vulture_clientfield_scriptmover_set( str_field_name )
{
    assert( isdefined( level.perk_vulture.clientfields.scriptmovers[str_field_name] ), str_field_name + " is not a valid client field for vulture perk!" );
    n_value = self getclientfield( "vulture_perk_scriptmover" );
    n_value = n_value | 1 << level.perk_vulture.clientfields.scriptmovers[str_field_name];
    self setclientfield( "vulture_perk_scriptmover", n_value );
}

vulture_clientfield_scriptmover_clear( str_field_name )
{
    assert( isdefined( level.perk_vulture.clientfields.scriptmovers[str_field_name] ), str_field_name + " is not a valid client field for vulture perk!" );
    n_value = self getclientfield( "vulture_perk_scriptmover" );
    n_value = n_value & ~( 1 << level.perk_vulture.clientfields.scriptmovers[str_field_name] );
    self setclientfield( "vulture_perk_scriptmover", n_value );
}

vulture_clientfield_actor_set( str_field_name )
{
    assert( isdefined( level.perk_vulture.clientfields.actors[str_field_name] ), str_field_name + " is not a valid field for vulture_clientfield_actor_set!" );
    n_value = getclientfield( "vulture_perk_actor" );
    n_value = n_value | 1 << level.perk_vulture.clientfields.actors[str_field_name];
    self setclientfield( "vulture_perk_actor", n_value );
}

vulture_clientfield_actor_clear( str_field_name )
{
    assert( isdefined( level.perk_vulture.clientfields.actors[str_field_name] ), str_field_name + " is not a valid field for vulture_clientfield_actor_clear!" );
    n_value = getclientfield( "vulture_perk_actor" );
    n_value = n_value & ~( 1 << level.perk_vulture.clientfields.actors[str_field_name] );
    self setclientfield( "vulture_perk_actor", n_value );
}

vulture_clientfield_toplayer_set( str_field_name )
{
    assert( isdefined( level.perk_vulture.clientfields.toplayer[str_field_name] ), str_field_name + " is not a valid client field for vulture perk!" );
    n_value = self getclientfieldtoplayer( "vulture_perk_toplayer" );
    n_value = n_value | 1 << level.perk_vulture.clientfields.toplayer[str_field_name];
    self setclientfieldtoplayer( "vulture_perk_toplayer", n_value );
}

vulture_clientfield_toplayer_clear( str_field_name )
{
    assert( isdefined( level.perk_vulture.clientfields.toplayer[str_field_name] ), str_field_name + " is not a valid client field for vulture perk!" );
    n_value = self getclientfieldtoplayer( "vulture_perk_toplayer" );
    n_value = n_value & ~( 1 << level.perk_vulture.clientfields.toplayer[str_field_name] );
    self setclientfieldtoplayer( "vulture_perk_toplayer", n_value );
}

vulture_perk_watch_mystery_box()
{
    wait_network_frame();

    while ( isdefined( level.chests ) && level.chests.size > 0 && isdefined( level.chest_index ) )
    {
        level.chests[level.chest_index].zbarrier vulture_perk_shows_mystery_box( 1 );
        flag_wait( "moving_chest_now" );
        level.chests[level.chest_index].zbarrier vulture_perk_shows_mystery_box( 0 );
        flag_waitopen( "moving_chest_now" );
    }
}

vulture_perk_shows_mystery_box( b_show )
{
    self setclientfield( "vulture_perk_zbarrier", b_show );
}

vulture_perk_watch_fire_sale()
{
    wait_network_frame();

    while ( isdefined( level.chests ) && level.chests.size > 0 )
    {
        level waittill( "powerup fire sale" );

        for ( i = 0; i < level.chests.size; i++ )
        {
            if ( i != level.chest_index )
                level.chests[i] thread vulture_fire_sale_box_fx_enable();
        }

        level waittill( "fire_sale_off" );

        for ( i = 0; i < level.chests.size; i++ )
        {
            if ( i != level.chest_index )
                level.chests[i] thread vulture_fire_sale_box_fx_disable();
        }
    }
}

vulture_fire_sale_box_fx_enable()
{
    if ( self.zbarrier.state == "arriving" )
        self.zbarrier waittill( "arrived" );

    self.zbarrier setclientfield( "vulture_perk_zbarrier", 1 );
}

vulture_fire_sale_box_fx_disable()
{
    self.zbarrier setclientfield( "vulture_perk_zbarrier", 0 );
}

vulture_perk_watch_powerup_drops()
{
    while ( true )
    {
        level waittill( "powerup_dropped", m_powerup );
        m_powerup thread _powerup_drop_think();
    }
}

_powerup_drop_think()
{
    e_temp = spawn( "script_model", self.origin );
    e_temp setmodel( "tag_origin" );
    e_temp vulture_clientfield_scriptmover_set( "vulture_powerup_drop" );
    self waittill_any( "powerup_timedout", "powerup_grabbed", "death" );
    e_temp vulture_clientfield_scriptmover_clear( "vulture_powerup_drop" );
    wait_network_frame();
    wait_network_frame();
    wait_network_frame();
    e_temp delete();
}

vulture_zombies_find_exit_point()
{
/#
    if ( getdvarint( #"_id_38E68F2B" ) > 0 )
    {
        foreach ( struct in level.enemy_dog_locations )
            debugstar( struct.origin, 200, ( 1, 1, 1 ) );
    }
#/
    a_zombies = get_round_enemy_array();

    for ( i = 0; i < a_zombies.size; i++ )
        a_zombies[i] thread zombie_goes_to_exit_location();
}

zombie_goes_to_exit_location()
{
    self endon( "death" );

    if ( !( isdefined( self.completed_emerging_into_playable_area ) && self.completed_emerging_into_playable_area ) )
    {
        self waittill( "completed_emerging_into_playable_area" );
        wait 1;
    }

    s_goal = _get_zombie_exit_point();
    self notify( "stop_find_flesh" );
    self notify( "zombie_acquire_enemy" );

    if ( isdefined( s_goal ) )
        self setgoalpos( s_goal.origin );

    while ( true )
    {
        b_passed_override = 1;

        if ( isdefined( level.default_find_exit_position_override ) )
            b_passed_override = [[ level.default_find_exit_position_override ]]();

        if ( !flag( "wait_and_revive" ) && b_passed_override )
            break;

        wait 0.1;
    }

    self thread maps\mp\zombies\_zm_ai_basic::find_flesh();
}

_get_zombie_exit_point()
{
    player = get_players()[0];
    n_dot_best = 9999999;
    a_exit_points = self [[ level.perk_vulture.func_zombies_find_valid_exit_locations ]]();
    assert( a_exit_points.size > 0, "_get_zombie_exit_point() couldn't find any zombie exit points for player at " + player.origin + "! Add more dog_locations!" );

    for ( i = 0; i < a_exit_points.size; i++ )
    {
        v_to_player = vectornormalize( player.origin - self.origin );
        v_to_goal = a_exit_points[i].origin - self.origin;
        n_dot = vectordot( v_to_player, v_to_goal );

        if ( n_dot < n_dot_best && distancesquared( player.origin, a_exit_points[i].origin ) > 360000 )
        {
            nd_best = a_exit_points[i];
            n_dot_best = n_dot;
        }

/#
        if ( getdvarint( #"_id_38E68F2B" ) )
            debugstar( a_exit_points[i].origin, 200, ( 1, 0, 0 ) );
#/
    }

    return nd_best;
}

get_valid_exit_points_for_zombie()
{
    a_exit_points = level.enemy_dog_locations;

    if ( isdefined( level.perk_vulture.zones_for_extra_stink_locations ) && level.perk_vulture.zones_for_extra_stink_locations.size > 0 )
    {
        a_zones_with_extra_stink_locations = getarraykeys( level.perk_vulture.zones_for_extra_stink_locations );

        foreach ( zone in level.active_zone_names )
        {
            if ( isinarray( a_zones_with_extra_stink_locations, zone ) )
            {
                a_zones_temp = level.perk_vulture.zones_for_extra_stink_locations[zone];

                for ( i = 0; i < a_zones_temp.size; i++ )
                    a_exit_points = arraycombine( a_exit_points, get_zone_dog_locations( a_zones_temp[i] ), 0, 0 );
            }
        }
    }

    return a_exit_points;
}

get_zone_dog_locations( str_zone )
{
    a_dog_locations = [];

    if ( isdefined( level.zones[str_zone] ) && isdefined( level.zones[str_zone].dog_locations ) )
        a_dog_locations = level.zones[str_zone].dog_locations;

    return a_dog_locations;
}

vulture_vision_toggle( b_enable )
{

}

vulture_handle_solo_quick_revive()
{
    flag_wait( "initial_blackscreen_passed" );

    if ( flag( "solo_game" ) )
    {
        flag_wait( "solo_revive" );
        setclientfield( "vulture_perk_disable_solo_quick_revive_glow", 1 );
    }
}

vulture_devgui_spawn_stink()
{
/#
    player = gethostplayer();
    forward_dir = vectornormalize( anglestoforward( player.angles ) );
    target_pos = player.origin + forward_dir * 100 + vectorscale( ( 0, 0, 1 ), 50.0 );
    target_pos_down = target_pos + vectorscale( ( 0, 0, -1 ), 150.0 );
    str_bonus = "stink";
    str_identifier = "_" + "test_" + gettime();
    drop_pos = groundtrace( target_pos, target_pos_down, 0, player )["position"];
    setdvarint( "zombies_debug_vulture_perk", 1 );
    player thread show_debug_info( drop_pos, str_identifier, str_bonus );
    e_temp = player maps\mp\zombies\_zm_perk_vulture::zombie_drops_stink( drop_pos, str_identifier );
    e_temp = player maps\mp\zombies\_zm_perk_vulture::_vulture_spawn_fx( str_identifier, drop_pos, str_bonus, e_temp );
    maps\mp\zombies\_zm_perk_vulture::clean_up_stink( e_temp );
#/
}

setup_splitscreen_optimizations()
{
    if ( level.splitscreen && getdvarint( #"splitscreen_playerCount" ) > 2 )
    {
        setdvarint( "zombies_perk_vulture_drops_max", int( getdvarint( #"_id_612F9831" ) * 0.5 ) );
        setdvarint( "zombies_perk_vulture_spawn_stink_zombie_cooldown", int( getdvarint( #"_id_47A03A7E" ) * 2 ) );
        setdvarint( "zombies_perk_vulture_max_stink_zombies", int( getdvarint( #"_id_16BCAE6A" ) * 0.5 ) );
    }
}

initialize_bonus_entity_pool()
{
    n_ent_pool_size = getdvarint( #"_id_612F9831" );
    level.perk_vulture.bonus_drop_ent_pool = [];

    for ( i = 0; i < n_ent_pool_size; i++ )
    {
        e_temp = spawn( "script_model", ( 0, 0, 0 ) );
        e_temp setmodel( "tag_origin" );
        e_temp.targetname = "vulture_perk_bonus_pool_ent";
        e_temp.in_use = 0;
        level.perk_vulture.bonus_drop_ent_pool[level.perk_vulture.bonus_drop_ent_pool.size] = e_temp;
    }
}

get_unused_bonus_ent()
{
    e_found = undefined;

    for ( i = 0; i < level.perk_vulture.bonus_drop_ent_pool.size && !isdefined( e_found ); i++ )
    {
        if ( !level.perk_vulture.bonus_drop_ent_pool[i].in_use )
        {
            e_found = level.perk_vulture.bonus_drop_ent_pool[i];
            e_found.in_use = 1;
        }
    }

    return e_found;
}

get_unused_bonus_ent_count()
{
    n_found = 0;

    for ( i = 0; i < level.perk_vulture.bonus_drop_ent_pool.size; i++ )
    {
        if ( !level.perk_vulture.bonus_drop_ent_pool[i].in_use )
            n_found++;
    }

    return n_found;
}

clear_bonus_ent()
{
    self notify( "stop_vulture_behavior" );
    self vulture_clientfield_scriptmover_clear( "vulture_drop_fx" );
    self.in_use = 0;
    self setmodel( "tag_origin" );
    self ghost();
}

initialize_stink_entity_pool()
{
    n_ent_pool_size = getdvarint( #"_id_16BCAE6A" );
    level.perk_vulture.stink_ent_pool = [];

    for ( i = 0; i < n_ent_pool_size; i++ )
    {
        e_temp = spawn( "script_model", ( 0, 0, 0 ) );
        e_temp setmodel( "tag_origin" );
        e_temp.targetname = "vulture_perk_bonus_pool_ent";
        e_temp.in_use = 0;
        level.perk_vulture.stink_ent_pool[level.perk_vulture.stink_ent_pool.size] = e_temp;
    }
}

get_unused_stink_ent_count()
{
    n_found = 0;

    for ( i = 0; i < level.perk_vulture.stink_ent_pool.size; i++ )
    {
        if ( !level.perk_vulture.stink_ent_pool[i].in_use )
        {
            n_found++;
            continue;
        }

        if ( !isdefined( level.perk_vulture.stink_ent_pool[i].owner ) && !isdefined( level.perk_vulture.stink_ent_pool[i].drop_time ) )
        {
            level.perk_vulture.stink_ent_pool[i] clear_stink_ent();
            n_found++;
        }
    }

    return n_found;
}

get_unused_stink_ent()
{
    e_found = undefined;

    for ( i = 0; i < level.perk_vulture.stink_ent_pool.size && !isdefined( e_found ); i++ )
    {
        if ( !level.perk_vulture.stink_ent_pool[i].in_use )
        {
            e_found = level.perk_vulture.stink_ent_pool[i];
            e_found.in_use = 1;
            vulture_debug_text( "vulture stink >> ent " + e_found getentitynumber() + " in use" );
        }
    }

    return e_found;
}

clear_stink_ent()
{
    vulture_debug_text( "vulture stink >> ent " + self getentitynumber() + " CLEAR" );
    self vulture_clientfield_scriptmover_clear( "vulture_stink_fx" );
    self notify( "stop_vulture_behavior" );
    self.in_use = 0;
    self.drop_time = undefined;
    self.owner = undefined;
    self setmodel( "tag_origin" );
    self ghost();
}

_show_debug_location()
{
/#
    while ( self.in_use )
    {
        if ( getdvarint( #"_id_38E68F2B" ) > 0 )
        {
            debugstar( self.origin, 1, ( 0, 0, 1 ) );
            print3d( self.origin, self getentitynumber(), ( 0, 0, 1 ), 1, 1, 1 );
        }

        wait 0.05;
    }
#/
}

handle_custom_weapon_refunds( str_weapon )
{
    b_is_custom_weapon = 0;

    if ( issubstr( str_weapon, "knife_ballistic" ) )
    {
        self _refund_oldest_ballistic_knife( str_weapon );
        b_is_custom_weapon = 1;
    }

    return b_is_custom_weapon;
}

_refund_oldest_ballistic_knife( str_weapon )
{
    self endon( "death_or_disconnect" );
    self endon( "vulture_perk_lost" );

    if ( isdefined( self.weaponobjectwatcherarray ) && self.weaponobjectwatcherarray.size > 0 )
    {
        b_found_weapon_object = 0;

        for ( i = 0; i < self.weaponobjectwatcherarray.size; i++ )
        {
            if ( isdefined( self.weaponobjectwatcherarray[i].weapon ) && self.weaponobjectwatcherarray[i].weapon == str_weapon )
            {
                s_found = self.weaponobjectwatcherarray[i];
                break;
            }
        }

        if ( isdefined( s_found ) )
        {
            if ( isdefined( s_found.objectarray ) && s_found.objectarray.size > 0 )
            {
                e_oldest = undefined;

                for ( i = 0; i < s_found.objectarray.size; i++ )
                {
                    if ( isdefined( s_found.objectarray[i] ) )
                    {
                        if ( !isdefined( s_found.objectarray[i].retrievabletrigger ) || !isdefined( s_found.objectarray[i].retrievabletrigger.owner ) || s_found.objectarray[i].retrievabletrigger.owner != self || !isdefined( s_found.objectarray[i].birthtime ) )
                            continue;

                        if ( !isdefined( e_oldest ) )
                            e_oldest = s_found.objectarray[i];

                        if ( s_found.objectarray[i].birthtime < e_oldest.birthtime )
                            e_oldest = s_found.objectarray[i];
                    }
                }

                if ( isdefined( e_oldest ) )
                {
                    e_oldest.retrievabletrigger.force_pickup = 1;
                    e_oldest.retrievabletrigger notify( "trigger", self );
                }
            }
        }
    }
}

enable_divetonuke_perk_for_level()
{
    maps\mp\zombies\_zm_perks::register_perk_basic_info( "specialty_flakjacket", "divetonuke", 2000, &"ZOMBIE_PERK_DIVETONUKE", "zombie_perk_bottle_nuke" );
    maps\mp\zombies\_zm_perks::register_perk_precache_func( "specialty_flakjacket", ::divetonuke_precache );
    maps\mp\zombies\_zm_perks::register_perk_clientfields( "specialty_flakjacket", ::divetonuke_register_clientfield, ::divetonuke_set_clientfield );
    maps\mp\zombies\_zm_perks::register_perk_machine( "specialty_flakjacket", ::divetonuke_perk_machine_setup, ::divetonuke_perk_machine_think );
    maps\mp\zombies\_zm_perks::register_perk_host_migration_func( "specialty_flakjacket", ::divetonuke_host_migration_func );
}

init_divetonuke()
{
    level.zombiemode_divetonuke_perk_func = ::divetonuke_explode;
    maps\mp\_visionset_mgr::vsmgr_register_info( "visionset", "zm_perk_divetonuke", 9000, 400, 5, 1 );
    level._effect["divetonuke_groundhit"] = loadfx( "maps/zombie/fx_zmb_phdflopper_exp" );
    set_zombie_var( "zombie_perk_divetonuke_radius", 300 );
    set_zombie_var( "zombie_perk_divetonuke_min_damage", 1000 );
    set_zombie_var( "zombie_perk_divetonuke_max_damage", 5000 );
}

divetonuke_precache()
{
    if ( isdefined( level.divetonuke_precache_override_func ) )
    {
        [[ level.divetonuke_precache_override_func ]]();
        return;
    }

    precacheitem( "zombie_perk_bottle_nuke" );
    precacheshader( "specialty_divetonuke_zombies" );
    precachemodel( "zombie_vending_nuke" );
    precachemodel( "zombie_vending_nuke_on" );
    precachestring( &"ZOMBIE_PERK_DIVETONUKE" );
    level._effect["divetonuke_light"] = loadfx( "misc/fx_zombie_cola_dtap_on" );
    level.machine_assets["divetonuke"] = spawnstruct();
    level.machine_assets["divetonuke"].weapon = "zombie_perk_bottle_nuke";
    level.machine_assets["divetonuke"].off_model = "zombie_vending_nuke";
    level.machine_assets["divetonuke"].on_model = "zombie_vending_nuke_on";
}

divetonuke_register_clientfield()
{
    registerclientfield( "toplayer", "perk_dive_to_nuke", 9000, 1, "int" );
}

divetonuke_set_clientfield( state )
{
    self setclientfieldtoplayer( "perk_dive_to_nuke", state );
}

divetonuke_perk_machine_setup( use_trigger, perk_machine, bump_trigger, collision )
{
    use_trigger.script_sound = "mus_perks_phd_jingle";
    use_trigger.script_string = "divetonuke_perk";
    use_trigger.script_label = "mus_perks_phd_sting";
    use_trigger.target = "vending_divetonuke";
    perk_machine.script_string = "divetonuke_perk";
    perk_machine.targetname = "vending_divetonuke";

    if ( isdefined( bump_trigger ) )
        bump_trigger.script_string = "divetonuke_perk";
}

divetonuke_perk_machine_think()
{
    init_divetonuke();

    while ( true )
    {
        machine = getentarray( "vending_divetonuke", "targetname" );
        machine_triggers = getentarray( "vending_divetonuke", "target" );

        for ( i = 0; i < machine.size; i++ )
            machine[i] setmodel( level.machine_assets["divetonuke"].off_model );

        array_thread( machine_triggers, ::set_power_on, 0 );
        level thread do_initial_power_off_callback( machine, "divetonuke" );
        level waittill( "divetonuke_on" );

        for ( i = 0; i < machine.size; i++ )
        {
            machine[i] setmodel( level.machine_assets["divetonuke"].on_model );
            machine[i] vibrate( vectorscale( ( 0, -1, 0 ), 100.0 ), 0.3, 0.4, 3 );
            machine[i] playsound( "zmb_perks_power_on" );
            machine[i] thread perk_fx( "divetonuke_light" );
            machine[i] thread play_loop_on_machine();
        }

        level notify( "specialty_flakjacket_power_on" );
        array_thread( machine_triggers, ::set_power_on, 1 );

        if ( isdefined( level.machine_assets["divetonuke"].power_on_callback ) )
            array_thread( machine, level.machine_assets["divetonuke"].power_on_callback );

        level waittill( "divetonuke_off" );

        if ( isdefined( level.machine_assets["divetonuke"].power_off_callback ) )
            array_thread( machine, level.machine_assets["divetonuke"].power_off_callback );

        array_thread( machine, ::turn_perk_off );
    }
}

divetonuke_host_migration_func()
{
    flop = getentarray( "vending_divetonuke", "targetname" );

    foreach ( perk in flop )
    {
        if ( isdefined( perk.model ) && perk.model == level.machine_assets["divetonuke"].on_model )
        {
            perk perk_fx( undefined, 1 );
            perk thread perk_fx( "divetonuke_light" );
        }
    }
}

divetonuke_explode( attacker, origin )
{
    radius = level.zombie_vars["zombie_perk_divetonuke_radius"];
    min_damage = level.zombie_vars["zombie_perk_divetonuke_min_damage"];
    max_damage = level.zombie_vars["zombie_perk_divetonuke_max_damage"];

    if ( isdefined( level.flopper_network_optimized ) && level.flopper_network_optimized )
        attacker thread divetonuke_explode_network_optimized( origin, radius, max_damage, min_damage, "MOD_GRENADE_SPLASH" );
    else
        radiusdamage( origin, radius, max_damage, min_damage, attacker, "MOD_GRENADE_SPLASH" );

    playfx( level._effect["divetonuke_groundhit"], origin );
    attacker playsound( "zmb_phdflop_explo" );
    maps\mp\_visionset_mgr::vsmgr_activate( "visionset", "zm_perk_divetonuke", attacker );
    wait 1;
    maps\mp\_visionset_mgr::vsmgr_deactivate( "visionset", "zm_perk_divetonuke", attacker );
}

divetonuke_explode_network_optimized( origin, radius, max_damage, min_damage, damage_mod )
{
    self endon( "disconnect" );
    a_zombies = get_array_of_closest( origin, get_round_enemy_array(), undefined, undefined, radius );
    network_stall_counter = 0;

    if ( isdefined( a_zombies ) )
    {
        for ( i = 0; i < a_zombies.size; i++ )
        {
            e_zombie = a_zombies[i];

            if ( !isdefined( e_zombie ) || !isalive( e_zombie ) )
                continue;

            dist = distance( e_zombie.origin, origin );
            damage = min_damage + ( max_damage - min_damage ) * ( 1.0 - dist / radius );
            e_zombie dodamage( damage, e_zombie.origin, self, self, 0, damage_mod );
            network_stall_counter--;

            if ( network_stall_counter <= 0 )
            {
                wait_network_frame();
                network_stall_counter = randomintrange( 1, 3 );
            }
        }
    }
}