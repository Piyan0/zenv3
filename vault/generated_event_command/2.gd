# meta-name: EventCommandsTemplate

extends EventCommands


func _get_commands_list():
    var commands = {}
    # start from index one.
    commands[1] = func():
        await push([""])
        
    commands[2] = func():
        await push(["open_inventory", func(item_id):
            if item_id == 3:
                push(["erase_item"])
                push(["push_dialogue", "fred", "lv3_battery_placed"])
                push(["set_switch", "fred_got_key"])
                await push(["start_dialogue"])
                push(["set_iswitch", "a"])
        ])
        
    commands[3] = func():
        await Bootstrap.asset_loader.get_asset("sc_lv3_puzzle").spawn([3, 0, 1], "", func(is_correct):
            if is_correct:
                push(["add_item", 1])
                push(["add_item", 4])
                push(["set_iswitch", "b"])
                push(["push_dialogue", "fred", "got_item"])
                await push(["start_dialogue"])
        )
    
    commands[4] = func():
        push(["push_dialogue", "fred", "interact_empty"])
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
