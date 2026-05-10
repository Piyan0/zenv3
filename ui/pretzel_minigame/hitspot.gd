extends Node2D

@export var spr_main: Sprite2D
@export var img_hit: Texture2D

var _img_default
func _ready() -> void:
    _img_default = spr_main.texture


func get_rect():
    return Rect2(position, Vector2(7,7))


func flash():
    spr_main.texture = img_hit
    await get_tree().create_timer(0.2).timeout
    spr_main.texture = _img_default