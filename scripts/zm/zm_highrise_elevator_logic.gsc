#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zombies\_zm_weapons;
#include maps\mp\zm_transit_utility;
#include maps\mp\zombies\_zm_buildables;
#include maps\mp\zm_highrise_elevators;
#include maps\mp\zombies\_zm_unitrigger;
#include scripts\zm\zm_custom;
#include maps\mp\zm_highrise_buildables;

main()
{
   replaceFunc(maps\mp\zm_highrise_buildables::onuseplantobject_elevatorkey, ::onuseplantobject_elevatorkey_override);
   replaceFunc(maps\mp\zm_highrise_buildables::elevator_key_prompt, ::elevator_key_prompt_override);
   replaceFunc(maps\mp\zm_highrise_buildables::include_buildables, ::include_buildables);

}

include_buildables()
{
    springpad_door = generate_zombie_buildable_piece( "springpad_zm", "p6_zm_buildable_tramplesteam_door", 32, 64, 0, "zom_hud_trample_steam_screen", ::onpickup_common, ::ondrop_common, undefined, "Tag_part_02", undefined, 1 );
    springpad_flag = generate_zombie_buildable_piece( "springpad_zm", "p6_zm_buildable_tramplesteam_bellows", 48, 15, 0, "zom_hud_trample_steam_bellow", ::onpickup_common, ::ondrop_common, undefined, "Tag_part_04", undefined, 2 );
    springpad_motor = generate_zombie_buildable_piece( "springpad_zm", "p6_zm_buildable_tramplesteam_compressor", 48, 15, 0, "zom_hud_trample_steam_compressor", ::onpickup_common, ::ondrop_common, undefined, "Tag_part_01", undefined, 3 );
    springpad_whistle = generate_zombie_buildable_piece( "springpad_zm", "p6_zm_buildable_tramplesteam_flag", 48, 15, 0, "zom_hud_trample_steam_whistle", ::onpickup_common, ::ondrop_common, undefined, "Tag_part_03", undefined, 4 );
    springpad = spawnstruct();
    springpad.name = "springpad_zm";
    springpad add_buildable_piece( springpad_door );
    springpad add_buildable_piece( springpad_flag );
    springpad add_buildable_piece( springpad_motor );
    springpad add_buildable_piece( springpad_whistle );
    springpad.triggerthink = ::springpadbuildable;
    include_buildable( springpad );
    slipgun_canister = generate_zombie_buildable_piece( "slipgun_zm", "t6_zmb_buildable_slipgun_extinguisher", 32, 64, 0, "zom_hud_icon_buildable_slip_ext", ::onpickup_common, ::ondrop_common, undefined, "TAG_CO2", undefined, 5 );
    slipgun_cooker = generate_zombie_buildable_piece( "slipgun_zm", "t6_zmb_buildable_slipgun_cooker", 48, 15, 0, "zom_hud_icon_buildable_slip_cooker", ::onpickup_common, ::ondrop_common, undefined, "TAG_COOKER", undefined, 6 );
    slipgun_foot = generate_zombie_buildable_piece( "slipgun_zm", "t6_zmb_buildable_slipgun_foot", 48, 15, 0, "zom_hud_icon_buildable_slip_foot", ::onpickup_common, ::ondrop_common, undefined, "TAG_FOOT", undefined, 7 );
    slipgun_throttle = generate_zombie_buildable_piece( "slipgun_zm", "t6_zmb_buildable_slipgun_throttle", 48, 15, 0, "zom_hud_icon_buildable_slip_handle", ::onpickup_common, ::ondrop_common, undefined, "TAG_THROTTLE", undefined, 8 );
    slipgun = spawnstruct();
    slipgun.name = "slipgun_zm";
    slipgun add_buildable_piece( slipgun_canister );
    slipgun add_buildable_piece( slipgun_cooker );
    slipgun add_buildable_piece( slipgun_foot );
    slipgun add_buildable_piece( slipgun_throttle );
    slipgun.onbuyweapon = ::onbuyweapon_slipgun;
    slipgun.triggerthink = ::slipgunbuildable;
    slipgun.onuseplantobject = ::onuseplantobject_slipgun;
    include_buildable( slipgun );
    key_chain = generate_zombie_buildable_piece( "keys_zm", "P6_zm_hr_key", 32, 64, 2.4, "zom_hud_icon_epod_key", ::onpickup_keys, ::ondrop_keys, undefined, undefined, 0, 9 );
    key_chain.onspawn = ::onspawn_keys;
    key_chain manage_multiple_pieces( 4 );
    key = spawnstruct();
    key.name = "keys_zm";
    key add_buildable_piece( key_chain );
    key.triggerthink = ::keysbuildable;
    key.onuseplantobject = ::onuseplantobject_escapepodkey;
    key.buildablepieces[0].onspawn = ::onspawn_keys;
    include_buildable( key );
    ekey = spawnstruct();
    ekey.name = "ekeys_zm";
    ekey add_buildable_piece( key_chain );
    ekey.triggerthink = ::ekeysbuildable;
    ekey.onuseplantobject = ::onuseplantobject_elevatorkey_override;
    ekey.buildablepieces[0].onspawn = ::onspawn_keys;
    include_buildable( ekey );

    if ( !isdefined( level.gamedifficulty ) || level.gamedifficulty != 0 )
    {
        sq_common_electricbox = generate_zombie_buildable_piece( "sq_common", "p6_zm_buildable_sq_electric_box", 32, 64, 0, "zm_hud_icon_sq_powerbox", ::onpickup_common, ::ondrop_common, undefined, "tag_part_02", undefined, 10 );
        sq_common_meteor = generate_zombie_buildable_piece( "sq_common", "p6_zm_buildable_sq_meteor", 32, 64, 0, "zm_hud_icon_sq_meteor", ::onpickup_common, ::ondrop_common, undefined, "tag_part_04", undefined, 11 );
        sq_common_scaffolding = generate_zombie_buildable_piece( "sq_common", "p6_zm_buildable_sq_scaffolding", 64, 96, 0, "zm_hud_icon_sq_scafold", ::onpickup_common, ::ondrop_common, undefined, "tag_part_01", undefined, 12 );
        sq_common_transceiver = generate_zombie_buildable_piece( "sq_common", "p6_zm_buildable_sq_transceiver", 64, 96, 0, "zm_hud_icon_sq_tranceiver", ::onpickup_common, ::ondrop_common, undefined, "tag_part_03", undefined, 13 );
        sqcommon = spawnstruct();
        sqcommon.name = "sq_common";
        sqcommon add_buildable_piece( sq_common_electricbox );
        sqcommon add_buildable_piece( sq_common_meteor );
        sqcommon add_buildable_piece( sq_common_scaffolding );
        sqcommon add_buildable_piece( sq_common_transceiver );
        sqcommon.triggerthink = ::sqcommonbuildable;
        include_buildable( sqcommon );
        maps\mp\zombies\_zm_buildables::hide_buildable_table_model( "sq_common_buildable_trigger" );
    }
}

onuseplantobject_elevatorkey_override( player )
{

    elevatorname = self.script_noteworthy;
    
    if ( isdefined( elevatorname ) && isdefined( self.script_parameters ) )
    {
        floor = int( self.script_parameters );
        elevator = level.elevators[elevatorname];

        if ( isdefined( elevator ) )
        {
            self playsound("zmb_elevator_ding");

            if (elevator.body.is_moving)
            {
                self waittill( "movedone" );
            }
            
            
            if (!elevator.body.is_moving && elevator maps\mp\zm_highrise_elevators::elevator_is_on_floor(self.floor) && !is_true(elevator.body.start_location_wait))
            {
                if (elevator.body.elevator_switch == 0)
                {
                    //self.elevator.body setanim(level.perk_elevators_anims[self.elevator.body.perk_type][1]);
                    //self.elevator.body.elevator_stop = 1;
                    
                    elevator.body.elevator_switch = 1;
                    perk = elevator.body.perk_type;


                    if (perk == "vending_doubletap")
                    {
                        machine = getent( perk, "targetname" );
                        trigger = getent( perk, "target" );

                        trigger Unlink();

                        if ( isdefined( trigger ) )
                        {
                            trigger trigger_off();
                            //machine trigger_off();
                            machine Hide();
                            
                            level.custom_deadshot_trigger unlink();
                            level.custom_deadshot_trigger trigger_on();
                            level.custom_deadshot_trigger.origin = machine.origin + vectorscale( ( 0, 0, 1 ), 30.0 );
                            level.custom_deadshot_trigger.angles = machine.angles;
                        
                            level.custom_deadshot_trigger linkto( machine );

                            playfx( level._effect[ "electric_cherry_explode" ], machine.origin );
                            self playsound("zmb_explo");
                            earthquake( 0.8, 1, machine.origin, 500 );
                            level.custom_deadshot_perk Show();
                        }
                    }

                    if (perk == "vending_additionalprimaryweapon")
                    {
                        machine = getent( perk, "targetname" );
                        trigger = getent( perk, "target" );

                        trigger Unlink();

                        if ( isdefined( trigger ) )
                        {
                            trigger trigger_off();
                            //machine trigger_off();
                            machine Hide();
                            
                            level.custom_vulture_aid_trigger unlink();
                            level.custom_vulture_aid_trigger trigger_on();
                            level.custom_vulture_aid_trigger.origin = machine.origin + vectorscale( ( 0, 0, 1 ), 30.0 );
                            level.custom_vulture_aid_trigger.angles = machine.angles;
                            level.custom_vulture_aid_trigger linkto( machine );

                            playfx( level._effect[ "electric_cherry_explode" ], machine.origin );
                            self playsound("zmb_explo");
                            earthquake( 0.8, 1, machine.origin, 500 );
                            level.custom_vulture_aid_perk Show();
                        }
                    }

                    if (perk == "vending_sleight")
                    {
                        machine = getent( perk, "targetname" );
                        trigger = getent( perk, "target" );

                        trigger Unlink();

                        if ( isdefined( trigger ) )
                        {
                            trigger trigger_off();
                            //machine trigger_off();
                            machine Hide();
                            
                            level.custom_electric_trigger unlink();
                            level.custom_electric_trigger trigger_on();
                            level.custom_electric_trigger.origin = machine.origin + vectorscale( ( 0, 0, 1 ), 30.0 );
                            level.custom_electric_trigger.angles = machine.angles;
                            level.custom_electric_trigger linkto( machine );

                            playfx( level._effect[ "electric_cherry_explode" ], machine.origin );
                            self playsound("zmb_explo");
                            earthquake( 0.8, 1, machine.origin, 500 );
                            level.custom_electric_perk Show();
                        }
                    }

                    if (perk == "vending_jugg")
                    {
                        machine = getent( perk, "targetname" );
                        trigger = getent( perk, "target" );

                        trigger Unlink();

                        if ( isdefined( trigger ) )
                        {
                            trigger trigger_off();
                            //machine trigger_off();
                            machine Hide();
                            
                            level.custom_phd_flopper_trigger unlink();
                            level.custom_phd_flopper_trigger trigger_on();
                            level.custom_phd_flopper_trigger.origin = machine.origin + vectorscale( ( 0, 0, 1 ), 30.0 );
                            level.custom_phd_flopper_trigger.angles = machine.angles;
                            level.custom_phd_flopper_trigger linkto( machine );

                            playfx( level._effect[ "electric_cherry_explode" ], machine.origin );
                            self playsound("zmb_explo");
                            earthquake( 0.8, 1, machine.origin, 500 );
                            level.custom_phd_flopper_perk Show();
                        }
                    }

                }
                else if (elevator.body.elevator_switch == 1)
                {
                    //self.elevator.body.elevator_stop = 0;
                    elevator.body.elevator_switch = 0;
                    perk = elevator.body.perk_type;

                    
                    if (perk == "vending_doubletap")
                    {
                        machine = getent( perk, "targetname" );
                        trigger = getent( perk, "target" );

                        if ( isdefined( trigger ) )
                        {
                            machine Show();
                            trigger trigger_on();
                            //machine trigger_on();
                            trigger.origin = machine.origin + vectorscale( ( 0, 0, 1 ), 30.0 );
                            trigger.angles = machine.angles;
                            trigger linkto( machine);
                    

                            level.custom_deadshot_trigger unlink();
                            level.custom_deadshot_trigger.origin = machine.origin + vectorscale( ( 0, 0, 1 ), 30.0 );
                            level.custom_deadshot_trigger.angles = machine.angles;
                            level.custom_deadshot_trigger trigger_off();

                            level.custom_deadshot_trigger linkto( machine );
                            playfx( level._effect[ "electric_cherry_explode" ], machine.origin );
                            //grenadeexplosionfx(machine.origin);
                            self playsound("zmb_explo");
                            earthquake( 0.8, 1, machine.origin, 500 );
                            level.custom_deadshot_perk Hide();
                        }
                    }

                    if (perk == "vending_additionalprimaryweapon")
                    {
                        machine = getent( perk, "targetname" );
                        trigger = getent( perk, "target" );

                        if ( isdefined( trigger ) )
                        {
                            machine Show();
                            trigger trigger_on();
                            //machine trigger_on();
                            trigger.origin = machine.origin + vectorscale( ( 0, 0, 1 ), 30.0 );
                            trigger.angles = machine.angles;
                            trigger linkto( machine);
                    

                            level.custom_vulture_aid_trigger unlink();
                            level.custom_vulture_aid_trigger.origin = machine.origin + vectorscale( ( 0, 0, 1 ), 30.0 );
                            level.custom_vulture_aid_trigger.angles = machine.angles;
                            level.custom_vulture_aid_trigger trigger_off();


                            level.custom_vulture_aid_trigger linkto( machine );
                            playfx( level._effect[ "electric_cherry_explode" ], machine.origin );
                            //grenadeexplosionfx(machine.origin);
                            self playsound("zmb_explo");
                            earthquake( 0.8, 1, machine.origin, 500 );
                            level.custom_vulture_aid_perk Hide();
                        }
                    }

                    if (perk == "vending_sleight")
                    {
                        machine = getent( perk, "targetname" );
                        trigger = getent( perk, "target" );

                        if ( isdefined( trigger ) )
                        {
                            machine Show();
                            trigger trigger_on();
                            //machine trigger_on();
                            trigger.origin = machine.origin + vectorscale( ( 0, 0, 1 ), 30.0 );
                            trigger.angles = machine.angles;
                            trigger linkto( machine);
                    

                            level.custom_electric_trigger unlink();
                            level.custom_electric_trigger.origin = machine.origin + vectorscale( ( 0, 0, 1 ), 30.0 );
                            level.custom_electric_trigger.angles = machine.angles;
                            level.custom_electric_trigger trigger_off();


                            level.custom_electric_trigger linkto( machine );
                            playfx( level._effect[ "electric_cherry_explode" ], machine.origin );
                            //grenadeexplosionfx(machine.origin);
                            self playsound("zmb_explo");
                            earthquake( 0.8, 1, machine.origin, 500 );
                            level.custom_electric_perk Hide();
                        }
                    }

                    if (perk == "vending_jugg")
                    {
                        machine = getent( perk, "targetname" );
                        trigger = getent( perk, "target" );

                        if ( isdefined( trigger ) )
                        {
                            machine Show();
                            trigger trigger_on();
                            //machine trigger_on();
                            trigger.origin = machine.origin + vectorscale( ( 0, 0, 1 ), 30.0 );
                            trigger.angles = machine.angles;
                            trigger linkto( machine);
                    

                            level.custom_phd_flopper_trigger unlink();
                            level.custom_phd_flopper_trigger.origin = machine.origin + vectorscale( ( 0, 0, 1 ), 30.0 );
                            level.custom_phd_flopper_trigger.angles = machine.angles;
                            level.custom_phd_flopper_trigger trigger_off();

                            level.custom_phd_flopper_trigger linkto( machine );
                            playfx( level._effect[ "electric_cherry_explode" ], machine.origin );
                            //grenadeexplosionfx(machine.origin);
                            self playsound("zmb_explo");
                            earthquake( 0.8, 1, machine.origin, 500 );
                            level.custom_phd_flopper_perk Hide();
                        }
                    }
                    
                }
            } 
            else 
            {
                elevator.body.force_starting_floor = floor;
                elevator.body notify( "forcego" );
            }

        }
    }

}


elevator_key_prompt_override( player )
{

    trigs = getentarray("elevator_key_console_trigger", "targetname");


    if ( !isdefined( self.stub.elevator ) )
    {
        elevatorname = self.stub.script_noteworthy;

        if ( isdefined( elevatorname ) && isdefined( self.stub.script_parameters ) )
        {
            elevator = level.elevators[elevatorname];
            floor = int( self.stub.script_parameters );
            flevel = elevator maps\mp\zm_highrise_elevators::elevator_level_for_floor( floor );
            self.stub.elevator = elevator;
            self.stub.floor = flevel;
        }
    }

    can_use = self buildabletrigger_update_prompt( player );

    if ( can_use )
    {

        if ( self.stub.elevator maps\mp\zm_highrise_elevators::elevator_is_on_floor( self.stub.floor ) && !self.stub.elevator.body.is_moving  )
        {
           
            self sethintstring(&"ZM_HIGHRISE_CHANGE_PERK");
            thread watch_elevator_prompt_2( player, self );

        } 
        else 
        {
            self sethintstring(&"ZM_HIGHRISE_CANT_CALL_ELEVATOR");
            self trigger_off();
            thread watch_elevator_prompt( player, self );

        }
    
    }
    else
    {
        if ( self.stub.elevator maps\mp\zm_highrise_elevators::elevator_is_on_floor( self.stub.floor ) )
        {
            self sethintstring(&"ZM_HIGHRISE_CHANGE_PERK_NO_KEY");
        } else 
        {
            self sethintstring(&"ZM_HIGHRISE_CALL_ELEVATOR");
            self trigger_on();
            self waittill("trigger", player);
            self call_elevator(player);
            
        }
    }
    return can_use;
}

call_elevator( player )
{
    self playsound("zmb_elevator_ding");

    elevatorname = self.stub.script_noteworthy;

    if ( isdefined( elevatorname ) && isdefined( self.stub.script_parameters ) )
    {
        floor = int( self.stub.script_parameters );
        elevator = level.elevators[elevatorname];

        if ( isdefined( elevator ) )
        {
            elevator.body.force_starting_floor = floor;
            elevator.body notify( "forcego" );
        }
    }
}

watch_elevator_prompt( player, trig )
{
    player notify( "watch_elevator_prompt" );
    player endon( "watch_elevator_prompt" );
    trig endon( "kill_trigger" );

    while ( true )
    {
        trig.stub.elevator waittill( "floor_changed" );

        if ( isdefined( self.stub.elevator ) )
        {
            if ( trig.stub.elevator maps\mp\zm_highrise_elevators::elevator_is_on_floor( trig.stub.floor ) )
            {
                thread maps\mp\zombies\_zm_unitrigger::cleanup_trigger( trig, player );
                //trig sethintstring(&"ZM_HIGHRISE_CHANGE_PERK");
                return;
            } 
        }
    }
}

watch_elevator_prompt_2( player, trig )
{
    player notify( "watch_elevator_prompt_2" );
    player endon( "watch_elevator_prompt_2" );
    trig endon( "kill_trigger" );

    while ( true )
    {
        trig.stub.elevator waittill( "floor_changed" );

        if ( isdefined( self.stub.elevator ) )
        {
            if ( trig.stub.elevator maps\mp\zm_highrise_elevators::elevator_is_on_floor( trig.stub.floor ) )
            {
                thread maps\mp\zombies\_zm_unitrigger::cleanup_trigger( trig, player );
                return;
            }
            else 
            {
                 thread maps\mp\zombies\_zm_unitrigger::cleanup_trigger( trig, player );
                return;
            }
        }
    }
}
