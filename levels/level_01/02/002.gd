extends EventCommands


func _get_commands_list():
    var commands = {}
    # start from index one.
    commands[1] = func():
        pass
        
    commands[2] = func():
        await push(["choices", ["ui_yes", "ui_no"], func(id):
            if id == 0:
                await push(["narator", [
                    tr("lv1_story_fred_use_hoverboard_01"),
                    tr("lv1_story_fred_use_hoverboard_02"),
                    tr("lv1_story_fred_use_hoverboard_03"),
                ]])
                push(["set_iswitch", "A", true]) 
                push(["set_switch", "chloe_session", true])
                await push(["goto", "map_level_01_01", 0, 0, "down", true])
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
