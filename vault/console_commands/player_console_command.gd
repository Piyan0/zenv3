class_name PlayerConsoleCommand
extends ConsoleCommand


func _init() -> void:
    var text_recc = TextReccomendation.new()
    prefix = "player"
    
    sub_commands["g"] = {
        dk_DOCS : "toggle player god mode.",
        dk_ACTION : func(args):
            Player.god_mode = !Player.god_mode
    }

    sub_commands["p"] = {
        dk_DOCS : "move player to specified position. -x,y flag(--relative).",
        dk_ACTION : func(args):
            if Player.instance:
                if args[1] == "--relative":
                    Player.instance.position += args[0]
                else:
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

    sub_commands["m"] = {
        dk_DOCS : "move to marker position. -marker_id.",
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

    sub_commands["e"] = {
        dk_DOCS : "move player to event position. -event_id.",
        dk_ACTION : func(args):
            var event = Event.get_by_id(args[0])
            if Player.instance:
                Player.instance.position = event.global_position + Vector2(event.get_size().x, 0),
        dk_AUTOCOMPLETE : {
            0 : func(typed_text):
                return text_recc.get_recc(typed_text, Event.get_keys(), 10),
        },
    }
    
    _dump()
