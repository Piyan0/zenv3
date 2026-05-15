# meta-name: EventCommandsTemplate

extends EventCommands


func _get_commands_list():
    var commands = {}
    # start from index one.
    commands[1] = func():
        await push(["push_dialogue2", "fred", ["lv5_06"]])
        await push(["fade_in"])
        push(["transfer", "player", 160, 80])
        push(["look", "player", "down"])
        await push(["wait", 2])
        await push(["fade_out"])
        await push(["narator", ["lv5_07"]])
        await push(["move", "player", ["down"]])
        await push(["push_dialogue2", "fred", ["lv5_08", "lv5_09", "lv5_10"]])
        await push(["move", "player", ["right"]])
        await push(["look", "player", "up"])
        await push(["wait", 0.3])
        await push(["look", "player", "left"])
        await push(["wait", 0.3])
        await push(["look", "player", "down"])
        await push(["wait", 0.3])
        await push(["move", "player", ["right", "left", "left"]])
        await push(["look", "player", "down"])
        await push(["push_dialogue2", "fred", ["lv5_11", "lv5_12"]])
        push(["tag", "chloe_sleep"])
        push(["set_iswitch", "a"])
        push(["set_switch", "fred_dreaming"])

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
#	black
#	wait

# player ev000 ev001 ev002 ev003 ev004 ev005 ev006 ev007 ev008 ev009 ev010 ev011 ev012 ev013 ev014 ev015 ev016 ev017 ev018 ev019 ev020
# up down left right event internal_switch
# A B C D
