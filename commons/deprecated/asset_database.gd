enum {
    IMAGE = 0,
    MAP = 1,
    BGM = 2,
    SFX = 3,
    ANIMATION_DATA = 4,
}

var db_base_dir= ""
var _category= []
var _data= {}
var _db_files= [
    "/image.cfg",
    "/map.cfg",
    "/bgm.cfg",
    "/sfx.cfg",
    "/animation_data.cfg",
]

func _init(p_base_dir):
    db_base_dir= p_base_dir
    _data= _sources_to_json()
    #print(_data)


func has_asset(type = IMAGE, id = ""):
    return id in _data[str(type)]


func get_asset(type= IMAGE, id= ""):
    assert(id in _data[str(type)], id)
    var asset= load(_data[str(type)][id])
    return asset


func _sources_to_json():
    var data= {}
    for i in _db_files:
        var cfg_path= db_base_dir + i
        var cfg= ConfigFile.new()
        cfg.load(cfg_path)
        var json= _to_json(cfg)
        data.merge(json)
    return data


func _to_json(cfg: ConfigFile):
    var r= {}
    for section in cfg.get_sections():
        if !section in _data:
            r[section]= {}
        for key in cfg.get_section_keys(section):
            r[section][key]= cfg.get_value(section, key)
    return r
        
