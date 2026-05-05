extends EventCommands

func _get_commands_list():
    var commands = {}
    commands[1] = func():
        await push(["open_inventory", func(item_id):
            print(item_id)
        ])
    
    commands[1] = func():
        await push(["push_dialogue", "Godot", "Which one would you pick??"])
        await push(["start_dialogue"])
        await push(["choices", ["Manyssa", "Qeisya."],
            func(index):
                if index == 0:
                    push(["push_dialogue", "Godot", "So you like Manyssa?"]) 
                    await push(["start_dialogue"])
                elif index == 1:
                    push(["push_dialogue", "Godot", "She's beautiful..."]) 
                    await push(["start_dialogue"])
        ])
        push(["set_switch", "my_switch", true])
        # Bootstrap.progression.set_switch("my_switch", true)
    
    commands[2] = func():
        await push(["get_var", "my_var", func(value):
            print(value)
        ])
    
    return commands
