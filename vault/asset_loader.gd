class_name AssetLoader

var _assets= {}
func _init():
    _get_image_asset()


func get_asset(id):
    return load(_assets[id])
    
    
func _get_image_asset():
    _assets["img_screen"] = "res://assets/screen.png"
    _assets["img_icon"] = "res://icon.svg"
    
