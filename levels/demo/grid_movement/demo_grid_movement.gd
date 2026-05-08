extends Node2D

@export var x: Sprite2D

var grid : GridMovement
func _ready() -> void:
    grid = GridMovement.new(x)
    grid.repeat = true
    grid.routes = [
        Vector2.RIGHT,
        Vector2.RIGHT,
        Vector2.RIGHT,
        Vector2.RIGHT,
        Vector2.DOWN,
    ]

