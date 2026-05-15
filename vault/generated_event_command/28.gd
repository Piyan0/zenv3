# meta-name: EventCommandsTemplate

extends EventCommands


func _get_commands_list():
    var commands = {}
    # start from index one.
    commands[1] = func():
        # TODO this doesn really readable, the translation.
        await push(["push_dialogue2", "chloe", ["lv3_chloe01", "lv3_chloe02"]])
        
    commands[2] = func():
        await push(["push_dialogue2", "chloe", ["lv3_chloe03"]])
        await push(["open_inventory", func(id):
            if id == 5:
                push(["play_sfx", "sfx_break"])
                push(["set_iswitch", "a"])
                push(["erase_item"]) 
                await push(["show_image", "img_lv3_hint4"])   
                await push(["push_dialogue2", "chloe", ["lv3_chloe05", "lv3_chloe06"]])

        ])
        
    commands[3] = func():
        await push(["open_inventory", func(id):
            if id == 7:
                await push(["get_switch", "is_gasoline_placed", func(s):
                    if s:
                        push(["erase_item"])
                        push(["increment_var", "glass_box_item_used_count"])    
                        await push(["show_image", "img_lv3_hint3"])
                        push(["set_switch", "chloe_got_hint"])
                    else:
                        await push(["push_dialogue2", "chloe", ["lv3_chloe09"]])
                ])

            elif id == 6:
                push(["erase_item"])
                push(["set_switch", "is_gasoline_placed", true])
                push(["increment_var", "glass_box_item_used_count"])    
        ])
    
    commands[4] = func():
        await push(["show_image", "img_lv3_hint3"])

    commands[5] = func():
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
