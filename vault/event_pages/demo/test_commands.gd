extends EventCommands

func _get_commands_list():
    var commands = {}
    commands[1] = func():
        Bootstrap.progression.set_switch("my_switch", true)
    
    commands[2] = func():
        print("You've changed it.")
    
    return commands
