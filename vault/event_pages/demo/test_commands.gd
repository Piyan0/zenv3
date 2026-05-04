extends EventCommands

func _get_commands_list():
    var commands = {}
    commands[1] = func():
        var actions = EventPageActions.new()
        actions.act("push_dialogue", ["salwa", "halo piyan, gimana kabarmu?"])
        actions.act("push_dialogue", ["piyan", "Oh kabar aku baik aja kok."])
        await actions.act("start_dialogue")
        Bootstrap.progression.set_switch("my_switch", true)
    
    commands[2] = func():
        print("You've changed it.")
    
    return commands
