extends EventCommands

func _get_commands_list():
    var commands = {}
    commands[1] = func():
        push(["push_dialogue", "Piyan", "Mending kita pake yang gini aja gak sih?"])
        await push(["start_dialogue"])
    return commands


#autocomplete
#push_dialogue
