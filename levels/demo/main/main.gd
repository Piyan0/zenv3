extends Node2D


@export var spr: Node2D

func _process(delta: float) -> void:
    spr.position.x+= 60 * delta
