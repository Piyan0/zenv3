class_name SaveSystem
signal on_data_loaded(p_save_data)

var fields = {}
var slot = 4
var get_save_data = func() : return {}
var _save_dir = "res://user/save"


func _init(p_save_dir = _save_dir):
    _save_dir = p_save_dir
    var dir = DirAccess.make_dir_recursive_absolute(_save_dir)
    
    
func is_slot_saved(p_slot):
    return FileAccess.file_exists(_get_save_path(p_slot))
    

func load_data(p_slot):
    var path = _get_save_path(p_slot)
    var file = FileAccess.open(path, FileAccess.READ)
    var str_data = file.get_as_text()
    file.close()
    var save_data = JSON.parse_string(str_data)
    fields = save_data["fields"]
    on_data_loaded.emit(save_data)
    
    
func _get_save_path(save_slot):
    return _save_dir+"/save_slot_{0}.json".format([save_slot])


func save(slot):
    var path = _get_save_path(slot)
    var file = FileAccess.open(path, FileAccess.WRITE)
    var save_data = get_save_data.call()
    save_data["fields"] = fields
    file.store_string(JSON.stringify(save_data, "\t"))
    file.close()
