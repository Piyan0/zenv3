# meta-name: EventCommandsTemplate

extends EventCommands


func _get_commands_list():
    var commands = {}
    # start from index one.
    commands[1] = func():
        await push(["push_dialogue", "chloe", "lv3_fred_vault00"])
        await push(["start_dialogue"])
        
    commands[2] = func():
        await Bootstrap.asset_loader.get_asset("sc_vault_puzzle").spawn([9, 4, 2, 1], "", func(is_correct):
            if is_correct:
                await push(["push_dialogue", "chloe", "got_item"])
                await push(["start_dialogue"])
                push(["set_switch", "chloe_got_key"])
                push(["add_item", 4]) 
                push(["add_item", 1]) 
                push(["set_iswitch", "a"])
        )
        
    commands[3] = func():
        push(["push_dialogue", "chloe", "interact_empty"])
        await push(["start_dialogue"])

    return commands

# @autocomplete
#actions
#	narator
#	push_dialogue
#	start_dialogue
#	choices
#	open_inventory
#	erase_item
#	add_item
#	set_iswitch
#	get_iswitch
#	set_switch
#	get_switch
#	set_var
#	get_var
#	increment_var
#	show_image
#	has_item
#	goto
#	spawn_animation_player
#	spawn_animation_world
#	transfer
#	look
#	alpha
#	move
#	fade_in
#	fade_out
#	black
#	wait

# player ev000 ev001 ev002 ev003 ev004 ev005 ev006 ev007 ev008 ev009 ev010 ev011 ev012 ev013 ev014 ev015 ev016 ev017 ev018 ev019 ev020
# up down left right event internal_switch
# A B C D
