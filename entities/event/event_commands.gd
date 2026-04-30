class_name EventCommands

var _commands= {}

func _init():
    _commands = _get_commands_list()


func get_event_commands(key : int) -> Callable:
    if key in _commands:
        return _commands[key]
    else:
        return func():
            print("this is default event commands.")


# @virtual
func _get_commands_list():
    return {}
