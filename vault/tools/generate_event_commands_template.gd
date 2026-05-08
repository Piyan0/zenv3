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
var generate_amount = 1
func _run():
    var path = EditorInterface.get_selected_paths()
    if path.is_empty():
        print("please select a directory target for event template.")
        return
    var dir_exists = DirAccess.dir_exists_absolute(path[0])
    if dir_exists:
        for i in range(0, generate_amount):
            _generate_template(path[0], str(i).pad_zeros(3))


func _generate_template(dir, name):
    var autocomplete = _get_autocomplete()
    var path = dir+name+".gd"
    if FileAccess.file_exists(path):
        print("event template already existed at path '{0}', aborting.".format([path]))
        return
    var file = FileAccess.open(path, FileAccess.WRITE)
    file.store_string(_template_content.format({"autocomplete" : autocomplete}))
    file.close()
    print("generated event template at path '{0}', aborting.".format([path]))


func _get_autocomplete():
    var arr = []
    arr.push_back(_get_actions_available())
    arr.push_back("# player ev000 ev001 ev002 ev003 ev004 ev005 ev006 ev007 ev008 ev009 ev010 ev011 ev012 ev013 ev014 ev015 ev016 ev017 ev018 ev019 ev020")
    arr.push_back("# up down left right")
    return ("\n".join(arr))


func _get_actions_available():
    var ac = "actions\n"
    var ev = EventPageActions.new()
    var keys = ev._actions.keys()
    for i in keys:
        ac += "#\t" + i + "\n"
        
    return ac
