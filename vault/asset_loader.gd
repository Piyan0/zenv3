class_name AssetLoader

var _assets= {}
var _preloaded_asset = {}

# TODO add convention for dir asset we dont have to add it to dict, so asset get based on folder structure, maybe add an alias.
func _init():
    _get_image_assets()
    _get_map_assets()
    _get_animation_data_assets()
    _get_script_assets()
    _get_sound_assets()

    _load_first("bgm")


func get_asset(id):
    assert(id in _assets, id)
    if id in _preloaded_asset:
        # print("from asset")
        return _preloaded_asset[id]

    return load(_assets[id])


func has_asset(id):
    return id in _assets


func get_keys(prefix = ""):
    var keys = _assets.keys()
    return keys.filter(func(text: String):
        return text.begins_with(prefix)
    )
    

func get_asset_data():
    return _assets


func _get_image_assets():
    _assets["img_screen"] = "res://assets/screen.png"
    _assets["img_screen_transparent"] = "res://assets/screen_transparent.png"
    _assets["img_icon"] = "res://icon.svg"
    _assets["img_fred_portrait"] = "res://assets/chloe/avatar_fred.png"
    _assets["img_chloe_portrait"] = "res://assets/chloe/avatar_chloe.png"
    _assets["img_lv1_hint_01"] = "res://assets/chloe/lv1_hint_01.png"
    _assets["img_lv1_hint_02"] = "res://assets/chloe/lv1_hint_02.png"
    _assets["img_cave_energy_placed"] = "res://assets/chloe/cave_energy_placed.png"
    
    _assets["img_lv3_hint1"] = "res://assets/chloe/lv3_hint_01.png"
    _assets["img_lv3_hint2"] = "res://assets/chloe/lv3_hint_02.png"
    _assets["img_lv3_hint3"] = "res://assets/chloe/lv3_hint_03.png"
    _assets["img_lv3_hint4"] = "res://assets/chloe/lv3_hint_04.png"
    _assets["img_reds_drawing"] = "res://assets/chloe/red_glob_drawing.png"


func _get_map_assets():
    var map_base_path = "res://levels/"
    _assets["map_piyan_room_01"] = map_base_path + "demo/piyan_room/01/piyan_room_01.tscn"
    _assets["map_piyan_room_02"] = map_base_path + "demo/piyan_room/02/piyan_room_02.tscn"
    _assets["map_piyan_room_03"] = map_base_path + "demo/piyan_room/03/piyan_room_03.tscn"
    _assets["map_level_01_01"] = map_base_path + "level_01/01/map.tscn"
    _assets["map_level_01_02"] = map_base_path + "level_01/02/map.tscn"
    _assets["map_level_01_03"] = map_base_path + "level_01/03/map.tscn"
    _assets["map_level_01_04"] = map_base_path + "level_01/04/map.tscn"
    _assets["map_level_01_05"] = map_base_path + "level_01/05/map.tscn"
    _assets["map_level_01_06"] = map_base_path + "level_01/06/map.tscn"
    _assets["map_level_01_07"] = map_base_path + "level_01/07/map.tscn"

    _assets["map_road_01"] = map_base_path + "level_02/road_01/map.tscn"
    _assets["map_road_02"] = map_base_path + "level_02/road_02/map.tscn"
    _assets["map_bar"] = map_base_path + "level_02/bar/map_base.tscn"

    _assets["map_level3_1"] = map_base_path + "level_03/1.tscn"
    _assets["map_level3_2"] = map_base_path + "level_03/2.tscn"
    _assets["map_level3_3"] = map_base_path + "level_03/3.tscn"
    _assets["map_level3_4"] = map_base_path + "level_03/4.tscn"
    _assets["map_level3_5"] = map_base_path + "level_03/5.tscn"
    _assets["map_level3_6"] = map_base_path + "level_03/6.tscn"
    _assets["map_level3_7"] = map_base_path + "level_03/7.tscn"
    _assets["map_level3_8"] = map_base_path + "level_03/8.tscn"

    _assets["map_level4_1"] = map_base_path + "level_4/1.tscn"
    _assets["map_level4_2"] = map_base_path + "level_4/2.tscn"
    _assets["map_level4_3"] = map_base_path + "level_4/3.tscn"
    _assets["map_level4_4"] = map_base_path + "level_4/4.tscn"
    _assets["map_level4_5"] = map_base_path + "level_4/5.tscn"
    _assets["map_level4_6"] = map_base_path + "level_4/6.tscn"
    _assets["map_level4_7"] = map_base_path + "level_4/7.tscn"

    _assets["map_level5_1"] = map_base_path + "level5/1.tscn"
    _assets["map_level5_2"] = map_base_path + "level5/2.tscn"
    _assets["map_level5_3"] = map_base_path + "level5/3.tscn"
    _assets["map_level5_4"] = map_base_path + "level5/4.tscn"
    _assets["map_level5_5"] = map_base_path + "level5/5.tscn"
    _assets["map_level5_6"] = map_base_path + "level5/6.tscn"
    _assets["map_level5_7"] = map_base_path + "level5/7.tscn"
    _assets["map_level5_8"] = map_base_path + "level5/8.tscn"
    _assets["map_level5_9"] = map_base_path + "level5/9.tscn"
    _assets["map_level5_10"] = map_base_path + "level5/10.tscn"
    _assets["map_level5_11"] = map_base_path + "level5/11.tscn"
    

func _get_animation_data_assets():
    _assets["anim_phone"] = "res://vault/animation_data/demo/look_phone.tres"


func _get_script_assets():
    _assets["sc_lv1_puzzle"] = "res://levels/level_01/06/puzzles/puzzle_01.gd"
    _assets["sc_pretzel_minigame"] = "res://ui/pretzel_minigame/pretzel_minigame.gd"
    _assets["sc_vault_puzzle"] = "res://ui/vault_puzzle/vault_puzzle.gd"
    _assets["sc_lv3_puzzle"] = "res://ui/lv3_puzzle/lv_3_puzzle.gd"


func _get_sound_assets():
    _assets["bgm1"] = "res://assets/sounds/bgm/03 - Definitely Our Town.mp3"
    _assets["bgm2"] = "res://assets/sounds/bgm/07 - Port Town.mp3"
    _assets["bgm3"] = "res://assets/sounds/bgm/12 - Frozen Abyss.mp3"
    _assets["bgm4"] = "res://assets/sounds/bgm/19 - Where The Winds Roam.ogg"
    _assets["bgm_menu"] = "res://assets/sounds/bgm/Pixel 12.ogg"

    _assets["sfx_beep"] = "res://assets/sounds/beep.mp3"
    _assets["sfx_break"] = "res://assets/sounds/dragon-studio-glass-breaking-504033.mp3"


func _load_first(prefix):
    for i: String in _assets.keys():
        if i.begins_with(prefix):
            _preloaded_asset[i] = load(_assets[i])