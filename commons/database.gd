class_name Database

var _items= []

func _init():
	_items= _get_items()
	if OS.is_debug_build():
		_dump(_dump_path())
		
		
func get_item(id: int):
	for i in _items:
		if i["id"] == id:
			var target_class= _target_class()
			if target_class!= null:
				var fields= i
				for j in fields.keys():
					target_class[j]= fields[j]
				return target_class
			else:
				return i
				
	assert(false, "'id' of '{0}' is not specified.".format([id]))
	return null
			
			
func path(p_path):
	return _base_path() + p_path


func _dump(p_path: String):
	var items_str= ""
	var items_display= func(id, name):
		return "({0}) {1}.\n".format([id, name])
		 
	for i in _items:
		items_str+= items_display.call(i["id"], i["name"])
	
	if !DirAccess.dir_exists_absolute(p_path.get_base_dir()):
		DirAccess.make_dir_recursive_absolute(p_path.get_base_dir())
		
	var file= FileAccess.open(p_path, FileAccess.WRITE)
	file.store_string(items_str)
	file.close()


func _dump_path():
	return "res://dump/dump_{0}_collections.txt".format([_title()])


# @virtual
# get_item() will return this TargetClass if it's not null, else, return raw dict.
# if it's overriden, make sure the class extends from TargetClass and had all properties
# defined in dictionary member of virtual _get_items().
func _target_class() -> TargetClass:
	return null


# @virtual
func _title():
	return "my_database"
	

# @virtual
func _base_path():
	return ""
	

# @virtual
func _get_items():
	var items= []
	items.push_back({
		"id": 1,
		"icon": "icon",
	})
	return items
	
	
class TargetClass:
	var id
	var name
	
