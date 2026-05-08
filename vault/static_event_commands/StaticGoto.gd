class_name StaticGoto
extends StaticEventCommand

@export var map_id: String
@export var spawn_pos = Vector2.ZERO
@export var direction: MapManager.Direction

func _command():
    var eva = EventPageActions.new()
    eva.push(["goto", map_id, spawn_pos, direction])