# meta-name: EventCommandsTemplate

extends EventCommands


func _get_commands_list():
    var commands = {}
    # start from index one.
    commands[2] = func():
        push(["alpha", "player", false])
        push(["transfer", "player", 80, 64])
        await push(["move", "chloe", ["right", "right"]])
        push(["look", "chloe", "left"])
        await push(["wait", 0.6])
        push(["alpha", "player", true])
        await push(["move", "player", ["right"]])
        # TODO add cb when move is finished.
        await push(["move", "chloe", ["down", "down", "right", "right", "up"]])
        push(["alpha", "chloe", false])
        push(["transfer", "chloe", INF, INF])
        push(["tag", "chloe_sit"])
        push(["set_iswitch", "a"])
        
    commands[3] = func():
        await push([""])
        
    commands[4] = func():
        await push(["fade_in"])
        await push(["fade_out"])
        push(["transfer", "player", 96, 112])
        await push(["move", "player", ["down"]])
        push(["look", "player", "right"])
        await push(["wait", 0.2])
        push(["look", "player", "up"])
        await push(["move", "chloe_sit", ["down", "left", "left", "left", "down"]])
        push(["move", "player", ["down", "down"], 30, func():
            push(["alpha", "player", false])    
        ])
        await push(["move", "chloe_sit", ["down", "down", "down"], 30, func():
            push(["alpha", "chloe_sit", false])
        ])
        push(["rtag", "chloe_awake"])
        await push(["goto", "map_level5_11", 32, 176, "up"])

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
