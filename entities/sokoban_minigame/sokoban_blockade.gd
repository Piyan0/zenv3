extends Area2D


@export var texture: Texture2D
@export var offset = Vector2.ZERO
@export var spr_main: Sprite2D


func _ready() -> void:
    spr_main.texture = texture
    spr_main.offset = offset

