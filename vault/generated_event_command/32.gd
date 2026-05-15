# meta-name: EventCommandsTemplate

extends EventCommands


func _get_commands_list():
    var commands = {}
    # start from index one.
    commands[1] = func():
        Player.instance.get_camera().enabled = false
        # TODO reps of push, can we improve this?
        push(["transfer", "player", 0, 160])
        push(["look", "player", "right"])
        await push(["move", "player", ["right", "right", "right", "right", "right", "up", "up", "up", "right", "right", "up", "up"]])
        await push(["push_dialogue2", "ui_narator", ["lv4_end01"]])
        await push(["narator", ["lv4_end00", "lv4_end02"]])
        push(["set_iswitch", "a"])
        push(["set_switch", "going_home"])
        push(["set_switch", "chloe_session", false])
        push(["tag", "go_home"])
        await push(["goto", "map_level4_1", 0, 0, "down", true])
        
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
