class_name GameConsoleCommand
extends ConsoleCommand

func _init():
    prefix = "game"
    args_rules["/v"] = {
        0 : (func(arg):
            if Bootstrap.progression.has_var(arg):
                return arg
            return null
            ),
        1 : (func(arg):
            return arg.to_int()
            ),
    }
    
    sub_commands["/v"] = func(args):
        var id = args[0]
        var value = int(args[1])
        var err= Bootstrap.progression.set_var(id, value)
        return "Variable changed"
    
    args_rules["/s"] = {
        0 : (func(arg):
            if Bootstrap.progression.has_global_switch(arg):
                return arg
            return null
            ),
        1 : (func(arg):
            if arg == "on":
                return true
            elif arg == "off":
                return false
            return null
            ),
    }
    sub_commands["/s"] = func(args): 
        var id = args[0]
        var value = args[1]
            
        var err = Bootstrap.progression.set_switch(id, value)
        return "Global switch changed"
