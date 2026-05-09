extends EventCommands


func _get_commands_list():
    var commands = {}
    # start from index one.
    commands[1] = func():
        pass

    commands[2] = func():
        push(["push_dialogue", "chloe", "lv1_locked_door"])
        await push(["start_dialogue"])
        await push(["open_inventory", func(id):
            if id == 1:
                push(["set_iswitch", "a", true])    
                await push(["goto", "map_level_01_05", 48, 96, "right"])
        ])
        
    commands[3] = func():
        await push([""])

    return commands

# @autocomplete
#actions
#	push_dialogue
#	start_dialogue
#	choices
#	open_inventory
#	erase_item
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
#	move

# player ev000 ev001 ev002 ev003 ev004 ev005 ev006 ev007 ev008 ev009 ev010 ev011 ev012 ev013 ev014 ev015 ev016 ev017 ev018 ev019 ev020
# up down left right
