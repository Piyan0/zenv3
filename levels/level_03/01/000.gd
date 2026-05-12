extends EventCommands


func _get_commands_list():
    var commands = {}
    # start from index one.
    commands[1] = func():
        await push(["black", 2])
        await push(["narator", ["lv3_intro01", "lv3_intro02", "lv3_intro03", "lv3_intro04"]])
        await push(["fade_out"])
        push(["set_iswitch", "a"])

        
    commands[2] = func():
        await push([""])
        
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
#	wait

# player ev000 ev001 ev002 ev003 ev004 ev005 ev006 ev007 ev008 ev009 ev010 ev011 ev012 ev013 ev014 ev015 ev016 ev017 ev018 ev019 ev020
# up down left right event internal_switch
# A B C D
