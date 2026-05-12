class_name AssetLoader

var _assets= {}


func _init():
    _get_image_assets()
    _get_map_assets()
    _get_animation_data_assets()
    _get_script_assets()


func get_asset(id):
    assert(id in _assets, id)
    return load(_assets[id])


func has_asset(id):
    return id in _assets


func get_keys(prefix = ""):
    var keys = _assets.keys()
    return keys.filter(func(text: String):
        return text.begins_with(prefix)
    )
    

func _get_image_assets():
    _assets["img_screen"] = "res://assets/screen.png"
    _assets["img_screen_transparent"] = "res://assets/screen_transparent.png"
    _assets["img_icon"] = "res://icon.svg"
    _assets["img_fred_portrait"] = "res://assets/chloe/avatar_fred.png"
    _assets["img_chloe_portrait"] = "res://assets/chloe/avatar_chloe.png"
    _assets["img_lv1_hint_01"] = "res://assets/chloe/lv1_hint_01.png"
    _assets["img_lv1_hint_02"] = "res://assets/chloe/lv1_hint_02.png"
    _assets["img_cave_energy_placed"] = "res://assets/chloe/cave_energy_placed.png"


func _get_map_assets():
    var map_base_path = "res://levels/"
    _assets["map_piyan_room_01"] = map_base_path + "demo/piyan_room/01/piyan_room_01.tscn"
    _assets["map_piyan_room_02"] = map_base_path + "demo/piyan_room/02/piyan_room_02.tscn"
    _assets["map_piyan_room_03"] = map_base_path + "demo/piyan_room/03/piyan_room_03.tscn"
    _assets["map_level_01_01"] = map_base_path + "/level_01/01/map.tscn"
    _assets["map_level_01_02"] = map_base_path + "/level_01/02/map.tscn"
    _assets["map_level_01_03"] = map_base_path + "/level_01/03/map.tscn"
    _assets["map_level_01_04"] = map_base_path + "/level_01/04/map.tscn"
    _assets["map_level_01_05"] = map_base_path + "/level_01/05/map.tscn"
    _assets["map_level_01_06"] = map_base_path + "/level_01/06/map.tscn"
    _assets["map_level_01_07"] = map_base_path + "/level_01/07/map.tscn"

    _assets["map_road_01"] = map_base_path + "/level_02/road_01/map.tscn"
    _assets["map_road_02"] = map_base_path + "/level_02/road_02/map.tscn"
    _assets["map_bar"] = map_base_path + "/level_02/bar/map_base.tscn"

    _assets["map_level_03_01"] = map_base_path + "/level_03/01.tscn"
    

func _get_animation_data_assets():
    _assets["anim_phone"] = "res://vault/animation_data/demo/look_phone.tres"


func _get_script_assets():
    _assets["sc_lv1_puzzle"] = "res://levels/level_01/06/puzzles/puzzle_01.gd"
    _assets["sc_pretzel_minigame"] = "res://ui/pretzel_minigame/pretzel_minigame.gd"
