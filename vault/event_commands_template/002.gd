extends EventCommands


func _get_commands_list():
    var commands = {}
    # start from index one.
    commands[1] = func():
        await push(["push_dialogue", "piyan", tr("line_16")])
        await push(["push_dialogue", "piyan", tr("line_17")])
        await push(["push_dialogue", "piyan", tr("line_18")])
        await push(["push_dialogue", "piyan", tr("line_19")])
        await push(["push_dialogue", "piyan", tr("line_20")])
        await push(["push_dialogue", "piyan", tr("line_21")])
        await push(["start_dialogue"])
        await push(["set_iswitch", 1, true])
        
    commands[2] = func():
        pass
        
    commands[3] = func():
        await push([""])

    return commands

# @autocomplete
#actions
#	push_dialogue.
#	start_dialogue.
#	choices.
#	open_inventory.
#	erase_item.
#	set_iswitch.
#	get_iswitch.
#	set_switch.
#	get_switch.
#	set_var.
#	get_var.
#	show_image.
#	has_item.
#	goto.
#	spawn_animation_player.
#	spawn_animation_world.

