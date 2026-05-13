# meta-name: EventCommandsTemplate

extends EventCommands


func _get_commands_list():
    var commands = {}
    # start from index one.
    commands[1] = func():
        push(["push_dialogue", "name_blob", "lv3_extra_43"])
        push(["push_dialogue", "name_blob", "lv3_extra_42"])
        await push(["start_dialogue"])
        await push(["choices", ["ui_yes", "ui_no"], func(choice):
            if choice == 0:
                push(["push_dialogue", "name_blob", "lv3_extra_44"])
                push(["push_dialogue", "chloe", "got_item"])
                await push(["start_dialogue"])
                push(["set_switch", "got_watering_can"])
                push(["add_item", 13])
                push(["set_iswitch", "a"])
        ])
        
    commands[2] = func():
        push(["push_dialogue", "name_blob", "lv3_extra_45"])
        await push(["start_dialogue"])
        
    commands[3] = func():
        push(["erase_item", 13])
        await push(["push_dialogue", "name_blob", "lv3_extra_50"])
        await push(["push_dialogue", "name_blob", "lv3_extra_51"])
        await push(["push_dialogue", "chloe", "got_item"])
        await push(["start_dialogue"])
        await push(["wait", 1.5])
        await push(["push_dialogue", "name_blob", "lv3_extra_52"])
        await push(["push_dialogue", "name_blob", "lv3_extra_53"])
        await push(["start_dialogue"])
        push(["add_item", 6])
        push(["add_item", 12])
        push(["set_iswitch", "b"])
        push(["set_switch", "got_flower"])
    
    commands[4] = func():
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
