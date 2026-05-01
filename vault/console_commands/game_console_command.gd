class_name GameConsoleCommand
extends ConsoleCommand

func _init():
    prefix = "game"
    
    autocomplete["/ss"] = {
        0 : (func(text):
            return TextReccomendation.new().get_recc(text, ["ev000", "ev001", "ev002", "ev003", "ev004"])
            ),
        1: (func(typed_text):
            return TextReccomendation.new().get_recc(typed_text, ["A", "B", "C", "D"])
            ),
        2: (func(typed_text):
            return TextReccomendation.new().get_recc(typed_text, ["on", "off"])
            ),
    }
    
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
    
    autocomplete["/v"] = {
        0 : (func(typed_text):
                var text_recc = TextReccomendation.new()
                var keys = Bootstrap.progression.get_var_keys()
                return text_recc.get_recc(typed_text, keys, 10)
                ),
            
        1 : (func(typed_text):
                return ["1", "2", "3"]
                ),
        
    }
    
    
    autocomplete["/s"] = {
        0 : (func(t):
                var text_recc = TextReccomendation.new()
                var keys = Bootstrap.progression.get_global_switch_keys()
                return text_recc.get_recc(t, keys, 10)
                ),
                
        1 : (func(typed_text):
                return TextReccomendation.new().get_recc(typed_text, ["on", "off"])
                ),
    }
    
    sub_commands["/ss"] = func(args):
        return "Nice."
        
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
