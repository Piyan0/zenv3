@tool
extends EditorScript

var _template_content = ("""extends EventCommands


func _get_commands_list():
    var commands = {}
    # start from index one.
    commands[1] = func():
        await push(["commands_id", "args1"])
        
    commands[2] = func():
        await push([""])
        
    commands[3] = func():
        await push([""])

    return commands

# @autocomplete
#{autocomplete}
""")


var _path = "res://vault/event_commands_template"
func _run():
    DirAccess.make_dir_recursive_absolute(_path)
    for i in range(0, 13):
        _generate_template(_path, str(i).pad_zeros(3))


func _generate_template(dir, name):
    var autocomplete = _get_autocomplete()
    var file = FileAccess.open(dir+"/"+name+".gd", FileAccess.WRITE)
    file.store_string(_template_content.format({"autocomplete" : autocomplete}))
    file.close()


func _get_autocomplete():
    var arr = []
    arr.push_back(_get_actions_available())
    return (".\n".join(arr))


func _get_actions_available():
    var ac = "actions\n"
    var ev = EventPageActions.new()
    var keys = ev._actions.keys()
    for i in keys:
        ac += "#\t" + i + ".\n"
        
    return ac
