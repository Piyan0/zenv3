class_name AssetLoader

var _assets= {}


func _init():
    _get_image_assets()
    _get_map_assets()
    _get_animation_data_assets()


func get_asset(id):
    return load(_assets[id])


func has_asset(id):
    return id in _assets
        

func _get_image_assets():
    _assets["img_screen"] = "res://assets/screen.png"
    _assets["img_icon"] = "res://icon.svg"


func _get_map_assets():
    var map_base_path = "res://levels"
    _assets["map_test"] = map_base_path + "/demo/main/Main.tscn"
    

func _get_animation_data_assets():
    _assets["anim_phone"] = "res://vault/animation_data/demo/look_phone.tres"
