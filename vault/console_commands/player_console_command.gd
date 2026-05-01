class_name PlayerConsoleCommand
extends ConsoleCommand


func _init() -> void:
    var text_recc = TextReccomendation.new()
    prefix = "player"

    sub_commands["/pos"] = {
        dk_ACTION : func(args):
            if Player.instance:
                Player.instance.position = args[0],
        dk_ARGS_RULES : {
            0 : func(arg):
                var vect_str = "Vector2({0})".format([arg])
                var vect = str_to_var(vect_str)
                if vect == null:
                    return null
                return vect,
        },
    }

    sub_commands["/marker"] = {
        dk_ACTION: func(arg):
            if Player.instance:
                var pos = arg[0]
                Player.instance.position = pos,
        dk_ARGS_RULES : {
            0 : func (arg):
                var pos = Marker.get_pos(arg)
                if pos == null:
                    return null
                return pos,
        },
        dk_AUTOCOMPLETE : {
            0 : func(typed_text):
                return text_recc.get_recc(typed_text, Marker.get_keys(), 10),
        },
    }
