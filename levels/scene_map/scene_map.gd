class_name SceneMap
extends Node

const source_path = "res://levels/scene_map/source.cfg"
@export var direction: MapManager.Direction

# TODO to preview we have to change the map_id. isnt that suck
# so maybe use this class only to start directly without using main menu screen.
# on production, maybe we use MapManagaer:goto() to change into game map.
func _ready():
    var transfer_data= MapManager.PlayerTransferData.new()
    transfer_data.spawn_pos= Vector2.ZERO
    transfer_data.map_id= _load_map_id()
    transfer_data.direction= direction
    await Bootstrap.map_manager.goto(transfer_data)



static func set_starting_scene(scene_id):
    var cfg = ConfigFile.new()
    cfg.load(source_path)
    cfg.set_value("Data", "starting_scene_id", scene_id)
    cfg.save(source_path)

    
func _load_map_id():
    var cfg = ConfigFile.new()
    cfg.load(source_path)
    return cfg.get_value("Data", "starting_scene_id")