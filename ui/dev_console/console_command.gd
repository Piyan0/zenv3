class_name ConsoleCommand

var msg = ""
var prefix = "command"
var action = func(args): print("this is command.")


var autocomplete = {
    "/sub" : {
        0 : func(typed_text): return ["auto_01", "auto_02"]
    }
}

var sub_commands : Dictionary[String, Callable] = {
    "/sub" : func(args) -> String:
        print("this is sub command.")
        return "Ok."
}

var args_rules= {
    "/sub" : {
        0 : func(arg): return arg
    }
}

var _commands_path = ""


func get_autocomplete(text):
    var args = _get_arguments(text, false)
    var words = text.split(" ")
    var currently_typed_text = words[-1]
    var current_arg_index = args.size() - 1
    var valid = _is_valid(text)
    if valid:
        if _commands_path in autocomplete:
            if current_arg_index in autocomplete[_commands_path]:
                var result = autocomplete[_commands_path][current_arg_index].call(currently_typed_text)
                return result
    return null


func _is_valid(text):
    var split_commands = text.split(" ")
    if split_commands[0] == prefix:
        var sub = _get_sub_command(text)
        if !sub.is_empty():
            _commands_path = sub
            return true
    
    if prefix in text:
        _commands_path = prefix
        return true
    
    return false
    
    
# TODO refactor this method.
func is_valid(text):
    var split_commands = text.split(" ")
    if split_commands[0] == prefix:
        var sub = _get_sub_command(text)
        var args = _get_arguments(text)
        if !sub.is_empty():
            if sub in args_rules:
                args = _validate_args(args, args_rules[sub])
                if args == null:
                    msg = "Err. Invalid Arguments"
                    return true
            var msg_result = sub_commands[sub].call(args)
            if msg_result != null:
                msg = msg_result
            return true
        else:
            if action in args_rules:
                args = _validate_args(args, args_rules[sub])
                if args == null:
                    msg = "Err. Invalid Arguments"
                    return true
                    
            var msg_result = action.call(args)
            if msg_result != null:
                msg = msg_result
            return true
        
    return false


func get_msg():
    set_deferred("msg", "")
    return msg


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
    # remove prefix.
    split_text.remove_at(0)
    
    var sub = _get_sub_command(text)
    # remove sub command.
    if !sub.is_empty():
        split_text.remove_at(split_text.find(sub))
    
    #to avoid out of bound error.
    if fill:
        split_text.resize(8)
    return split_text
        
        
func _get_sub_command(text) -> String:
    for i in text.split(" "):
        if i in sub_commands:
            return i
    return ""
