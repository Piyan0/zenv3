extends EventCommands


func _get_commands_list():
    var commands = {}
    # start from index one.
    commands[1] = func():
        pass
        # await push(["commands_id", "args1"])
        
    commands[2] = func():
        push(["alpha", "player",  false])
        push(["transfer", "player",  256, 112])

        await push(["push_dialogue", "chloe", "lv2_bar_chloe_and_fred01"])
        await push(["push_dialogue", "chloe", "lv2_bar_chloe_and_fred02"])
        await push(["push_dialogue", "chloe", "lv2_bar_chloe_and_fred03"])
        await push(["push_dialogue", "fred", "lv2_bar_chloe_and_fred04"])
        await push(["push_dialogue", "chloe", "lv2_bar_chloe_and_fred05"])
        await push(["push_dialogue", "chloe", "lv2_bar_chloe_and_fred06"])
        await push(["push_dialogue", "fred", "lv2_bar_chloe_and_fred07"])
        await push(["push_dialogue", "fred", "lv2_bar_chloe_and_fred08"])
        await push(["push_dialogue", "chloe", "lv2_bar_chloe_and_fred09"])
        await push(["push_dialogue", "fred", "lv2_bar_chloe_and_fred10"])
        await push(["push_dialogue", "fred", "lv2_bar_chloe_and_fred11"])
        await push(["push_dialogue", "chloe", "lv2_bar_chloe_and_fred12"])
        await push(["start_dialogue"])
        await push(["fade_in"])
        push(["fade_out"])
        await Bootstrap.asset_loader.get_asset("sc_pretzel_minigame").spawn()

        push(["set_iswitch", "a", true])
        
    commands[3] = func():
        await push([""])

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

# player ev000 ev001 ev002 ev003 ev004 ev005 ev006 ev007 ev008 ev009 ev010 ev011 ev012 ev013 ev014 ev015 ev016 ev017 ev018 ev019 ev020
# up down left right event internal_switch
# A B C D
