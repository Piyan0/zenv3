class_name SceneMap
extends Node

@export var spawn_pos= Vector2.ZERO
@export var map_id= "map_id"
@export var direction: MapManager.Direction

# so maybe use this class only to start directly without using main menu screen.
# on production, maybe we use MapManagaer:goto() to change into game map.
func _ready():
    var transfer_data= MapManager.PlayerTransferData.new()
    transfer_data.spawn_pos= spawn_pos
    transfer_data.map_id= map_id
    transfer_data.direction= direction
    
    await Bootstrap.map_manager.goto(transfer_data)
