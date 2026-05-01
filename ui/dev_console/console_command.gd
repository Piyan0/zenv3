class_name ConsoleCommand

enum CallResult{
    INVALID_ARGS,
    SUCCESS,
    ERR,
}

enum {
    dk_AUTOCOMPLETE,
    dk_ARGS_RULES,
    dk_ACTION,
}

var prefix = "command"

var sub_commands : Dictionary = {
    "/default" : {
        # method that will be called when this sub command is called.
        dk_ACTION : func(args) -> String:
                    print("this is default command.")
                    return "Ok.",
        # method must return null if parameter is not valid, else, the value it return will be passsed onto args with the appropriate index.
        dk_ARGS_RULES : {
            0 : func(arg_00):
                return arg_00,
        },
        # method must return all available autocomplete, with typed text it the currently typed text to help with the return. Pass this typed_text on other source.
        dk_AUTOCOMPLETE : {
            0 : func(typed_text):
                return ["auto_000", "auto_001"],
        }
    }
}

func get_autocomplete(text: String, currently_typed_text: String):
    var args = _get_arguments(text, false)
    var words = text.split(" ")
    var arg_index = args.size() - 1
    var command = is_valid(text)
    if command != null:
        var command_data = sub_commands[command]
        if dk_AUTOCOMPLETE in command_data:
            if arg_index in command_data[dk_AUTOCOMPLETE]:
                var result = command_data[dk_AUTOCOMPLETE][arg_index].call(currently_typed_text)
                return result

    return null


func is_valid(text):
    var split_commands = text.split(" ")
    if split_commands[0] == prefix:
        var sub = _get_sub_command(text)
        if !sub.is_empty():
            return sub
    
    return null


func call_action(text, command_id):
    var command_data = sub_commands[command_id]
    var args = _get_arguments(text, true)
    if dk_ARGS_RULES in command_data:
        args = _validate_args(args, command_data[dk_ARGS_RULES])
    # print(args)
    if args == null:
        return CallResult.INVALID_ARGS
        
    var result = command_data[dk_ACTION].call(args)
    return CallResult.SUCCESS


func _validate_args(args, rules):
    var validated = []
    for i in range(0, args.size()):
        if i in rules:
            var arg = rules[i].call(args[i])
            validated.push_back(arg)
            if arg == null:
                return null
        else:
            validated.push_back(args[i])
    return validated
        
        
func _get_arguments(text, fill = true):
    var split_text = text.split(" ")
    # remove base prefix.
    split_text.remove_at(0)
    
    var sub = _get_sub_command(text)
    # remove sub command.
    if !sub.is_empty():
        split_text.remove_at(split_text.find(sub))
    
    var args = []
    args.assign(split_text)
    #to avoid out of bound error.
    if fill:
        args.resize(8)
    return args
        
        
func _get_sub_command(text) -> String:
    for i in text.split(" "):
        if i in sub_commands:
            return i
    return ""
