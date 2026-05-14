# meta-name: EventCommandsTemplate

extends EventCommands


func _get_commands_list():
    var commands = {}
    # start from index one.
    commands[1] = func():
        push(["alpha", "player", false])
        push(["move", "chloe", ["up", "up", "up", "up", "up"]])
        await push(["wait", 0.1])
        await push(["move", "fred", ["up", "up", "up", "up", "up"]])
        push(["alpha", "fred", false])
        push(["alpha", "chloe", false])
        push(["set_iswitch", "a"])
        await push(["goto", "map_level4_2"])
        
    commands[2] = func():
        await push([""])
        
    commands[3] = func():
        push(["alpha", "player", false])
        push(["transfer", "chloe", 160, 64])
        push(["transfer", "fred", 144, 64])
        push(["move", "chloe", ["down", "down", "down", "down", "down"]])
        await push(["wait", 0.1])
        await push(["move", "fred", ["down", "down", "down", "down", "down"]])
        push(["alpha", "fred", false])
        push(["alpha", "chloe", false])
        await push(["goto", "map_level4_7", 208, 32, "down"])

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
