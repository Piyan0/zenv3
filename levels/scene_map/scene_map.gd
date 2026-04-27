class_name SceneMap
extends Node

@export var spawn_pos= Vector2.ZERO
@export var map_id= "map_id"
@export var direction: MapManager.Direction

func _ready():
    var fade= await TransitionBlack.spawn(true)
    print(1)
    fade.confirm()
    return
    await get_tree().create_timer(1).timeout
    var transfer_data= MapManager.PlayerTransferData.new()
    transfer_data.spawn_pos= spawn_pos
    transfer_data.map_id= map_id
    transfer_data.direction= direction
    
    await Bootstrap.map_manager.goto(transfer_data)
