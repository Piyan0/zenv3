extends EventCommands

func _get_commands_list():
    var commands = {}
    commands[1] = func():
        await action.push("choices",[
        ["Salwa.", "Hawa."],
        {
            0 : func():
                action.push("push_dialogue", ["Hawa", "So you don't like me?"])
                await action.push("start_dialogue")
                ,

            1: func():
                action.push("push_dialogue", ["Hawa", "See, I'm a beautiful."])
                action.push("push_dialogue", ["Hawa", "So, here we go."])
                await action.push("start_dialogue")
                ,

        }])

        # Bootstrap.progression.set_switch("my_switch", true)
    
    commands[2] = func():
        pass
    
    return commands
