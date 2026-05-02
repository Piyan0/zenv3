class_name GameConsoleCommand
extends ConsoleCommand

func _init():
    prefix = "game"
    var tect_recc = TextReccomendation.new()

    sub_commands["/v"] = {
        dk_DOCS : "set var. -key -value.",
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
        dk_DOCS : "set global switch. -key -on|off.",
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

    sub_commands["/event_id"] = {
        dk_DOCS : "toggle event id preview.",
        dk_ACTION : func(args):
            for i in Engine.get_main_loop().get_nodes_in_group("events"):
                i.get_meta("toggle_id").call(),
    }

    sub_commands["/to_event"] = {
        dk_DOCS : "move player to event position. -event_id.",
        dk_ACTION : func(args):
            var event = Event.get_by_id(args[0])
            if Player.instance:
                Player.instance.position = event.global_position + Vector2(event.get_size().x, 0),
        dk_AUTOCOMPLETE : {
            0 : func(typed_text):
                return tect_recc.get_recc(typed_text, Event.get_keys(), 10),
        },
    }

    # TODO add autocomplete for map id.
    sub_commands["/goto"] = {
        dk_DOCS : "move to map. -map_id -x,y.",
        dk_ACTION : func(args):
            var map_id = args[0]
            var spawn_pos = args[1]
            var transfer_data = MapManager.PlayerTransferData.new()
            transfer_data.spawn_pos = spawn_pos
            transfer_data.map_id = map_id
            transfer_data.direction = MapManager.Direction.DOWN
            Bootstrap.map_manager.goto(transfer_data)
            ,
        dk_ARGS_RULES : {
            0 : func(arg): return arg,
            1 : func(arg):
                var vect_str = "Vector2({0})".format([arg])
                var vect = str_to_var(vect_str)
                if vect == null:
                    return null
                return vect,
        },
    }

    _dump()
    # autocomplete["/ss"] = {
    #     0 : func(text):
    #         return TextReccomendation.new().get_recc(text, ["ev000", "ev001", "ev002", "ev003", "ev004"]),
    #     1: func(typed_text):
    #         return TextReccomendation.new().get_recc(typed_text, ["A", "B", "C", "D"]),
    #     2: func(typed_text):
    #         return TextReccomendation.new().get_recc(typed_text, ["on", "off"]),
    # }
