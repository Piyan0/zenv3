extends EventCommands


func _get_commands_list():
    var commands = {}
    # start from index one.
    commands[1] = func():
        pass

    commands[2] = func():
        push(["alpha", event, false])
        await push(["fade_in"])
        push(["alpha", event, true])
        push(["transfer", "player", 192, 48])
        push(["look", "player", "down"])
        push(["fade_out"])
        await push(["transfer", event, 64, 160])
        await push(["move", event, ["up", "up", "up", "right", "right", "right", "right", "right", "right", "right", "right", "right"], 40])
        push(["push_dialogue", "fred", "lv2_fred_saw_chloe00"])
        await push(["start_dialogue"])

        await push(["fade_in"])
        push(["transfer", "player", 192, 48])
        await push(["wait", 2])
        push(["fade_out"])

        push(["set_iswitch", "a"])
        push(["set_switch", "bar_sit"])
        
    commands[3] = func():
        pass

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
#	move
#	fade_in
#	fade_out

# player ev000 ev001 ev002 ev003 ev004 ev005 ev006 ev007 ev008 ev009 ev010 ev011 ev012 ev013 ev014 ev015 ev016 ev017 ev018 ev019 ev020
# up down left right this
# A B C D
