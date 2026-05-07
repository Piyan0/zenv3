extends EventCommands


func _get_commands_list():
    var commands = {}
    # start from index one.
    commands[1] = func():
        # push(["push_dialogue", "Piyan", tr("LINE_00")])
        push(["push_dialogue", "Piyan", tr("line_01")])
        push(["push_dialogue", "Piyan", tr("line_02")])
        push(["push_dialogue", "Piyan", tr("line_03")])
        push(["push_dialogue", "Piyan", tr("line_04")])
        await push(["start_dialogue"])
        
    commands[2] = func():
        await push([""])
        
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

