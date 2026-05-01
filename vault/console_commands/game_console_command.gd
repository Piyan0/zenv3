class_name GameConsoleCommand
extends ConsoleCommand

func _init():
    prefix = "game"
    var tect_recc = TextReccomendation.new()

    sub_commands["/v"] = {
        dk_ACTION : func(args):
            var id = args[0]
            var value = int(args[1])
            var err= Bootstrap.progression.set_var(id, value),

        dk_ARGS_RULES : {
            0 : func(arg):
                if Bootstrap.progression.has_var(arg):
                    return arg
                return null,
            1 : func(arg):
                if arg == null:
                    return null
                return arg.to_int(),
        },

        dk_AUTOCOMPLETE : {
            0 : func(typed_text):
                var text_recc = TextReccomendation.new()
                var keys = Bootstrap.progression.get_var_keys()
                return text_recc.get_recc(typed_text, keys, 10),
        },
    }

    sub_commands["/s"] = {
        dk_ACTION : func(args):
            var id = args[0]
            var value = args[1]
            var err = Bootstrap.progression.set_switch(id, value),

        dk_ARGS_RULES : {
            0 : func(arg):
                if Bootstrap.progression.has_global_switch(arg):
                    return arg
                return null,

            1 : func(arg):
                if arg == "on":
                    return true
                elif arg == "off":
                    return false
                return null,
        },
        dk_AUTOCOMPLETE :{
            0 : func(typed_text):
                var text_recc = TextReccomendation.new()
                var keys = Bootstrap.progression.get_global_switch_keys()
                return text_recc.get_recc(typed_text, keys, 10),
                
            1 : func(typed_text):
                return TextReccomendation.new().get_recc(typed_text, ["on", "off"]),
        }
    }

    # autocomplete["/ss"] = {
    #     0 : func(text):
    #         return TextReccomendation.new().get_recc(text, ["ev000", "ev001", "ev002", "ev003", "ev004"]),
    #     1: func(typed_text):
    #         return TextReccomendation.new().get_recc(typed_text, ["A", "B", "C", "D"]),
    #     2: func(typed_text):
    #         return TextReccomendation.new().get_recc(typed_text, ["on", "off"]),
    # }
