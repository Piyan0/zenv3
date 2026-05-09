extends EventCommands


func _get_commands_list():
	var commands = {}
	# start from index one.
	commands[1] = func():
		push(["push_dialogue", "fred", "lv1_energy_source_inspect_00"])
		await push(["start_dialogue"])
		await push(["open_inventory", func(id):
			if id == 9:
				push(["erase_item", 9])
				await push(["show_image","img_cave_energy_placed"])
				push(["push_dialogue", "fred", "lv1_energy_source_get_00"])
				await push(["start_dialogue"])
				push(["set_iswitch", "A", true])
			push(["set_switch", "energy_acquired", true])
		])
		
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
# A B C D
