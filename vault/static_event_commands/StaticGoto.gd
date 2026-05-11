class_name StaticGoto
extends StaticEventCommand

@export var map_id: String
@export var spawn_pos = Vector2.ZERO
@export var direction: MapManager.Direction
@export var start_from_black = false

func _command():
    var dir_str = ""
    match direction:
        MapManager.Direction.UP:
            dir_str = "up"
        MapManager.Direction.DOWN:
            dir_str = "down"
        MapManager.Direction.LEFT:
            dir_str = "left"
        MapManager.Direction.RIGHT:
            dir_str = "right"
            
    var eva= EventPageActions.new()
    await eva.push(["goto", map_id, spawn_pos.x, spawn_pos.y, dir_str, start_from_black])
